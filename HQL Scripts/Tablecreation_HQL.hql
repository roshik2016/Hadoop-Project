DROP TABLE companies;
CREATE EXTERNAL TABLE IF NOT EXISTS 
companies(name STRING,market STRING,funding_total_usd INT,status STRING,country_code STRING,state_code STRING,region STRING,city STRING,funding_rounds INT,founded_at DATE,founded_year INT,first_funding_at DATE,last_funding_at DATE) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 'Companies.csv' 
OVERWRITE INTO TABLE companies;

-- 2nd


DROP TABLE investments;
CREATE EXTERNAL TABLE IF NOT EXISTS
investments(company_name STRING,company_market STRING,company_country STRING,company_state STRING,company_city STRING,investor_name STRING,investor_market STRING,investor_country STRING,investor_state STRING,investor_city STRING,funding_round_type STRING,funded_at DATE,funded_year INT,raised_amount_usd INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 'Investments.csv' 
OVERWRITE INTO TABLE investments;
-- 3rd

DROP TABLE acquirer;
CREATE EXTERNAL TABLE IF NOT EXISTS
acquirer(company_name STRING,company_market STRING,company_country STRING,company_state STRING,company_city STRING,acquirer_name STRING,acquirer_market STRING,acquirer_country STRING,acquirer_state STRING,acquirer_city STRING,acquired_at DATE,acquired_year INT,price_amount INT,price_currency_code STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
tblproperties ("skip.header.line.count"="1");
LOAD DATA INPATH 'Acquire.csv' 
OVERWRITE INTO TABLE acquirer;