# 📊 APD 911 Calls Project Report

## 🚨 Project Title
**Enhancing Emergency Response: An Analysis of 911 Call Trends**

## 🧠 Team Name
**The Data Detectives**

## 👥 Project Members
- Evalyn Njagi (Analyst)  
- Rukayat Tokosi (Analyst)  
- Sunday Gabriel (Analyst)  
- Toheeb Olaniyi (Project Lead)  
- Adewale Abdulmuiz Akorede (Data Visualizer)  
- Augustine Adams (Analyst)  
- Olabisi Famoroti (Project Secretary)  
- AbdulRasheed Aminu (Analyst)

## 🗓️ Duration
**28/10/2024 – (3 Weeks)**

---

## 📝 Summary
Over the years, incident-related issues have risen significantly, leading to an increase in 911 calls. To enhance emergency response efficiency, this report analyzes over **952,833** 911 calls to:
- Improve response times
- Assess the mental health impact of critical incidents
- Evaluate the effectiveness of resource allocation

Using **Python** and **SQL**, we identified key trends, assessed performance metrics, and highlighted critical safety concerns to support optimized unit dispatch processes.

---

## 📌 Introduction
Emergency 911 services are crucial for public safety. This project analyzed **952,833** calls from **2021 to 2024** to:
- Identify patterns
- Improve response times
- Evaluate resource allocation
- Address the growing trend of mental health-related incidents

### Key Stakeholders:
- Austin Police Department (APD)
- Emergency Responders
- Policymakers
- The Community

---

## 📈 Key Findings
- **Total Calls:** 952,828 (Highest in 2022)
- **Average Response Time:** 2,254 seconds (37.5 minutes)
- **Average Unit Time on Scene:** 6,090 seconds (101.5 minutes)
- **Mental Health Calls:** Increased by 12%
- **Resource Allocation:** Uneven deployment in high-density areas

---

## 📊 Data Overview

### i. Dataset Description:
- **Source:** APD 911 Call Logs
- **Attributes:** Call type, timestamps, response time, location, priority level, mental health tags
- **Period:** 2021 - 2024

### ii. Data Cleaning Process:
- **Tool:** Microsoft Excel & Python
- **Missing Values:** Removed or filled with 0
- **Deduplication:** Duplicates retained if differing incident records
- **Transformation:** Standardized datetime columns

### iii. Tools Used:
- SQL (Trend Analysis)
- Python (Data Processing)
- Tableau (Visualization)

---

## 🧹 Data Cleaning Steps

### ✅ Date Formatting (Excel):
- Converted text-formatted dates using US locale.
- Created additional columns: Month, Day, Hour for trend analysis.

### ✅ Missing Values:
```python
police_df.dropna(thresh=4, inplace=True)
police_df.fillna(0, inplace=True)
```
# 📊 911 Calls Analysis – Summary Report

## 📈 Analysis Results

### i. Call Volume Trends
- **Total Calls:** 952,833  
- **By Priority:**
  - Priority 0: 12.68%
  - Priority 1: 18.64%
  - Priority 2: 50.33%
  - Priority 3: 18.55%

### ii. Top Issues Reported
- Disturbances: 349,350  
- Welfare Checks: 220,516  
- Suspicious Activities: 183,839  
- Trespassing: 168,174  

### iii. Response Insights
- **Top Officers by Case Count:**
  - Edward: 137,979  
  - David: 113,262  
  - Frank: 105,073  
- **Peak Hours:** 12 AM – 3 AM on weekends  
- **Busiest Days:** Friday > Monday > Wednesday  

### iv. Mental Health Insights
- **Total Mental Health-Tagged Calls:** 122,917 (12.9%)  
- **Peak Days:** Friday (18,282), Monday (18,148)  
- **Lowest Days:** Saturday (16,400), Sunday (16,298)  
- **Sector with Highest Cases:** David (19,068)  

---

## ✅ Final Dataset Check
```python
police_df.isna().sum()
pd.set_option('display.max_columns', None)
```

## 💡 Recommendations
- Optimize Resource Allocation: Deploy more officers to high-density and peak-time areas.
- Mental Health Training: Train officers for crisis intervention.
- Predictive Analytics: Use historical trends to predict call surges.
- Community Outreach: Educate the public on mental health support resources.
- Improve Data Quality: Ensure unique incident IDs and refine issue tagging.
- Tech Upgrades: Leverage AI for smart dispatching and real-time alerts.
- Specialized Units: Establish dedicated teams for mental health-related calls.

## ⚠️ Challenges & Limitations
- Missing Data: Imputation may have affected accuracy.
- No Real-Time Integration: Focused only on past data.
- Inconsistent Tagging: Mental health tags lacked uniformity.
- Duplicate Incident Numbers: Not reliable for unique indexing.

## 📌 Conclusion
This project reveals essential opportunities to enhance emergency response services. 
By analyzing call volumes, response times, officer performance, and mental health trends, strategic improvements can be made to ensure public safety,
reduce response delays, and address mental health-related emergencies more effectively.


## 📣 Community Poll: What's the Future of Public Safety?

We’re running a [**GitHub Discussion Poll**](https://github.com/your-username/your-repo/discussions) to gather feedback from devs, analysts, and changemakers like you.

> 🗳️ Vote on what matters most: Mental health support? AI dispatch? Data tagging?

Your insights will help refine the project and its real-world impact.  
⭐ Star and Watch this repo to join the journey!
