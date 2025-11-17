# README – Task 2

## Exploratory Analysis on User Engagement, Revenue, and Behavioral Trends
*(Long-form, detailed, fully professional yet simple language)*

---

## 1. Purpose of Task 2

The goal of this analysis was to understand how players behave in the early days of the game and how their engagement connects to long-term retention and revenue.

I wanted to go beyond simple aggregates, so I segmented users, tracked daily activity patterns, measured session fatigue, and compared revenue contributions across different segments and countries.

To do this, I used:

- SQL views for modular data transformation  
- Power BI dashboards for visual exploration  
- Python for some quick checks and consistency validation  

My focus was to build a structure that could easily scale into deeper cohort or funnel analysis.

---

## 2. Dataset Overview

The dataset contains daily summaries for each player.  
Fields include platform, country, gameplay counts, session durations, install dates, and monetization metrics (IAP + Ads).

This structure allowed me to:

- Group users by early behaviors  
- Follow their session trends  
- Analyze retention patterns  
- Understand revenue contribution by behavior segment and geography  

---

## 3. Folder Structure & File Contents

Below is the folder structure I used for Task 2:

```
/task2
    /sql
        vw_country_revenue.sql
        vw_daily_activity_by_segment.sql
        vw_first_day_conversion.sql
        vw_revenue_by_segment.sql
        vw_session_fatigue_analysis.sql
        vw_user_segments.sql

    /python
        01_data_cleaning.ipynb
        02_feature_engineering.ipynb
        03_exploratory_analysis.ipynb

    /images
        firstpage.png
        secondpage.png
        thirdpage.png
```

---

## 4. Python

Python was the first layer of the analysis pipeline.  
I used it for **cleaning**, **feature engineering**, and **quick diagnostic visuals** before creating SQL views and Power BI dashboards.

**Directories:**

```markdown
/python
    - 01_data_cleaning.ipynb
    - 02_feature_engineering.ipynb
    - 03_exploratory_analysis.ipynb

/images
    - revenuebysegment.png
    - heatmap.png
    - avgsessionduration.png
    - sessiondistribution.png
```

---

### 1. Data Cleaning

**Notebook:** `01_data_cleaning.ipynb`  
**Purpose:** Make the raw dataset consistent and usable.

- Fixed column types (dates, ints, floats)  
- Replaced missing revenue with zero  
- Removed invalid rows (negative durations, 0 sessions + long duration)  
- Exported a clean dataset for SQL  

**Visual Check:**  
![Session Distribution](./images/sessiondistribution.png)
First-day session counts are extremely skewed (most players play 1–2 sessions).  
This confirmed that segmentation was necessary.

---

### 2. Feature Engineering

**Notebook:** `02_feature_engineering.ipynb`  
**Purpose:** Create fields needed for segmentation and revenue analysis.

**Key engineered fields:**

- `engagement_segment` (low / mid / high)  
- `total_revenue` (iap + ads)  
- Day-1 flags  
- Avg duration per session  

**Visual Check:**  
![Revenue By Segment](./images/revenuebysegment.png)
High segment has the strongest IAP revenue per user.  
Mid is moderate; low is very low.  
This validated the segmentation logic.

---

### 3. Early Exploratory Analysis

**Notebook:** `03_exploratory_analysis.ipynb`  
**Purpose:** Validate behavioral patterns before Power BI dashboards.

**Visuals Used:**

#### a) Session Fatigue  
![Average Session Duration](./images/avgsessionduration.png)
Session duration decreases over time for all segments.  
High segment remains most stable.

#### b) Country Revenue Distribution  
![Heatmap](./images/heatmap.png)
A few countries dominate revenue; long tail contributes very little.  
Matches SQL country revenue view.

---

### 4. Why Python Was Necessary

- Ensured data quality before SQL transformations  
- Validated segment rules  
- Confirmed session fatigue and monetization patterns  
- Produced fast visuals that guided the Power BI dashboard design  

Python → SQL → Power BI flow kept the analysis structured and reproducible.

---

## 5. SQL Layer
---

### 5.1 vw_country_revenue.sql

**Purpose:**  
Shows the revenue contribution of each country.

**Why it matters:**  
This reveals regional disparities and highlights where high-value users are located.

**Columns:** total IAP, total Ads, combined revenue.  
This view is the backbone of my geographical analysis.

---

### 5.2 vw_user_segments.sql

**Purpose:**  
Assign each user into an engagement segment based on first-day session counts.

