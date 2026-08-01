create database bank_analytics;
use bank_analytics;
-- Import both the tables in the database
select * from finance_1;
select * from finance_2;
desc finance_1;
desc finance_2;
ALTER TABLE finance_1 MODIFY COLUMN int_rate DECIMAL(5,2);
ALTER TABLE FINANCE_2 RENAME COLUMN ï»¿id TO ID;


                                            -- KPI 1 -- Year Wise Loan Amount Stats -- Line chart
SELECT
YEAR(issue_d) AS Loan_Year,
SUM(loan_amnt) AS Total_Loan_Amount,
Round(AVG(loan_amnt)) AS Avg_Loan_Amount,
COUNT(id) AS Total_Loans
FROM Finance_1
GROUP BY YEAR(issue_d)
ORDER BY Loan_Year;

										    -- KPI 2 -- Grade & Sub Grade Wise Revolving Balance -- Horizontal Bar Chart
SELECT
grade,
sub_grade,
SUM(revol_bal) AS Total_Revol_Balance
FROM Finance_1 f1
JOIN Finance_2 f2
ON f1.id = f2.id
GROUP BY grade, sub_grade
ORDER BY Total_Revol_Balance DESC;

										    -- KPI 3 -- Total Payment Verified vs Non Verified -- Donut Chart
SELECT
verification_status,
Round(SUM(total_pymnt)) AS Total_Payment
FROM Finance_1 f1
JOIN Finance_2 f2
ON f1.id = f2.id
GROUP BY verification_status;

										    -- KPI 4 -- State Wise & Last Credit Pull Date Wise Loan Status -- Filled Map Chart
SELECT
addr_state,
loan_status,
COUNT(*) AS Loan_Count
FROM Finance_1 f1
JOIN Finance_2 f2
ON f1.id = f2.id
GROUP BY
addr_state,
loan_status;

										    -- KPI 5 -- Home Ownership vs Last Payment Date Stats -- Stacked Column Chart
SELECT
home_ownership,
YEAR(last_pymnt_d) AS Payment_Year,
COUNT(*) AS Loan_Count,
Round(SUM(total_pymnt)) AS Total_Payment
FROM Finance_1 f1
JOIN Finance_2 f2
ON f1.id = f2.id
GROUP BY
home_ownership,
YEAR(last_pymnt_d);

