--Partial score of the missed_payments_12m and last_claim_status columns
CREATE TABLE scored_current_book AS
WITH customerRisk AS (
SELECT 
    *,
    (CASE WHEN missed_payments_12m = 1 THEN 2 --Check for count of missed payments
          WHEN missed_payments_12m = 2 THEN 3
          WHEN missed_payments_12m >= 3 THEN 5
          ELSE 0 END) +
    (CASE WHEN last_claim_status = 'Denied' THEN 3 --Check for last claim status
          WHEN last_claim_status = 'Approved' THEN 0
          WHEN last_claim_status = 'Partial' THEN 1
          ELSE 0 END) +
    (CASE WHEN satisfaction_score <= 4  THEN 2 --Check if satisfaction score <4
          ELSE 0 END)+
    (CASE WHEN complaints_12m >= 1 THEN 2 --Check for complaints in the last 12 months
          ELSE 0 END) + 
    (CASE WHEN life_event_12m IN ('Divorce','Job Change') THEN 2 --Check for life events in the last 12 months
    WHEN life_event_12m = 'Retirement' THEN 1
          ELSE 0 END) +
    (CASE WHEN autopay_enrolled = 'No' THEN 1 --Check if autopay is enrolled
          ELSE 0 END) +
    (CASE WHEN multi_policy_count = 1 THEN 1 --Check if policy type is not a bundle
          ELSE 0 END) +
    (CASE WHEN tenure_years < 2 THEN 1 --Check if tenure is less than 2 years
          ELSE 0 END) +
    (CASE WHEN premium_change_pct >15 THEN 3 --Check if premium change percentage is greater than 15%
        WHEN premium_change_pct BETWEEN 8 AND 15 THEN 1
          ELSE 0 END) 
    
    AS total_risk_score
FROM clean_current_book
)
SELECT *,
(CASE WHEN total_risk_score >= 7 THEN 'High'
    WHEN total_risk_score BETWEEN 4 AND 6 THEN 'Medium'
    ELSE 'Low' END) 
    AS risk_category,
   (renewal_date - '2026-07-01' ::date) AS days_until_renewal


FROM customerRisk

SELECT * FROM scored_current_book

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';