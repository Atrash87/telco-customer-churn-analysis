--Basic Overview
--Churn Rate
SELECT 
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM Telco_Customer_Churn;

--Churn by Contract Type
SELECT 
  Contract,
  COUNT(*) AS total,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM Telco_Customer_Churn
GROUP BY Contract
ORDER BY churn_rate DESC;

--Churn by Tenure Group
SELECT 
  tenure_group,
  COUNT(*) AS total,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM Telco_Customer_Churn
GROUP BY tenure_group
ORDER BY tenure_group;

--Churn by Monthly Charges Group
SELECT 
  monthly_group,
  COUNT(*) AS total,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM Telco_Customer_Churn
GROUP BY monthly_group
ORDER BY churn_rate DESC;

--Churn by Internet Service
SELECT 
  InternetService,
  COUNT(*) AS total,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM Telco_Customer_Churn
GROUP BY InternetService
ORDER BY churn_rate DESC;

--Demographics Analysis
--Senior Citizens, Gender
SELECT 
  gender,
  SeniorCitizen,
  COUNT(*) AS total,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM Telco_Customer_Churn
GROUP BY gender, SeniorCitizen
ORDER BY churn_rate DESC;





