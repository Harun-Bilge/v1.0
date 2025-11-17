# Vertigo Games – Data Analyst Case (Task 1)

This folder contains my solution for **Task 1** of the Vertigo Games Data Analyst Case.  
I used **SQL** to simulate an A/B test between Variant A and Variant B and to answer questions **(a–f)**.

---

## 1. Goal

- Simulate **30 days** of player behavior for two variants.  
- Track **retention, installs, DAU, and revenue (IAP + Ads)**.  
- Compare variants under three setups:
  1. Base case (no sale)  
  2. 10-day sale (Day 15–25)  
  3. New user source added from Day 20

---

## 2. Inputs and Parameters

Defined in `02_parameters.sql`:

- Retention anchors at **D1, D3, D7, D14** for each variant  
- **Purchase_rate** (IAP conversion)  
- **eCPM** (ad revenue per 1000 impressions)  
- **Ad_impressions per DAU**

Daily installs in `04_daily_installs.sql`:

- Base case: **20,000 installs per day** from a single user source.

---

## 3. Modeling Steps

### 3.1 Days

`01_day_creation.sql`  
Creates a simple day table for **Day 1–30**.

### 3.2 Retention Curve

`03_interpolation.sql`

- Builds a **daily retention curve** by linear interpolation between the anchor days.  
- Keeps retention **flat after Day 14** (no further decay modeled).

### 3.3 DAU

`05_DAU_calculation.sql`

- Computes **DAU** as:  
  `DAU = installs × retention`.

### 3.4 Base Revenue (No Sale)

`06_revenue_prepare.sql` and `07_revenue_calculation.sql`

- Joins DAU with purchase rate, eCPM, and ad impressions.  
- For each day and variant:
  - `iap_revenue = dau × purchase_rate`
  - `ad_revenue = dau × ad_impressions × eCPM / 1000`
  - `total_revenue = iap_revenue + ad_revenue`
- Output table: `dbo.revenue` (used for **(b)** and **(c)**).

### 3.5 Sale Scenario (Day 15–25)

`08_sale_revenue_prepare.sql` and `09_sale_revenue_calculation.sql`

- Uses the **same DAU** as the base case.  
- Between **Day 15–25**, increases `purchase_rate` by **+0.01**.  
- Recomputes IAP + Ads with this boosted rate.  
- Output table: `dbo.revenue_sale` (used for **(d)**).

### 3.6 New User Source (From Day 20)

Separate pipeline for **(e)** and **(f)**.

1. **Installs** – `11_new_source_installs.sql`  
   - Day 1–19: new source has **0 installs**.  
   - Day 20–30: new source has **8,000 installs per day**.

2. **New Source Retention** – `12_new_source_retention.sql`  
   Uses the formulas from the case:

   - A (new): `0.58 * EXP(-0.12 * (day - 1))`  
   - B (new): `0.52 * EXP(-0.10 * (day - 1))`

3. **New Source DAU** – `13_new_source_DAU.sql`  
   - `new_source_dau = new_installs × new_source_retention`.

4. **Adjust Old Source DAU** – inside `14_new_source_revenue_prepare.sql`  
   - Old source DAU comes from `dbo.dau`.  
   - **Before Day 20**: old source DAU stays the same (20k installs).  
   - **From Day 20**: old source DAU is scaled by **0.6**  
     (because old source drops from 20k to **12k = 20k × 0.6**).

5. **Combine Sources + Revenue** – `14_new_source_revenue_prepare.sql` and `15_new_source_revenue_calculation.sql`  
   - `total_dau = adjusted_old_dau + new_source_dau`  
   - Uses the **base** purchase rate, eCPM, and ad impressions (no sale here).  
   - Output table: `dbo.new_revenue` (used for **(e)** and **(f)**).

### 3.7 Result Queries

- `10_results.sql` → answers **(a–d)**  
- `16_new_source_results.sql` → answers **(e–f)**

---

## 4. Assumptions

