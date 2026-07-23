SELECT customer_id,
       policy_type,
       annual_premium,
       days_until_renewal,
       preferred_channel,
       preferred_language,
       premium_change_pct
FROM scored_current_book
WHERE risk_category = 'High'
  AND days_until_renewal <= 90
ORDER BY total_risk_score DESC, days_until_renewal ASC
LIMIT 5;