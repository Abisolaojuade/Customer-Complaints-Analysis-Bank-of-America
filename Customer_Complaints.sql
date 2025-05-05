Select * from copy_consumer_complaints;
Truncate copy_consumer_complaints;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Copy_consumer_complaints.CSV"
INTO TABLE Copy_consumer_complaints
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY 'r\n'
IGNORE 1 LINES;


-- Rename table Copy_consumer_complaints
 Rename table copy_consumer_complaints to Customer_Complaints;

Select * from customer_complaints;

-- Data Cleaning 
-- Rename column header to the right format

Alter table customer_complaints
Rename column `Complaint ID` to Complaint_ID;

Alter table customer_complaints
Rename column `Submitted via` to Submitted_Via;

Alter table customer_complaints
Rename column `Date submitted` to Date_Submitted;

Alter table customer_complaints
Rename column `Date received` to Date_Received;

Alter table customer_complaints
Rename column `Sub-product` to Sub_Product;

Alter table customer_complaints
Rename column `Sub-issue` to Sub_Issue;

Alter table customer_complaints
Rename column `Company public response` to Company_Public_Response;

Alter table customer_complaints
Rename column `Company response to consumer` to Company_Response_to_Consumers;

Alter table customer_complaints
Rename column `Timely response?` to Timely_Response;

-- Change Data type to the right format
Alter table customer_complaints
Modify column Date_Submitted Date;

Alter table customer_complaints
Modify column Date_Received Date;


-- Remove Duplicate rows(Rows that have same Values)
Select Complaint_ID, Submitted_Via, Date_Submitted, Date_Received, State, Product, Sub_Product, Issue, Sub_Issue,
Company_Public_Response, Company_Response_to_Consumers, Timely_Response, count(*) from customer_complaints
group by Complaint_ID, Submitted_Via, Date_Submitted, Date_Received, State, Product, Sub_Product, Issue, Sub_Issue,
Company_Public_Response, Company_Response_to_Consumers, Timely_Response
Having count(*) > 1;
-- This data has no Duplicate


-- Exploratory Analysis
-- Total Number of Complaints
Select Count(Complaint_ID) as Total_complaints from customer_complaints;

-- Submission Channel
Select count(distinct Submitted_Via) as Submission_channel from customer_complaints;

-- Product 
Select count(distinct Product) as No_of_products from customer_complaints;

-- State
select Count(distinct state) as No_of_states from customer_complaints;

-- Issue
Select count(distinct Issue) as No_of_isssues from customer_complaints;

-- Responses
Select Count(distinct Company_Response_to_Consumers) as Responses from customer_complaints;

-- Average response time
Select Concat(Ceiling(avg(DATEDIFF(Date_received, Date_submitted)))," ","days") as avg_response_time from customer_complaints;

-- Key Business Questions to Solve:
-- 1. Complaint Trends & Seasonality
-- Do consumer complaints show any seasonal patterns (e.g., more complaints during certain months)?
With CTE as (Select Month(Date_Submitted) as Monthnum, Monthname(Date_submitted) as Month_Submitted, Count(Complaint_ID) as Total_Complaints from customer_complaints
group by month_submitted, Monthnum
order by monthnum),
Cte2 as(Select  Case when monthnum between 1 and 3 then "QT1"
			when Monthnum between 4 and 6 then "QT2"
            when Monthnum between 7 and 9 then "QT3"
            when Monthnum between 10 and 12 then "QT4" end as Season, Total_complaints from CTE)
            Select Season, Sum(total_complaints) as Total_complaints from CTE2
            group by season;
            
Select distinct Product from customer_complaints;

-- How have complaint volumes changed over time from 2017 to 2023?
With CTE as(Select year(Date_submitted) as Year, count(Complaint_ID)as Total_Complaints from customer_complaints
group by Year 
order by year asc),
CTE_2 as(select *, Lag(Total_Complaints, 1) over() as Previous_no_of_Complaints from CTE),
CTE3 AS(Select Year, Total_Complaints, coalesce(Previous_no_of_Complaints,0) as Previous_Complaints, 
coalesce(Total_Complaints-previous_no_of_Complaints,0) as difference, 
Concat(Round(coalesce(((Total_Complaints-previous_no_of_complaints)/Previous_no_of_complaints) * 100,0),2), "%")
 as Percentage_diff from CTE_2)
 Select Year, Percentage_diff from CTE3;


