# Customer-Complaints-Analysis-Bank-of-America

![Comprehensive Guide to Bank Loans at Bank of America](https://github.com/user-attachments/assets/f5946e2a-2658-4ff0-b3b6-52cf08bc2e03)


## Table of Contents

- [Introduction](#Introduction)
- [Dataset Overview](#Dataset-Overview)
- [Project Objective](#Project-Objective)
- [Data Cleaning and Transformation](#Data-Cleaning-and-Transformation)
- [Data Exploration and Insights](#Data-Exploration-and-Insights)
- [Dashboard](#Dashboard)
- [Conclusion](#Conclusion)
- [Recommendation](#Recommendation)

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

## Dataset overview

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

-![Screenshot 2025-05-06 144403](https://github.com/user-attachments/assets/c9023c0c-8f3e-44bc-83b8-d96c45bfc8bf)

--

## DATA CLEANING AND TRANSFORMATION
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
** ✅ Do consumer complaints show any seasonal patterns (e.g., more complaints during certain months)?**

**INSIGHTS:** This analysis indicates that the highest volume of complaints occurred in the **third quarter (QT3) with 16,923 complaints**, 
while the **fourth quarter (QT4) experienced the lowest at 14,204 complaints**. The Seasonal patterns in consumer complaints can be influenced by various factors, 
including financial stress during certain times of the year. A study by Lending Club found that 36% of consumers experience the most financial distress in December, 
primarily due to increased spending during events and celebrations. This heightened financial strain could lead to a higher number of complaints during the fourth quarter. 
However, the data presented here shows a decrease in complaints during QT4, which may suggest that factors other than financial distress, such as improved customer service or seasonal promotions, 
could have contributed to this decline.

**✅ How have complaint volumes changed over time from 2017 to 2023?**

**INSIGHTS:** Analyzing the annual percentage changes in Bank of America's consumer complaint volumes from 2017 to 2023 reveals notable fluctuations: 
**2018:** +45.94%,**2019:** -10.12%, **2020:** +26.39%, **2021:** +24.68%, **2022:** +16.18%, **2023:** -29.51%.

These figures suggest a significant increase in complaints during the early years, peaking in 2018, followed by a decline in 2019. 

The subsequent years (2020–2022) saw a resurgence in complaint volumes, with a sharp decrease in 2023.

**2018 Peak:** The sharp rise in complaints in 2018 could be attributed to increased consumer awareness and reporting, as well as potential service issues during that period.~

**2019 Decline:** The decrease in 2019 might indicate improvements in customer service or a reduction in systemic issues that previously led to complaints.

**2020–2022 Increase:** The upward trend in complaints from 2020 to 2022 could be linked to the challenges posed by the COVID-19 pandemic, 
including financial hardships and increased reliance on digital banking services, which may have exposed new issues.

**2023 Decline:** The significant drop in 2023 may reflect improvements in complaint resolution processes, enhanced customer service strategies, or changes in consumer behavior and expectations.

**✅ Are certain states reporting more complaints than others?**

**INSIGHTS:** Yes, certain states are reporting significantly more consumer complaints against Bank of America than others. The top five states with the highest complaint volumes are: **California (CA):** 13,709 complaints, **Florida (FL):** 6,488 complaints, **Texas (TX):** 4,686 complaints, **New York (NY):** 4,442 complaints, **Georgia (GA):** 2,921 complaints. 
These figures suggest that consumer dissatisfaction is notably higher in these states compared to others. California, in particular, stands out with more than twice the number of complaints as Florida, the second-highest state.

Possible Factors Contributing to Regional Disparities
Several factors could explain why certain states report more complaints:
-	Population Size and Density: Larger populations, such as California's, naturally lead to more interactions with financial institutions, potentially resulting in a higher number of complaints.
- Economic Activity: States with higher economic activity and a greater number of financial transactions may experience more issues, leading to increased complaint volumes.
- Consumer Awareness and Advocacy and Bank Branch Density in certain states can lead to more complaints.

#### 2. Product & Issue Analysis
**✅ Which financial products receive the most complaints?**

**INSIGHTS:** The products with the highest complaint volumes are: **Checking or Savings Accounts:** 24,814 complaints, **Credit Cards or Prepaid Cards:** 16,197 complaints, **Credit Reporting, Credit Repair Services, or Other , Personal Consumer Reports: 7,710 complaints, Mortgages: 6,601 complaints, Money Transfer, Virtual Currency, or Money Services: 3,453 complaints, Debt Collection: 2,736 complaints, Vehicle Loans or Leases: 633 complaints, Payday Loans, Title Loans, or Personal Loans: 333 complaints , Student Loans: 39 complaints.

High Complaint Categories:
-	Checking or Savings Accounts: These accounts are fundamental to daily banking, leading to frequent customer interactions and, potentially, more opportunities for issues to arise.
-	Credit Cards or Prepaid Cards: Given their widespread use, especially during economic fluctuations, it's not surprising that they generate a substantial number of complaints.

Moderate Complaint Categories:
-	Credit Reporting and Mortgages: These products are complex and can significantly impact consumers' financial well-being, making them prone to disputes and misunderstandings.
-	Money Transfer and Debt Collection Services: The increasing use of digital payment methods and the sensitivity of debt-related issues contribute to the volume of complaints in these areas.

Lower Complaint Categories:
-	Vehicle Loans, Payday Loans, Personal Loans, and Student Loans: The relatively low complaint numbers could be attributed to these products being less prevalent among Bank of America's customer base or possibly due to more straightforward terms and conditions.

**✅ What are the most common issues reported for each product?**

**INSIGHTS:** Analyzing the consumer complaints data against Bank of America reveals the most common issues reported for each financial product:
-	**Checking or Savings Account (15,109 complaints):** The predominant concern is "Managing an account," which encompasses difficulties with account maintenance, unauthorized transactions, and issues related to account features.
- **Credit Card or Prepaid Card (4,415 complaints):** The most frequent problem involves "Problems with purchases shown on your statement," including disputes over unauthorized charges, dissatisfaction with purchased goods or services, and challenges in the chargeback process.  
- **Credit Reporting, Credit Repair Services, or Other Personal Consumer Reports (4,145 complaints):** Consumers mainly report "Incorrect information on your report," such as inaccuracies, outdated information, or fraudulent entries affecting their creditworthiness.
- **Debt Collection (1,351 complaints):** The chief issue is "Attempts to collect debt not owed," involving cases where consumers are pursued for debts they do not recognize, possibly due to identity theft, payments already made, or debts discharged in bankruptcy.  
-	**Money Transfer, Virtual Currency, or Money Service (1,951 complaints):** The leading concern is "Fraud or scam," including unauthorized transactions, deceptive practices, and challenges in recovering funds lost to fraudulent activities.
-	**Mortgage (2,827 complaints):** The most common issue is "Trouble during payment process," covering difficulties with payment processing, misapplied payments, and challenges in managing escrow accounts.
-	**Payday Loan, Title Loan, or Personal Loan (71 complaints):** Consumers primarily face issues related to "Getting a line of credit," including challenges in obtaining loans, understanding terms, and concerns over high-interest rates.
-	**Student Loan (20 complaints):** The predominant problem is "Dealing with your lender or servicer," encompassing issues like loan servicing errors, communication difficulties, and disputes over loan terms.
-	**Vehicle Loan or Lease (222 complaints):** The main concern is "Managing the loan or lease," including issues with payment processing, account management, and disputes over loan terms or lease agreements.

**✅ Are certain sub-products more prone to complaints?**

**INSIGHTS:** Certain sub-products are more prone to complaints. Analysis of consumer complaint data indicates that checking accounts (20,768 complaints) are the most frequent source of dissatisfaction, accounting for a significant portion of complaints. Issues often reported include difficulties in account management, unauthorized transactions, and problems with deposits and withdrawals.  
Following checking accounts, general-purpose credit cards or charge cards (13,404 complaints )also receive a substantial number of complaints, with common issues related to misleading credit terms, high fees, and disputes over charges. Additionally, credit reporting services (7,340  complaints)attract complaints concerning inaccuracies in credit reports, identity theft concerns, and disputes over debt validations. 

**✅ Which issues escalate frequently (i.e., result in repeated complaints)?**
**INSIGHTS:** Analyzing the frequency of repeated complaints reveals that certain issues tend to escalate more than others. The top five issues with the highest number of complaints are:

- **Managing an Account (15,109 complaints):** This category includes difficulties with account maintenance, unauthorized transactions, and issues related to account features.

- **Incorrect Information on Your Report (4,931 complaints):** Consumers report inaccuracies, outdated information, or fraudulent entries affecting their creditworthiness.

- **Problems with a Purchase Shown on Your Statement (4,415 complaints):** Disputes over unauthorized charges, dissatisfaction with purchased goods or services, 
and challenges in the chargeback process are common concerns.

- **Closing an Account (2,953 complaints):** Issues arise when accounts are closed without proper notice, leading to unexpected fees or continued charges. 

- **Trouble During Payment Process (2,827 complaints):** Consumers face challenges with payment processing, misapplied payments, and difficulties in managing escrow accounts.

These issues are more likely to escalate due to their direct impact on consumers' financial well-being and the complexity involved in resolving them. 

#### 3. Company Response & Resolution Patterns

**✅ What percentage of complaints receive a timely response?**

**INSIGHTS:** Based on the data provided, **approximately 93.77% of complaints receive a timely response, while 2.39% are awaiting a response, and 3.84% receive untimely responses.**
High Timeliness Rate: A timely response rate of nearly 94% indicates a strong commitment to addressing customer complaints promptly.

Areas for Improvement:
**Awaiting Responses (2.39%):** While a small fraction, it's essential to address these delays to enhance customer satisfaction.

**Untimely Responses (3.84%):** This segment represents a notable opportunity for improvement. Analyzing the causes of these delays can help in implementing strategies to ensure all complaints are addressed promptly.

**✅ How are most complaints resolved? (e.g., Closed with explanation, Closed with monetary relief?)**

**INSIGHTS:** The majority of complaints are resolved with an explanation, accounting for 41,044 cases, which represents the most common resolution type.
- High reliance on explanations: Over 63% of complaints are closed simply with an explanation, suggesting Bank of America is often addressing issues by clarifying situations rather than offering compensation or corrective action.
- Monetary and non-monetary relief: Combined, these types account for around 31% of cases. This suggests that in roughly 1 out of 3 situations, some form of customer benefit or rectification is deemed necessary.
- Low unresolved cases: Only 2.3% of complaints are still in progress, and unresolved closures without context (just "Closed") are rare, indicating good case follow-through.

#### 4. Untimely Responses & Their Impact
**✅ Are there patterns in untimely responses?**

**INSIGHTS:**
- **Weekdays vs. Weekends:** The highest number of untimely responses occur during weekdays, particularly Thursday (468), followed by Tuesday (426) and Wednesday (420).
  
- **Drop on Weekends:** There's a significant drop on Saturday (195) and Sunday (143). This could be due to reduced staffing or processing activity during the weekend, 
which might delay the start of the response process and affect weekday performance.

- **Thursday Peak:** The spike on Thursdays might indicate a bottleneck or workload accumulation midweek—possibly due to complaints piling up earlier in the week and deadlines being missed.

**✅ Do specific complaint types or products tend to have delayed responses?**

**INSIGHTS**
- **Checking/Savings Accounts Lead in Delays:** With 867 untimely responses, complaints related to checking or savings accounts are the most likely to face delays. 
This could reflect internal delays in verifying account data, resolving fraud claims, or managing transaction disputes.

- **Credit Card and Credit Reporting Issues Also Affected:** Credit card/prepaid card complaints (689 delays) and Credit reporting or repair services (475 delays) also show high untimely response counts, 
suggesting these areas may involve more complex investigation or third-party coordination (e.g., with credit bureaus).

- **High Volume ≠ Efficiency:** These product types likely receive higher overall complaint volumes, but the fact that they also top the list for delays suggests a service delivery gap—perhaps insufficient staff allocation or complicated resolution processes.

**✅ Are certain states more likely to receive untimely responses?**

**INSIGHTS:** **California Dominates:** With 599 untimely responses, California (CA) has more than 2x the delays of the next state (Florida). This might be due to: A higher population and customer base, 
More complaints in general and Potentially localized service issues or staffing/resource challenges.
**Regional Hotspots:** The top four—CA, FL, NY, and TX—are all high-population states, which makes their appearance expected, but the disproportionately high number from CA suggests potential regional inefficiencies.
New Jersey’s High Rate: While NJ is smaller in population, it still shows 93 untimely responses, which could indicate a higher rate of delay per complaint and might be worth deeper investigation.

#### 5. Submission Channel & Processing Time

**✅ Which submission channels (e.g., Phone, Email, Online) generate the most complaints?**

**INSIGHTS:** 
**Web Dominates Complaint Submissions:** The Web channel is by far the most used, accounting for over 72% of all complaints. 

This shows that customers strongly prefer the convenience of online self-service portals to file complaints.
- **Referrals Are the Second-Most Common:** With 10,766 complaints, referrals (likely from third-party sites or regulatory bodies) are significant. This might indicate that:

- Some customers don’t trust or prefer BoA’s internal submission systems.
-	Third-party channels may offer better guidance or support.
-	Phone and Mail Still in Use: Though less popular, Phone (4,684) and Postal Mail (1,318) still serve a portion of users—possibly those who are less tech-savvy, or when the complaint needs a more personalized or formal approach.
- Fax and Email Nearly Obsolete: Fax (233) and Email (2) are rarely used, showing a shift away from older or less structured communication formats.

**✅ Does submission method affect response time?**

**Insight: Web-Based and Digital Channels Get the Fastest Responses:**
-	Complaints submitted through Web, Web Referral, Fax, and Email receive responses in an average of 1 day, indicating that digital submissions are likely integrated into automated or high-priority workflows.
- Referral and Traditional Channels Take Longer: Referral-based complaints take an average of 4 days, likely because they come from third-party sources or external regulators, adding steps to the processing workflow.
- Phone and Postal Mail take around 2 days, which may reflect the manual nature of logging and routing these complaints.

**✅ How long does it take, on average, for the company to respond to a complaint?**

**INSIGHTS:** **Fast Response Time Overall:** An average of **2 days** to respond indicates that Bank of America maintains a fairly efficient complaint handling process, especially when compared to industry standards, 
where **5–7 days** is more typical.

---

## Dashboard

The image below is the Dashboard for my anlysis

![Customer_complaint Dashboard](https://github.com/user-attachments/assets/9832d5e0-dd55-4c83-a1bc-45bd039c4f2e)

---

 ## Conclusion

This project analysis provides valuable insights into Bank of America’s consumer complaint data, identifying several areas of strength and opportunities for improvement. 
The company’s complaint handling process is generally efficient, with an average response time of 2 days and a 93.77% timeliness rate. However, several patterns and trends have been identified that highlight areas requiring focus to further enhance customer satisfaction and operational efficiency.

**1.	Complaint Trends and Seasonality:** Complaints show seasonal patterns, with the highest volume in the third quarter. These trends may be linked to financial stress during certain periods, 
and proactive steps should be taken to prepare for these peaks.

**2.	Complaint Volume and Time Series Analysis:** The annual fluctuations in complaint volumes suggest that external factors, such as the COVID-19 pandemic or changes in Bank of America’s service offerings, 
may have influenced complaint patterns. A sharper decline in 2023 indicates improvements in complaint resolution processes.

**3.	Product-Specific Complaints:** 	Checking accounts, credit cards, and credit reporting services consistently generate the highest number of complaints, with complex issues such as fraud, unauthorized charges, 
and credit inaccuracies being common. These product categories require improved internal processes, streamlined resolution mechanisms, and additional resources to handle the volume.

**4.	Regional Differences:** California stands out as a region with disproportionately high untimely responses, indicating potential inefficiencies in complaint handling or resource allocation. 
Further investigation into regional disparities is necessary to address these inefficiencies.

**5.	Submission Channels:** The web channel dominates complaint submissions, suggesting that customers prefer online self-service options. However, referral complaints are taking longer to resolve, 
and improvements in integration with third-party channels are recommended. Furthermore, traditional submission methods like fax and email should be phased out in favor of more modern, efficient channels.

**6.	Resolution and Response Timeliness:** While Bank of America demonstrates a strong commitment to timely complaint resolution, the untimely responses are mainly observed on certain weekdays (especially Thursdays) 
and with specific product types. Operational adjustments, including optimized workflows and dynamic staffing during peak complaint periods, can help resolve this issue.

In conclusion, Bank of America has a strong foundation in its complaint management processes, but there is significant room for optimization and efficiency gains. By focusing on seasonal trends, product-specific improvements, 
regional inefficiencies, and submission channel optimization, the bank can further enhance its ability to resolve complaints efficiently and improve overall customer satisfaction.

---

## Recommendation

**1.	Address Seasonal Trends and Complaint Volume Variations**: 	
- Adjust staffing and resources to align with peak complaint seasons, particularly during Q3, when complaints tend to peak. 
Proactively allocate additional resources during these months to ensure quicker response times and reduce backlogs.
-	Implement targeted marketing campaigns or customer service initiatives during low-volume periods (like Q4) to prevent complaints related to seasonal stress or misunderstandings, improving customer experience during these times.

**2.	Improve Response Timeliness**
-	Investigate and address the midweek bottleneck observed on Thursdays, where untimely responses peak. A dynamic scheduling system could help shift resources to peak complaint periods, ensuring complaints are handled without delay.
-	Establish an escalation protocol to ensure that complaints flagged as high priority (due to customer dissatisfaction or product issues) are resolved faster. This would help reduce the small but significant percentage of complaints that take more than the average 2-day response time.

**3.	Optimize Complaint Handling for Specific Product Types**
- Enhance internal processes for high-volume complaint products, such as checking/savings accounts, credit cards, and credit reporting services, which not only have high complaint volumes but also experience delays in resolution. 

This can be achieved through:
-	Improved fraud management for checking accounts and speedier chargeback processing for credit cards.
-	Automated systems for handling disputes over credit reporting inaccuracies to speed up the resolution process.
-	Consider increasing staff training and process automation for products that generate frequent complaints to ensure quicker resolution times and reduce the chances of delayed responses.

**4.	Refine Regional Complaint Handling and Efficiency**
-	Address the regional inefficiency seen in California, where untimely responses are disproportionately higher. This could involve:
-	Localizing customer service teams or increasing staffing levels in states with high complaint volumes and untimely responses.
-	Implementing state-specific resources or regional complaint monitoring tools to better manage state-specific issues and complaints.
-	Consider conducting a detailed audit of service levels in California to pinpoint inefficiencies such as resource allocation, staff training, or regional systemic issues.

**5.	Enhance the Efficiency of Submission Channels**
-	Given that web-based complaints represent the bulk of submissions, ensure that the online complaint platform is user-friendly and optimized for mobile devices to facilitate smoother complaint submissions.
-	Improve the integration of third-party referral channels (which account for a significant portion of complaints) by working closely with external regulators or consumer protection agencies to streamline the intake process.
-	While fax and email are becoming obsolete, consider removing or consolidating less efficient submission methods (like fax and email), focusing resources on the most efficient channels like the web.

**6.	Proactively Educate Customers**
-	Implement educational programs or self-service tools to address the most common complaints, such as issues with credit reporting, unauthorized charges, or account management. This could include:
-	Clearer documentation on account features and credit card terms.
-	Automated alerts and customer guides to help users manage their accounts and avoid issues that typically lead to complaints.
-	Fraud prevention tips and steps to avoid credit reporting inaccuracies to empower customers to handle potential issues on their own.

**7.	Track Complaint Resolution Satisfaction**
-	Implement a system to track customer satisfaction after complaint resolution to ensure that complaints are not only closed but resolved to the satisfaction of the customer. This could include:
-	Follow-up surveys post-resolution to understand customer sentiment.
-	Automated satisfaction ratings on closed complaints to ensure that the resolution process is effective.
-	Additionally, tracking the frequency of repeated complaints will help identify recurring issues and prevent the same complaints from escalating repeatedly.

**8.	Strategic Monitoring and KPIs**
-	Use Power BI dashboards to monitor key performance indicators (KPIs) such as complaint volume trends, resolution time, and repeat complaints in real-time. 
This will allow Bank of America to take immediate action when issues arise and make proactive decisions to optimize complaint management.

