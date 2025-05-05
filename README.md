# Customer-Complaints-Analysis-Bank-of-America

![Comprehensive Guide to Bank Loans at Bank of America](https://github.com/user-attachments/assets/f5946e2a-2658-4ff0-b3b6-52cf08bc2e03)


## Table of Contents

- [Introduction](#Introduction)
- [Dataset Overview](#Dataset-Overview)
- [Project Objective](#Project-Objective)
- [Data Cleaning and Transformation](#Data-Cleaning-and-Transformation)
- [Data Exploration and Insights](#Data-Exploration-and-Insights)
- [Dashboard](#Dashboard)
- [Recommendation](#Recommendation)
- [Conclusion](#Conclusion)

---

## INTRODUCTION
This project focuses on analyzing consumer complaints submitted to Bank of America to gain actionable insights into customer dissatisfaction, recurring service issues, and response patterns. 
By leveraging **SQL for data exploration and Power BI for interactive visualizations**, we aim to uncover trends and identify areas where customer service can be improved.
Complaints provide a valuable feedback loop for any organization. Through this analysis, we:
-	Examine the volume and types of complaints over time
-	Identify common themes and recurring issues
-	Evaluate response times and resolution effectiveness
-  Highlight opportunities for service enhancement and operational efficiency

This repository contains the SQL queries used for data extraction and transformation, along with Power BI dashboards that visualize the key findings. 

---

## Project overview

The dataset includes the following columns:

- Complaint ID:  The unique identification number for a complaint.
- Submitted via: How the complaint was submitted to the CFPB.
- Date submitted: The date the CFPB received the complaint.
- Date received: The date the CFPB sent the complaint to the company.
- State: The state of the mailing address provided by the consumer.
- Product: The type of product the consumer identified in the complaint.
- Sub-product: The type of sub-product the consumer identified in the complaint (not all Products have Sub-products).
- Issue: The issue the consumer identified in the complaint (possible values are dependent on Product).
- Sub-issue:  The sub-issue the consumer identified in the complaint (possible values are dependent on Product and Issue, and not all Issues have corresponding Sub-issues).
- Company public response: The company's optional, public-facing response to a consumer's complaint. Companies can choose to select a response from a pre-set list of options that will be posted on the public database. For example, "Company believes complaint is the result of an isolated error."
- Company response to consumer: This is how the company responded. For example, "Closed with explanation."
- Timely response: Whether the company gave a timely response (Yes/No).

---
## Project Objective
SQL Queries & Insights: Answering the key business questions.
 Power BI Dashboard: Data visualization of complaint trends and response patterns

Key Business Questions to Solve:
#### 1. Complaint Trends & Seasonality

✅ Do consumer complaints show any seasonal patterns (e.g., more complaints during certain months)?

✅ How have complaint volumes changed over time from 2017 to 2023?

✅ Are certain states reporting more complaints than others?

#### 2. Product & Issue Analysis

✅ Which financial products receive the most complaints?

✅ What are the most common issues reported for each product?

✅ Are certain sub-products more prone to complaints?

✅ Which issues escalate frequently (i.e., result in repeated complaints)?

#### 3. Company Response & Resolution Patterns

✅ What percentage of complaints receive a timely response?

✅ How are most complaints resolved? (e.g., Closed with explanation, Closed with monetary relief?)

#### 4. Untimely Responses & Their Impact

✅ Are there patterns in untimely responses?

✅ Do specific complaint types or products tend to have delayed responses?

✅ Are certain states more likely to receive untimely responses?

#### 5. Submission Channel & Processing Time

✅ Which submission channels (e.g., Phone, Email, Online) generate the most complaints?

✅ Does submission method affect response time?

✅ How long does it take, on average, for the company to respond to a complaint?

---

## DATA CLEANING
I started by renaming the table name from Copy_consumer_complaints to Customer complaints
 Rename table copy_consumer_complaints to Customer_Complaints;

-- Rename column header to the right format
```sql
Alter table customer_complaints
Rename column `Complaint ID` to Complaint_ID;
```

```sql
Alter table customer_complaints
Rename column `Submitted via` to Submitted_Via;
```


```sql
Alter table customer_complaints
Rename column `Date submitted` to Date_Submitted;
```

```sql
Alter table customer_complaints
Rename column `Date received` to Date_Received;
```

```sql
Alter table customer_complaints
Rename column `Sub-product` to Sub_Product;
```

```sql
Alter table customer_complaints
Rename column `Sub-issue` to Sub_Issue;
```

```sql
Alter table customer_complaints
Rename column `Company public response` to Company_Public_Response;
```

```sql
Alter table customer_complaints
Rename column `Company response to consumer` to Company_Response_to_Consumers;
````

```sql
Alter table customer_complaints
Rename column `Timely response?` to Timely_Response;
```

-- Change Data type to the right format
```sql
Alter table customer_complaints
Modify column Date_Submitted Date;
```

```sql
Alter table customer_complaints
Modify column Date_Received Date;
```


-- Remove Duplicate rows (Rows that have same Values)
```sql
Select Complaint_ID, Submitted_Via, Date_Submitted, Date_Received, State, Product, Sub_Product, Issue, Sub_Issue,
Company_Public_Response, Company_Response_to_Consumers, Timely_Response, count(*) from customer_complaints
group by Complaint_ID, Submitted_Via, Date_Submitted, Date_Received, State, Product, Sub_Product, Issue, Sub_Issue,
Company_Public_Response, Company_Response_to_Consumers, Timely_Response
Having count(*) > 1;
```
#### This data has no Duplicate

#### Updated the Timely_Response field in the customer_complaints table to 'Awaiting' for entries where the response status was previously empty, ensuring consistent tracking of complaint statuses.

```sql
Update customer_complaints
set Timely_Response = "Awaiting"
where Timely_Response = "";
```

## Data Exploration and Insights
- Total Number of Complaints

INSIGHTS: **62,516**

- Total Submission Channel

INSIGHTS: **7**

- Total number of products:

INSIGHTS: **9**

- Total number of states Analyzed

INSIGHTS: **51**

- Total number of Issues

INSIGHTS: **76**

- Type of response by the company to the customers complaints

INSIGHTS: **5**

- How long does it take, on average, for the company to respond to a complaint?

INSIGHTS: **2 Days.**

**Key Business Questions to Solve:**
#### 1. Complaint Trends & Seasonality
-- **Do consumer complaints show any seasonal patterns (e.g., more complaints during certain months)?**

INSIGHTS: This analysis indicates that the highest volume of complaints occurred in the **third quarter (QT3) with 16,923 complaints**, 
while the fourth quarter (QT4) experienced the lowest at 14,204 complaints. The Seasonal patterns in consumer complaints can be influenced by various factors, 
including financial stress during certain times of the year. A study by Lending Club found that 36% of consumers experience the most financial distress in December, 
primarily due to increased spending during events and celebrations. This heightened financial strain could lead to a higher number of complaints during the fourth quarter. 
However, the data presented here shows a decrease in complaints during QT4, which may suggest that factors other than financial distress, such as improved customer service or seasonal promotions, 
could have contributed to this decline.

✅ How have complaint volumes changed over time from 2017 to 2023?
INSIGHTS: Analyzing the annual percentage changes in Bank of America's consumer complaint volumes from 2017 to 2023 reveals notable fluctuations: 2018: +45.94%, 2019: -10.12%, 2020: +26.39%, 2021: +24.68%, 2022: +16.18%, 2023: -29.51%.
These figures suggest a significant increase in complaints during the early years, peaking in 2018, followed by a decline in 2019. The subsequent years (2020–2022) saw a resurgence in complaint volumes, with a sharp decrease in 2023.
2018 Peak: The sharp rise in complaints in 2018 could be attributed to increased consumer awareness and reporting, as well as potential service issues during that period.
2019 Decline: The decrease in 2019 might indicate improvements in customer service or a reduction in systemic issues that previously led to complaints.
2020–2022 Increase: The upward trend in complaints from 2020 to 2022 could be linked to the challenges posed by the COVID-19 pandemic, including financial hardships and increased reliance on digital banking services, which may have exposed new issues.
2023 Decline: The significant drop in 2023 may reflect improvements in complaint resolution processes, enhanced customer service strategies, or changes in consumer behavior and expectations.
✅ Are certain states reporting more complaints than others?
INSIGHTS: Yes, certain states are reporting significantly more consumer complaints against Bank of America than others. The top five states with the highest complaint volumes are: California (CA): 13,709 complaints, Florida (FL): 6,488 complaints, Texas (TX): 4,686 complaints, New York (NY): 4,442 complaints, Georgia (GA): 2,921 complaints. 
These figures suggest that consumer dissatisfaction is notably higher in these states compared to others. California, in particular, stands out with more than twice the number of complaints as Florida, the second-highest state.
Possible Factors Contributing to Regional Disparities
Several factors could explain why certain states report more complaints:
•	Population Size and Density: Larger populations, such as California's, naturally lead to more interactions with financial institutions, potentially resulting in a higher number of complaints.
Economic Activity: States with higher economic activity and a greater number of financial transactions may experience more issues, leading to increased complaint volumes.
Consumer Awareness and Advocacy and Bank Branch Density in certain states can lead to more complaints.

2. Product & Issue Analysis
✅ Which financial products receive the most complaints?
INSIGHTS: The products with the highest complaint volumes are: Checking or Savings Accounts: 24,814 complaints, Credit Cards or Prepaid Cards: 16,197 complaints, Credit Reporting, Credit Repair Services, or Other , Personal Consumer Reports: 7,710 complaints, Mortgages: 6,601 complaints, Money Transfer, Virtual Currency, or Money Services: 3,453 complaints, Debt Collection: 2,736 complaints, Vehicle Loans or Leases: 633 complaints, Payday Loans, Title Loans, or Personal Loans: 333 complaints , Student Loans: 39 complaints.
High Complaint Categories:
•	Checking or Savings Accounts: These accounts are fundamental to daily banking, leading to frequent customer interactions and, potentially, more opportunities for issues to arise.
•	Credit Cards or Prepaid Cards: Given their widespread use, especially during economic fluctuations, it's not surprising that they generate a substantial number of complaints.
Moderate Complaint Categories:
•	Credit Reporting and Mortgages: These products are complex and can significantly impact consumers' financial well-being, making them prone to disputes and misunderstandings.
•	Money Transfer and Debt Collection Services: The increasing use of digital payment methods and the sensitivity of debt-related issues contribute to the volume of complaints in these areas.
Lower Complaint Categories:
•	Vehicle Loans, Payday Loans, Personal Loans, and Student Loans: The relatively low complaint numbers could be attributed to these products being less prevalent among Bank of America's customer base or possibly due to more straightforward terms and conditions.
✅ What are the most common issues reported for each product?
INSIGHTS: Analyzing the consumer complaints data against Bank of America reveals the most common issues reported for each financial product:
•	Checking or Savings Account (15,109 complaints): The predominant concern is "Managing an account," which encompasses difficulties with account maintenance, unauthorized transactions, and issues related to account features.
•	Credit Card or Prepaid Card (4,415 complaints): The most frequent problem involves "Problems with purchases shown on your statement," including disputes over unauthorized charges, dissatisfaction with purchased goods or services, and challenges in the chargeback process.  
•	Credit Reporting, Credit Repair Services, or Other Personal Consumer Reports (4,145 complaints): Consumers mainly report "Incorrect information on your report," such as inaccuracies, outdated information, or fraudulent entries affecting their creditworthiness.
•	Debt Collection (1,351 complaints): The chief issue is "Attempts to collect debt not owed," involving cases where consumers are pursued for debts they do not recognize, possibly due to identity theft, payments already made, or debts discharged in bankruptcy.  
•	Money Transfer, Virtual Currency, or Money Service (1,951 complaints): The leading concern is "Fraud or scam," including unauthorized transactions, deceptive practices, and challenges in recovering funds lost to fraudulent activities.
•	Mortgage (2,827 complaints): The most common issue is "Trouble during payment process," covering difficulties with payment processing, misapplied payments, and challenges in managing escrow accounts.
•	Payday Loan, Title Loan, or Personal Loan (71 complaints): Consumers primarily face issues related to "Getting a line of credit," including challenges in obtaining loans, understanding terms, and concerns over high-interest rates.
•	Student Loan (20 complaints): The predominant problem is "Dealing with your lender or servicer," encompassing issues like loan servicing errors, communication difficulties, and disputes over loan terms.
•	Vehicle Loan or Lease (222 complaints): The main concern is "Managing the loan or lease," including issues with payment processing, account management, and disputes over loan terms or lease agreements.


