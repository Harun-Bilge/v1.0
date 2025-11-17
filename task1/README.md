# v1.0

# Vertigo Games – Data Analyst Case (Task 1)

This repo includes my solution for **Task 1** of the Vertigo Games Data Analyst Case.  
I built a full A/B test simulation using SQL, following the structure requested in the case PDF.  
All scripts are modular, clean, and fully reproducible.

---

## Purpose

Model the 30-day behavior of Variant A and Variant B using:

- retention  
- daily installs  
- DAU  
- monetization (IAP + Ads)

Then answer all questions (a–f) with clear outputs.

---

## Methodology

### 1. Day Table

`01_day_creation.sql`  
Generates days 1–30.

### 2. Parameters

`02_parameters.sql`  
Retention anchors (D1, D3, D7, D14), purchase rate, eCPM, ad impressions.

### 3. Retention Model

`03_interpolation.sql`  
Linear interpolation between anchor points.  
Flat tail after Day 14.

### 4. Daily Installs

`04_daily_installs.sql`  
Base case: 20,000 installs per day.

### 5. DAU Calculation

`05_DAU_calculation.sql`  
DAU = installs × retention.

### 6. Sale Effect

`06_revenue_prepare.sql`  
Purchase rate +1% between Days 15–25.

### 7. Revenue Calculation

`07_revenue_calculation.sql`  
IAP + Ad revenue combined.

### 8. Final Results

`08_results.sql`  
Answers for Task 1 (a–d).

---

## New User Source (Task 1e–f)

Starting Day 20:

- 12,000 users from the old source  
- 8,000 from a new source  

New retention formulas (given in the case):

- A: 0.58 · e^(−0.12(x−1))  
- B: 0.52 · e^(−0.10(x−1))

Scripts:  
`09_new_source_installs.sql` → `14_new_source_results.sql`


---

## Task 1 – Key Results

### a) Day 15 DAU — Winner: B

| Variant | DAU  |
|---------|------|
| A       | 1200 |
| B       | **1800** |

---

### b) Revenue Until Day 15 — Winner: A

A wins early because of higher ad impressions.

| Variant | Total Rev (1–15) |
|---------|------------------|
| A       | **3024.67**      |
| B       | 2910.65          |

---

### c) Revenue Until Day 30 — Winner: B

Better retention gives B long-term advantage.

| Variant | Total Rev (1–30) |
|---------|------------------|
| A       | 4099.39          |
| B       | **4407.71**      |

---

### d) 10-Day Sale — Winner Stays the Same: B

Sale affects both variants equally.  
Trend doesn’t change.

---

### e) New User Source — Winner: B

B’s new retention curve decays slower → stronger DAU after Day 20.

| Variant | Total Rev with New Source (1–30) |
|---------|----------------------------------|
| A       | 9531.82                          |
| B       | **9653.09**                      |

Day 20–30 revenue also favors B:

| Variant | Rev (20–30) |
|---------|-------------|
| A       | 1233.84     |
| B       | **1679.53** |

---

### f) Which improvement is more valuable?

**Answer: The new user source.**

**Reason:**
- The sale is temporary.  
- The new user source is permanent and grows the DAU base.  
- Higher retention = long-term revenue.  
- This is more important for a live game.

---

## Repository Structure

```
/task1
    /sql
        00_table_drops.sql
        01_day_creation.sql
        02_parameters.sql
        03_interpolation.sql
        04_daily_installs.sql
        05_DAU_calculation.sql
        06_revenue_prepare.sql
        07_revenue_calculation.sql
        08_results.sql
        09_new_source_installs.sql
        10_new_source_retention.sql
        11_new_source_DAU.sql
        12_new_source_revenue_prepare.sql
        13_new_source_revenue_calculation.sql
        14_new_source_results.sql
```

---

