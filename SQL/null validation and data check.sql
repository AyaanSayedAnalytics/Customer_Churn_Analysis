--Create saved query 

CREATE OR ALTER VIEW dbo.v_churn AS
SELECT
Churn,
AccountWeeks,
ContractRenewal,
DataPlan,
DataUsage,
CustServCalls,
DayMins,
DayCalls,
MonthlyCharge,
OverageFee,
RoamMins,
CASE 
WHEN AccountWeeks < 13 THEN '0-12'
WHEN AccountWeeks < 26 THEN '13-25'
WHEN AccountWeeks < 52 THEN '26-51'
ELSE '52+'
END AS tenure_band
FROM dbo.telecom_churn;
GO

--Check nulls
SELECT
SUM(CASE WHEN Churn IS NULL THEN 1 ELSE 0 END) AS Churn_nulls,
SUM(CASE WHEN AccountWeeks IS NULL THEN 1 ELSE 0 END) AS AccountWeeks_nulls,
SUM(CASE WHEN ContractRenewal IS NULL THEN 1 ELSE 0 END) AS contractrenewal_nulls,
SUM(CASE WHEN DataPlan IS NULL THEN 1 ELSE 0 END) AS dataplan_nulls,
SUM(CASE WHEN DataUsage IS NULL THEN 1 ELSE 0 END) AS datausage_nulls,
SUM(CASE WHEN CustServCalls IS NULL THEN 1 ELSE 0 END) AS custservcalls_nulls,
SUM(CASE WHEN DayMins IS NULL THEN 1 ELSE 0 END) AS daymins_nulls,
SUM(CASE WHEN DayCalls IS NULL THEN 1 ELSE 0 END) AS daycalls_nulls,
SUM(CASE WHEN MonthlyCharge IS NULL THEN 1 ELSE 0 END) AS monthlycharge_nulls,
SUM(CASE WHEN OverageFee IS NULL THEN 1 ELSE 0 END) AS overagefee_nulls,
SUM(CASE WHEN RoamMins IS NULL THEN 1 ELSE 0 END) AS roammins_nulls
FROM dbo.telecom_churn

--Check bad values
SELECT
SUM(CASE WHEN AccountWeeks < 0 THEN 1 ELSE 0 END) AS bad_accountweeks,
SUM(CASE WHEN CustServCalls < 0 THEN 1 ELSE 0 END) AS bad_custservcalls,
SUM(CASE WHEN DayMins < 0 THEN 1 ELSE 0 END) AS bad_daymins,
SUM(CASE WHEN DayCalls < 0 THEN 1 ELSE 0 END) AS bad_daycalls,
SUM(CASE WHEN MonthlyCharge < 0 THEN 1 ELSE 0 END) AS bad_monthlycharge,
SUM(CASE WHEN OverageFee < 0 THEN 1 ELSE 0 END) AS bad_overagefee,
SUM(CASE WHEN DataUsage < 0 THEN 1 ELSE 0 END) AS bad_datausage,
SUM(CASE WHEN RoamMins < 0 THEN 1 ELSE 0 END) AS bad_roammins
FROM dbo.telecom_churn;



