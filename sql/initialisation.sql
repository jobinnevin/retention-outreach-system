copy raw_current_book FROM '/Users/jobinnevin/Documents/retention_project/retention_book_current.csv' WITH (FORMAT csv, HEADER true);
copy raw_renewal_history FROM '/Users/jobinnevin/Documents/retention_project/renewal_history.csv' WITH (FORMAT csv, HEADER true);
SELECT current_database();

SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';


CREATE TABLE raw_current_book (
    customer_id               TEXT,
    age                       INT,
    gender                    TEXT,
    marital_status            TEXT,
    province                  TEXT,
    city                      TEXT,
    occupation                TEXT,
    annual_income             NUMERIC,
    credit_score              INT,
    policy_type               TEXT,
    policy_start_date         DATE,
    renewal_date              DATE,
    tenure_years              NUMERIC,
    annual_premium            NUMERIC,
    coverage_amount           NUMERIC,
    deductible                INT,
    premium_change_pct        NUMERIC,
    payment_frequency         TEXT,
    autopay_enrolled          TEXT,
    missed_payments_12m       INT,
    claims_count_3y           INT,
    last_claim_status         TEXT,
    complaints_12m            INT,
    service_interactions_12m  INT,
    satisfaction_score        NUMERIC,
    multi_policy_count        INT,
    preferred_channel         TEXT,
    preferred_contact_time    TEXT,
    preferred_language        TEXT,
    life_event_12m            TEXT,
    digital_logins_12m        INT
);

SELECT * FROM raw_current_book LIMIT 5;


CREATE TABLE raw_renewal_history (
    customer_id               TEXT,
    renewal_date              DATE,
    age                       INT,
    province                  TEXT,
    policy_type               TEXT,
    tenure_years              NUMERIC,
    annual_premium            NUMERIC,
    premium_change_pct        NUMERIC,
    payment_frequency         TEXT,
    autopay_enrolled          TEXT,
    missed_payments_12m       INT,
    claims_count_3y           INT,
    last_claim_status         TEXT,
    complaints_12m            INT,
    service_interactions_12m  INT,
    satisfaction_score        NUMERIC,
    multi_policy_count        INT,
    life_event_12m            TEXT,
    digital_logins_12m        INT,
    outcome                   TEXT
);

SELECT * FROM raw_renewal_history LIMIT 5;


COPY raw_current_book FROM '/Users/jobinnevin/Documents/retention_project/retention_book_current.csv' WITH (FORMAT csv, HEADER true);

COPY raw_renewal_history FROM '/Users/jobinnevin/Documents/retention_project/renewal_history.csv' WITH (FORMAT csv, HEADER true);

SELECT COUNT(*) FROM raw_current_book;
SELECT COUNT(*) FROM raw_renewal_history;
SELECT COUNT(*) FROM raw_current_book WHERE satisfaction_score IS NULL;

SELECT * FROM raw_current_book  LIMIT 5

SELECT * FROM raw_renewal_history  LIMIT 5

SELECT customer_id, count(*) 
FROM raw_current_book
GROUP BY customer_id
HAVING count(*) > 1
ORDER BY count(*) DESC;


SELECT customer_id, count(*) 
FROM raw_current_book
WHERE customer_id = 'C100644'
GROUP BY customer_id

//Prefered Channel

Select preferred_channel, count(*)
FROM raw_current_book
GROUP BY preferred_channel

// Any null in annual_income => 250 values
SELECT * FROM raw_current_book WHERE annual_income IS NULL;

// Any null values in satisfaction_score => 750 values
SELECT * 
FROM raw_current_book
WHERE satisfaction_score IS NULL;

//renwal date beotre policy start date 
SELECT * 
FROM raw_current_book
WHERE renewal_date < policy_start_date;

//practice window funciton 
SELECT *,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY policy_start_date DESC) AS row_num
FROM raw_current_book;

//practice CTE 
WITH DuplicateCustomers AS(
    SELECT 
        customer_id,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY policy_start_date DESC) AS row_num
    FROM raw_current_book
)
SELECT *
FROM DuplicateCustomers
WHERE row_num = 1;

// CREATE table to store cleaned data - silver table
CREATE TABLE clean_current_book AS
WITH DuplicateCustomers AS(
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY policy_start_date DESC) AS row_num
    FROM raw_current_book
)
SELECT  customer_id              ,
    age                       ,
    gender                    ,
    marital_status            ,
    province                  ,
    city                      ,
    occupation                ,
    annual_income             ,
    credit_score              ,
    policy_type               ,
    policy_start_date         ,
    renewal_date              ,
    tenure_years              ,
    annual_premium            ,
    coverage_amount           ,
    deductible                ,
    premium_change_pct        ,
    payment_frequency         ,
    autopay_enrolled          ,
    missed_payments_12m       ,
    claims_count_3y           ,
    last_claim_status         ,
    complaints_12m            ,
    service_interactions_12m  ,
    satisfaction_score        ,
    multi_policy_count        ,
    INITCAP(PREFERRED_CHANNEL) AS preferred_channel,
    preferred_contact_time    ,
    preferred_language        ,
    life_event_12m            ,
    digital_logins_12m        
FROM DuplicateCustomers
WHERE row_num = 1 AND renewal_date >= policy_start_date 

select * from clean_current_book 


//Creating table to tract the cleared data due to date
CREATE TABLE data_quality_exceptions AS
SELECT *
FROM raw_current_book
WHERE renewal_date < policy_start_date;

