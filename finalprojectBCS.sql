create database FinalProject;
use FinalProject;
SELECT 
    SubscriptionType,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN IsChurned = 0 THEN 1 ELSE 0 END) AS ActiveCustomers,
    SUM(CASE WHEN IsChurned = 1 THEN 1 ELSE 0 END) AS ChurnedCustomers
FROM CustomerSubscriptions
GROUP BY SubscriptionType
ORDER BY SubscriptionType;
SELECT 
    SubscriptionType,
    Gender,
    ROUND(AVG(FeedbackScore),2) AS AvgFeedbackScore
FROM CustomerSubscriptions
GROUP BY SubscriptionType, Gender
ORDER BY SubscriptionType, Gender;
SELECT 
    CustomerID,
    Name,
    TotalSessions,
    FeedbackScore
FROM CustomerSubscriptions
WHERE TotalSessions < 5
AND FeedbackScore < 5;
SELECT 
    CustomerID,
    Name,
    LastLoginDate,
    DATEDIFF(CURDATE(), LastLoginDate) AS DaysSinceLastLogin
FROM CustomerSubscriptions
WHERE DATEDIFF(CURDATE(), LastLoginDate) > 60;
SELECT 
    SubscriptionType,
    COUNT(*) AS TotalCustomers,
    SUM(IsChurned) AS ChurnedCustomers,
    ROUND((SUM(IsChurned) / COUNT(*)) * 100, 2) AS ChurnRatePercent
FROM CustomerSubscriptions
GROUP BY SubscriptionType
ORDER BY ChurnRatePercent DESC;
SELECT 
    CustomerID,
    Name,
    SubscriptionType,
    SubscriptionDate,
    DATEDIFF(CURDATE(), SubscriptionDate) AS SubscriptionLengthDays
FROM CustomerSubscriptions
ORDER BY SubscriptionLengthDays DESC
LIMIT 10;
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS AgeGroup,
    
    COUNT(*) AS TotalCustomers,
    SUM(IsChurned) AS ChurnedCustomers,
    ROUND((SUM(IsChurned) / COUNT(*)) * 100, 2) AS ChurnRatePercent
    
FROM CustomerSubscriptions
GROUP BY AgeGroup
ORDER BY ChurnRatePercent DESC;
SELECT 
    DATE_FORMAT(SubscriptionDate, '%Y-%m') AS Month,
    COUNT(*) AS TotalCustomers,
    SUM(IsChurned) AS ChurnedCustomers,
    ROUND((SUM(IsChurned) / COUNT(*)) * 100, 2) AS ChurnRatePercent
FROM CustomerSubscriptions
GROUP BY DATE_FORMAT(SubscriptionDate, '%Y-%m')
ORDER BY Month;
SELECT 
    COUNT(*) AS TotalCustomers,
    ROUND((SUM(IsChurned) / COUNT(*)) * 100, 2) AS ChurnPercentage,
    ROUND(AVG(FeedbackScore),2) AS AvgFeedbackScore,
    ROUND(AVG(DATEDIFF(CURDATE(), LastLoginDate)),2) AS AvgDaysSinceLastLogin
FROM CustomerSubscriptions;