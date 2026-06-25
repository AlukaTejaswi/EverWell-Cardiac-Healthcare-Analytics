# EverWell Cardiac Hospital Analytics

## About Project

This project analyses cardiac hospital admission data collected over a two-year period (1 April 2017 to 31 March 2019) from a tertiary care cardiac hospital. The dataset contains patient admission, discharge, demographic, clinical, laboratory, and outcome-related information.

The dataset includes patient details such as:

- Admission and discharge dates
- Age and gender
- Rural/urban locality
- Emergency and outpatient admission type
- Medical history including Diabetes Mellitus (DM), Hypertension (HTN), Coronary Artery Disease (CAD), Cardiomyopathy (CMP), and Chronic Kidney Disease (CKD)
- Clinical measurements including Hemoglobin, TLC, Platelets, Glucose, Urea, Creatinine, BNP, Cardiac Enzymes, and Ejection Fraction
- Cardiac conditions including STEMI, Heart Failure, Shock, Arrhythmia, Pulmonary Embolism, and other cardiovascular conditions

The data was analysed to understand hospital performance, patient risk patterns, clinical outcomes, discharge behaviour, and healthcare resource utilisation.

---

# Objective: 

I analysed this data as a Data Analyst working for a fictional healthcare organisation called **EverWell Cardiac Hospital** using **Microsoft SQL Server**.

The focus of the analysis was to understand hospital performance by exploring:

- Patient admission trends and emergency vs outpatient admission patterns
- Patient demographics including age groups, gender, and rural/urban distribution
- High-risk patient groups based on chronic conditions such as diabetes, hypertension, and kidney disease
- Clinical outcomes including mortality, severe cardiac conditions, and multi-morbidity patterns
- Discharge behaviour including discharge rate, length of stay, and patient recovery patterns
- ICU utilisation and hospital resource usage to identify operational efficiency opportunities

The objective was to transform healthcare data into actionable insights that support better patient care, resource allocation, and data-driven hospital decision-making.

---

# Tools Used

- **Microsoft SQL Server** – Database creation, data storage, and analysis  
- **SQL Server Management Studio (SSMS)** – Query development and execution  
- **T-SQL** – Data cleaning, transformation, and healthcare analytics  

## SQL Concepts Used

- Views
- CTEs (Common Table Expressions)
- Aggregate Functions
- CASE Statements
- Window Functions
- Ranking Functions
- Data Cleaning
- Data Validation
- Conditional Aggregation
- Date Functions
- Healthcare KPI Analysis

---

# Key Insights

- The hospital recorded **14,540 patient admissions** during the analysis period, with **69.5% of admissions coming through emergency services**, highlighting the hospital’s strong dependency on urgent cardiac care.

- **64.2% of patients were classified as high-risk** due to conditions such as Diabetes, Hypertension, or Chronic Kidney Disease, showing that chronic disease management plays a major role in cardiac hospital utilisation.

- Adult patients accounted for **8,122 admissions**, while senior citizens contributed **6,366 admissions**, showing that cardiac healthcare demand is mainly concentrated among middle-aged and elderly populations.

- Male patients represented **9,218 admissions (63.4%)** compared to **5,322 female admissions**, revealing a significant difference in cardiac hospitalisation patterns.

- **58.93% of patients had multi-morbidity**, meaning more than half of admissions involved two or more chronic conditions, increasing treatment complexity and healthcare resource requirements.

- STEMI cases contributed **14.09% of total admissions**, and adults recorded the highest number of severe cardiac cases with **3,179 cases**, highlighting the importance of early diagnosis and rapid treatment.

- Among **1,100 patient deaths**, **946 expired patients had high BNP levels**, indicating a strong relationship between elevated BNP levels and poor clinical outcomes.

- The hospital achieved an **86.71% discharge rate with 12,608 successful discharges**, while a **6.19% DAMA rate** highlighted opportunities to improve patient communication and follow-up processes.

- ICU dependency was significantly high at **82%**, with patients spending an average of **3 days in ICU**, indicating high demand for critical care resources.

- Rural patients contributed **3,452 admissions**, and **41.71% of rural patients presented with severe cardiac conditions**, suggesting potential delays in accessing specialised cardiac treatment.

---

# Business Impact

- Improved hospital resource planning by identifying that **82% of patients required ICU support**, helping management optimise ICU capacity, staffing, and critical care readiness.

- Improved emergency department efficiency by identifying that **69.5% of admissions were emergency cases**, supporting better emergency response planning and resource allocation.

- Enabled early risk identification by analysing that **64.2% of patients had chronic conditions**, helping healthcare teams focus on preventive care and high-risk patient monitoring.

- Reduced clinical risk by identifying mortality patterns where **86% of expired patients had high BNP levels** and **62.73% had renal dysfunction**, helping prioritise patients requiring closer observation.

- Improved hospital operations by analysing patient flow, achieving an **86.71% discharge rate with an average 6-day stay**, supporting better bed utilisation and discharge planning.

- Supported healthcare improvement strategies by identifying that **41.71% of rural patients presented with severe cardiac conditions**, highlighting opportunities for rural screening programs, awareness initiatives, and early referral systems.

- ---

# Author

**Name:** Aluka Tejaswi    
**Project:** EverWell Cardiac Hospital Analytics  

This project demonstrates healthcare data analysis using Microsoft SQL Server, focusing on data cleaning, SQL-based analytics, healthcare KPI analysis, and generating actionable business insights from patient admission and clinical data.

**Skills Demonstrated:**
- SQL Server Database Analysis
- T-SQL Query Development
- Data Cleaning & Transformation
- Healthcare Analytics
- Business Insight Generation
- Data-Driven Decision Making