**Why it matters:**  
Early engagement is one of the strongest predictors of lifetime value.  
This segmentation allows clean comparisons across behavior groups.

---

### 5.3 vw_first_day_conversion.sql

**Purpose:**  
Connect first-day engagement to lifetime revenue.

**Why it matters:**  
I wanted to see whether players who play more on Day 1 also tend to pay more later.  
This view helped me build the foundation for conversion-related insights.

---

### 5.4 vw_daily_activity_by_segment.sql

**Purpose:**  
Track how each engagement segment behaves day by day.

**It includes:**

- DAU  
- Total sessions  
- Total session duration  
- Match starts / ends  
- Victory / defeat counts  

**Why it matters:**  
This view allows examining not just total revenue but how their activity evolves over time.  
It feeds directly into session fatigue and retention insights.

---

### 5.5 vw_session_fatigue_analysis.sql

**Purpose:**  
Measure the decay of average session duration over time.

**Why it matters:**  
Every mobile game experiences session fatigue.  
Understanding when players begin to drop off helps in pacing content and difficulty.

---

### 5.6 vw_revenue_by_segment.sql

**Purpose:**  
Break down total revenue generated by each engagement segment.

**Why it matters:**  
It provides a clean comparison of low-engagement vs high-engagement users.  
This view also supports my monetization insights in Power BI.

---

## 6. Dashboard Pages & Interpretations

---

# Dashboard Page 1 – Overall Activity & Engagement Trends  
**(firstpage.png)**

![Global scale & natural decay](./images/firstpage.png)

### What This Page Shows

This page gives a high-level view of the entire player base and core activity metrics.  
It includes:

- **7M Total Users**
- **146K Total Ad Revenue**
- **1.08M Total Revenue (IAP + Ads)**
- **13M Total Sessions**
- **1.85K Avg Session Duration (seconds)**

And two key trend lines:

- **DAU over time**
- **Total sessions over time**

---

### Insights from the Trends

1. **DAU declines steadily from ~290K to ~210K**  
   The downward trend is smooth and without sharp drops. This suggests natural engagement decay rather than a system issue.

2. **Total sessions follow the same decline pattern**  
   Sessions drop from ~500K to ~380K.  
   This parallel movement means the decline comes from churn, not from changes in per-user behavior.

3. **The engagement curve is healthy for a casual F2P title**  
   The decay is gradual, not abrupt.  
   No indicators of server issues or balance-breaking events.

4. **Session duration remains stable**  
   The 1.85K-second average shows that active players keep playing meaningfully long sessions even as DAU shrinks.

---

### Interpretation

This page establishes the baseline:  
The game has strong volume, predictable natural decay, and consistent player behavior.  
It sets the foundation for deeper segmentation in the following pages.

---

# Dashboard Page 2 – First-Day Engagement Segments  
**(secondpage.png)**

![Who the players are](./images/secondpage.png)

### What This Page Shows

This page breaks users into **low**, **mid**, and **high** engagement segments based on first-day session count and duration. It focuses on **Day 1 behavior**, showing comparisons in:

- Total users  
- Average first-day duration  
- Average first-day sessions  
- First-day victories  
- Total revenue (IAP + Ads)  

---

### Insights (Directly From Your Graphs)

#### 1. Segment Size Is Extremely Skewed

- **Low segment = 96.9%** of players  
- **Mid segment = tiny minority**  
- **High segment = even smaller**

This imbalance shows massive opportunity in onboarding.  
Even a small upward shift in the low segment increases total revenue significantly.

---

#### 2. Engagement Differences Are Dramatic

- High segment users spend **4–6× longer** on Day 1  
- They play **3–4× more sessions**  
- They collectively win **10M+ Day-1 matches**

This proves early engagement predicts long-term value strongly.

---

#### 3. Monetization Concentrates at the Top

- **Low segment** generates the most *total IAP revenue* simply due to scale  
- **High segment** generates the *most revenue per user* despite small size  
- Ad revenue shows the same pattern:  
  Higher engagement → more stability → more impressions  

→ Classic F2P pattern: *a small, highly engaged group drives most real value*

---

#### 4. Mid Segment Signals the Biggest Opportunity

Mid users play multiple sessions but not as intensely as high users.  
They show:

- Solid session duration  
- Active gameplay  
- Non-trivial revenue  

→ This group should be targeted for retention design and personalized nudges.

---

### Interpretation