- Retention, purchase rate, eCPM, and ad impressions are **constant** over the 30 days, except:
  - The **sale** changes purchase rate by +1% on Days 15–25.  
  - The **new source** appears only from Day 20 and has its own retention curve.
- All installs are independent; there is no seasonality or cohort-level interaction.  
- Revenue is fully attributed to the **day it happens**.  
- No extra costs (marketing, infra, etc.) are included, only **gross revenue**.  
- All calculations are done at **daily aggregate** level.

---

## 5. Results (Task 1 a–f)

### (a) Day 15 DAU

| Variant | DAU  |
|--------|------|
| A      | 1200 |
| B      | **1800** |

> **Winner (DAU)**: **B**

B keeps more players active by Day 15.

---

### (b) Total Revenue Until Day 15 (Base, No Sale)

| Variant | Total Rev (Day 1–15, base) |
|--------|-----------------------------|
| A      | **3012.67**                 |
| B      | 2892.65                     |

> **Winner (1–15 revenue)**: **A**

In the short term, A earns slightly more.  
This comes from **higher ad impressions per DAU**, while purchase rates are very close.

---

### (c) Total Revenue Until Day 30 (Base, No Sale)

| Variant | Total Rev (Day 1–30, base) |
|--------|-----------------------------|
| A      | 3967.39                     |
| B      | **4209.71**                 |

> **Winner (1–30 revenue, base)**: **B**

Over 30 days, B’s **better retention** makes up for its lower ad impressions and leads to more total revenue.

---

### (d) Total Revenue Until Day 30 with 10-Day Sale

| Variant | Total Rev (Day 1–30, with sale) |
|--------|----------------------------------|
| A      | 4099.39                          |
| B      | **4407.71**                      |

> **Winner (1–30 revenue, sale)**: **B**  
> The sale **raises revenue for both variants**, but B stays ahead.

---

### (e) New User Source (12k Old + 8k New from Day 20)

In this setup:

- Total installs per day remain **20,000**.  
- From Day 20:
  - **12,000** installs from the original source (better-known retention).  
  - **8,000** installs from the new source (given exponential retention curves).  
- No sale is applied here.

**Total revenue Day 1–30 (new source scenario):**

| Variant | Total Rev (Day 1–30, new source) |
|--------|-----------------------------------|
| A      | 3850.48                           |
| B      | **4036.15**                       |

**Revenue only for Day 20–30 (new source scenario):**

| Variant | Rev (Day 20–30, new source) |
|--------|------------------------------|
| A      | 583.22                       |
| B      | **792.28**                   |

> **Winner in this scenario**: **B** again.  
> However, both variants make **less** total revenue than in the base case,  
> which means the new source **lowers the average user quality**.

---

### (f) Which Change is Better?

Comparing:

- **10-day sale (Day 15–25)** vs. **new user source (from Day 20)**

Findings:

- The **sale** clearly increases revenue for both variants compared to the base case.  
- The **new user source** slightly **reduces** overall revenue, even though B still beats A within that scenario.  
- The new source adds volume, but its retention is not strong enough to improve total monetization.

**Decision:**  
If I can only pick one improvement to ship, I would choose the **10-day sale**.  
It gives a clean, measurable uplift on top-line revenue, while the new source (with these parameters) does not justify changing the traffic mix.

---

## 6. File Structure

```text
/task1
    README.md
    /sql
        00_table_drops.sql
        01_day_creation.sql
        02_parameters.sql
        03_interpolation.sql
        04_daily_installs.sql
        05_DAU_calculation.sql
        06_revenue_prepare.sql
        07_revenue_calculation.sql
        08_sale_revenue_prepare.sql
        09_sale_revenue_calculation.sql
        10_results.sql
        11_new_source_installs.sql
        12_new_source_retention.sql
        13_new_source_DAU.sql
        14_new_source_revenue_prepare.sql
        15_new_source_revenue_calculation.sql
        16_new_source_results.sql
```
