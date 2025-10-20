select * from Telco_Customer_Churn;


SELECT *
FROM Telco_Customer_Churn
WHERE TotalCharges IS NULL
   OR TotalCharges = '';


-- standardize 'Yes'/'No'
-- Standardize Churn
UPDATE Telco_Customer_Churn
SET Churn = CASE
    WHEN UPPER(Churn) = 'YES' THEN 'Yes'
    WHEN UPPER(Churn) = 'NO' THEN 'No'
END
WHERE Churn IS NOT NULL;

-- Standardize Partner
UPDATE Telco_Customer_Churn
SET Partner = CASE
    WHEN UPPER(Partner) = 'YES' THEN 'Yes'
    WHEN UPPER(Partner) = 'NO' THEN 'No'
END
WHERE Partner IS NOT NULL;

-- Standardize Dependents
UPDATE Telco_Customer_Churn
SET Dependents = CASE
    WHEN UPPER(Dependents) = 'YES' THEN 'Yes'
    WHEN UPPER(Dependents) = 'NO' THEN 'No'
END
WHERE Dependents IS NOT NULL;

-- Standardize PhoneService
UPDATE Telco_Customer_Churn
SET PhoneService = CASE
    WHEN UPPER(PhoneService) = 'YES' THEN 'Yes'
    WHEN UPPER(PhoneService) = 'NO' THEN 'No'
END
WHERE PhoneService IS NOT NULL;

-- Standardize MultipleLines
UPDATE Telco_Customer_Churn
SET MultipleLines = CASE
    WHEN UPPER(MultipleLines) = 'YES' THEN 'Yes'
    WHEN UPPER(MultipleLines) = 'NO' THEN 'No'
    WHEN UPPER(MultipleLines) = 'NO PHONE SERVICE' THEN 'No phone service'
END
WHERE MultipleLines IS NOT NULL;

-- Standardize OnlineSecurity
UPDATE Telco_Customer_Churn
SET OnlineSecurity = CASE
    WHEN UPPER(OnlineSecurity) = 'YES' THEN 'Yes'
    WHEN UPPER(OnlineSecurity) = 'NO' THEN 'No'
    WHEN UPPER(OnlineSecurity) = 'NO INTERNET SERVICE' THEN 'No internet service'
END
WHERE OnlineSecurity IS NOT NULL;

-- Standardize OnlineBackup
UPDATE Telco_Customer_Churn
SET OnlineBackup = CASE
    WHEN UPPER(OnlineBackup) = 'YES' THEN 'Yes'
    WHEN UPPER(OnlineBackup) = 'NO' THEN 'No'
    WHEN UPPER(OnlineBackup) = 'NO INTERNET SERVICE' THEN 'No internet service'
END
WHERE OnlineBackup IS NOT NULL;

-- Standardize DeviceProtection
UPDATE Telco_Customer_Churn
SET DeviceProtection = CASE
    WHEN UPPER(DeviceProtection) = 'YES' THEN 'Yes'
    WHEN UPPER(DeviceProtection) = 'NO' THEN 'No'
    WHEN UPPER(DeviceProtection) = 'NO INTERNET SERVICE' THEN 'No internet service'
END
WHERE DeviceProtection IS NOT NULL;

-- Standardize TechSupport
UPDATE Telco_Customer_Churn
SET TechSupport = CASE
    WHEN UPPER(TechSupport) = 'YES' THEN 'Yes'
    WHEN UPPER(TechSupport) = 'NO' THEN 'No'
    WHEN UPPER(TechSupport) = 'NO INTERNET SERVICE' THEN 'No internet service'
END
WHERE TechSupport IS NOT NULL;

-- Standardize StreamingTV
UPDATE Telco_Customer_Churn
SET StreamingTV = CASE
    WHEN UPPER(StreamingTV) = 'YES' THEN 'Yes'
    WHEN UPPER(StreamingTV) = 'NO' THEN 'No'
    WHEN UPPER(StreamingTV) = 'NO INTERNET SERVICE' THEN 'No internet service'
END
WHERE StreamingTV IS NOT NULL;

-- Standardize StreamingMovies
UPDATE Telco_Customer_Churn
SET StreamingMovies = CASE
    WHEN UPPER(StreamingMovies) = 'YES' THEN 'Yes'
    WHEN UPPER(StreamingMovies) = 'NO' THEN 'No'
    WHEN UPPER(StreamingMovies) = 'NO INTERNET SERVICE' THEN 'No internet service'
END
WHERE StreamingMovies IS NOT NULL;

-- Standardize PaperlessBilling
UPDATE Telco_Customer_Churn
SET PaperlessBilling = CASE
    WHEN UPPER(PaperlessBilling) = 'YES' THEN 'Yes'
    WHEN UPPER(PaperlessBilling) = 'NO' THEN 'No'
END
WHERE PaperlessBilling IS NOT NULL;

--Check for duplicates:
SELECT customerID, COUNT(*)
FROM Telco_Customer_Churn
GROUP BY customerID
HAVING COUNT(*) > 1;

--Create new columns:
--Tenure Group
ALTER TABLE Telco_Customer_Churn ADD COLUMN tenure_group TEXT;
UPDATE Telco_Customer_Churn
SET tenure_group = CASE
    WHEN tenure <= 12 THEN '0-12 months'
    WHEN tenure <= 24 THEN '13-24 months'
    WHEN tenure <= 48 THEN '25-48 months'
    ELSE '49+ months'
END;

--Monthly Charges Group:
ALTER TABLE Telco_Customer_Churn ADD COLUMN monthly_group TEXT;

UPDATE Telco_Customer_Churn
SET monthly_group = CASE
    WHEN MonthlyCharges < 35 THEN 'Low'
    WHEN MonthlyCharges BETWEEN 35 AND 70 THEN 'Medium'
    ELSE 'High'
END;



--Verify Cleaned Data
SELECT COUNT(*) AS total_rows,
       SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS missing_total_charges,
       SUM(CASE WHEN Churn NOT IN ('Yes','No') THEN 1 ELSE 0 END) AS invalid_churn
FROM Telco_Customer_Churn;