This page reveals the structural behavior of the player base.  
**Day 1 behavior fully predicts long-term performance.**  
Low users = onboarding opportunity.  
High users = core gamers.  
Mid users = biggest leverage for retention.

---

# Dashboard Page 3 – Session Fatigue & Segment Behavior Over Time  
**(thirdpage.png)**

![How they behave over time](./images/thirdpage.png)

### What This Page Shows

This page compares how session duration and total sessions evolve for each segment over time.

Two charts:

1. **Average session duration over time** (high vs mid vs low)  
2. **Total sessions over time** (high vs mid vs low)

Each chart is annotated with decay and stability insights.

---

### Insights (Directly From Your Graphs)

#### 1. High Segment Sustains the Longest Sessions

- 2–3× longer session durations  
- Slow and controlled decay  
- Stability makes them the best base for long-term retention  

---

#### 2. Mid Segment Shows Meaningful Decay

- Sharp activity drop after early days  
- Fluctuating and downward trend  
- Most sensitive to friction and pacing  

→ If one segment needs optimization, **it's mid**.

---

#### 3. Low Segment Is Flat and Weak

- No improvement in session duration  
- Flat activity line  
- Onboarding issue, not gameplay issue  

---

#### 4. Total Sessions Mirror the Same Pattern

- Low: high total sessions due to massive size  
- Mid: noticeable early decay  
- High: stable loops with predictable dips  

High users show the strongest emotional commitment.

---

### Interpretation

All segments experience fatigue but to different degrees.  
Mid segment is the best target for retention improvements.  
High segment is stable; low segment needs onboarding fixes.

---

## 7. Methodology

My workflow combines **Python**, **SQL**, and **Power BI** as a structured pipeline.  
Each tool plays a specific role and keeps the analysis reproducible.

---

### 1. Python – Data Cleaning, Feature Engineering, and Early Validation

I used three notebooks:

- `01_data_cleaning.ipynb`  
  Cleaned column types, fixed missing revenue, validated gameplay metrics, removed corrupt rows, and exported a consistent dataset.

- `02_feature_engineering.ipynb`  
  Created features such as engagement segments, total revenue, Day-1 flags, session-per-match ratios, and exported an enriched dataset for SQL.

- `03_exploratory_analysis.ipynb`  
  Produced quick distribution plots, checked session-duration patterns, looked at revenue histograms and DAU patterns before moving into Power BI.

Python ensured the dataset was **reliable** before it entered the SQL layer.

---

### 2. SQL – Modular Aggregation & Segment Logic

Each SQL view performs one job:  
country revenue, first-day conversion patterns, engagement segmentation, session fatigue trends, and segment-based monetization.

Python outputs fed directly into these views (particularly engineered columns like `engagement_segment` and `total_revenue`).

All SQL files are included under `/task2/sql`.

---

### 3. Power BI – Visualization & Final Insight Layer

I built three dashboard pages:

1. **Overall DAU + Total Sessions + Global Metrics**  
2. **First-Day Engagement Segments Analysis**  
3. **Session Fatigue & Segment Behavior Over Time**

All visuals are exported inside `/task2/images`, matching the dashboards in `task2_dashboard.pbix`.

Power BI uses the SQL views as its source, which themselves rely on Python-cleaned data.

---

### 4. End-to-End Workflow Summary

The analysis pipeline works in this order:

1. **Python cleans the data** → generates the enriched dataset.  
2. **SQL reads the enriched dataset** → computes segment rules, revenue metrics, daily trends.  
3. **Power BI consumes the SQL views** → builds visual insights and trends.  
4. **README documents** the methodology, assumptions, and findings.

This separation avoids duplication, makes each component reusable, and follows a realistic analytics workflow.

---

## 8. Assumptions

- Missing revenue is treated as zero.  
- Day-based retention and activity reflect engagement accurately.  
- No seasonality or external effects included.  
- User segments remain stable throughout the analysis period.  
- Revenue is assumed to be fully attributed to the day it is recorded.

---

## 9. Key Findings

1. First-day engagement is the strongest predictor of long-term value.  
2. High-engagement segments dominate both retention and monetization.  
3. Session fatigue affects all players and should guide content pacing.  
4. Revenue by country shows clear, actionable differences.  
5. Building user segments opens the door for deeper behavioral modeling.  

---

## 10. Final Notes

Task 2 is fully reproducible.  
SQL views provide clean, modular transforms.  
Power BI dashboards bring the results together.  
All insights are based directly on the available data, without external assumptions.