-- Are certain states reporting more complaints than others?
Select distinct state from consumer_complaints;
Select state, count(Complaint_ID) as No_of_Complaints from customer_complaints
group by state
order by No_of_Complaints desc
Limit 5;

Select distinct state from consumer_complaints;
Select state, count(Complaint_id) as No_of_Complaints from customer_complaints
group by state
order by No_of_Complaints;

-- 2. Product & Issue Analysis
-- Which financial products receive the most complaints?
Select product, count(*) as No_of_Complaints from customer_complaints
group by Product
order by No_of_complaints desc;

-- What are the most common issues reported for each product?
Select distinct Product from customer_complaints;
Select distinct issue from customer_complaints;

With Cte as (Select product, Issue, Count(Issue) as No_Issue from customer_complaints
group by Product, issue),
CTE_2 as(Select *, Rank() over (partition by Product Order by NO_Issue desc) as Ranking from CTE)
Select product, Issue, No_Issue from CTE_2
Where Ranking =1;

-- Are certain sub-products more prone to complaints?
Select Sub_product, count(Complaint_ID) as No_of_Complaints from customer_complaints
group by Sub_Product
order by No_of_complaints desc
Limit 5;

-- Which issues escalate frequently (i.e., result in repeated complaints)?
Select issue, count(issue) as NO_of_Frequent_issues from customer_complaints
group by issue
order by NO_of_Frequent_issues desc
limit 5;

-- 3. Company Response & Resolution Patterns
-- What percentage of complaints receive a timely response?
Select Company_response_to_Consumers, timely_response from customer_complaints
where Company_Response_to_Consumers = "In progress";

SET SQL_SAFE_UPDATES =0;
Update customer_complaints
set Timely_Response = "Awaiting"
where Timely_Response = "";
select * from customer_complaints;

select case
		when timely_response = 'yes' then "Timely Response"
        when timely_response = 'no' then "Untimely response"
        else "Awaiting Response" end as response, Concat(Round(count(timely_response) * 100/(select count(*) from customer_complaints), 2), "%") as Percentage_of_response 
        from customer_complaints
        where Timely_Response = "Yes";
select case
		when timely_response = 'yes' then "Timely Response"
        when timely_response = 'no' then "Untimely response"
        else "Awaiting Response" end as response, Concat(Round(count(timely_response) * 100/(select count(*) from customer_complaints),2), "%") as Percentage_of_response 
        from customer_complaints group by Timely_Response;
        

-- How are most complaints resolved? (e.g., Closed with explanation, Closed with monetary relief?)
Select Company_response_to_consumers, count(issue) as No_of_complaints from customer_complaints
group by Company_Response_to_Consumers
order by No_of_complaints desc;


-- 4. Untimely Responses & Their Impact
-- Are there patterns in untimely responses?
Select Weekday(date_submitted) as Week_num,  Dayname(Date_Submitted) as day_name, Count(*) as Untimely_response from customer_complaints
 where Timely_Response = "No"
 group by Day_name, Week_num
 order by week_num;

-- Do specific complaint types or products tend to have delayed responses?
Select Product, count(Timely_Response) as Untimely_response from customer_complaints
where timely_response = "No"
group by product
order by untimely_response desc
limit 3;
-- They have a high complaint number compared to others

-- Are certain states more likely to receive untimely responses?
Select State, count(Timely_Response) as No_of_untimely_response from customer_complaints
where timely_response = "No"
group by State
order by No_of_Untimely_response desc
limit 5;

-- 5. Submission Channel & Processing Time
-- Which submission channels (e.g., Phone, Email, Online) generate the most complaints?
select submitted_via, count(issue) as No_of_complaints from customer_complaints
group by Submitted_Via
order by No_of_complaints desc;

-- Does submission method affect response time?
Select Submitted_via, Ceiling(avg(DATEDIFF(Date_received, Date_submitted))) as avg_response_time from customer_complaints
group by Submitted_via
order by avg_response_time desc;

Select * from customer_complaints;

-- How long does it take, on average, for the company to respond to a complaint?
Select Concat(Ceiling(avg(DATEDIFF(Date_received, Date_submitted)))," ","days") as avg_response_time from customer_complaints;