
--1. Most Popular and least popular market segment for starting a starup? (Based on investments)

DROP TABLE IF EXISTS PopMarket;
CREATE TABLE PopMarket
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
STORED AS TEXTFILE LOCATION 'wasbs://viggy@startupanalysis.blob.core.windows.net/Qn1/' 
AS 
select SUM(funding_total_usd) as TotalInvestment,market from companies where market IS NOT NULL group by market sort by TotalInvestment desc;


--2. Safest State/city to start a startup.
DROP TABLE IF EXISTS Safest;
CREATE TABLE SafestCity
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
STORED AS TEXTFILE LOCATION 'wasbs://viggy@startupanalysis.blob.core.windows.net/Qn2/' 
AS 
select count(city) as TotalStartups, City from companies where status='operating' and City NOT LIKE '' group by city sort by TotalStartups desc; 
-- Safest country
DROP TABLE IF EXISTS SafestCountry;
CREATE TABLE SafestCountry
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
STORED AS TEXTFILE LOCATION 'wasbs://viggy@startupanalysis.blob.core.windows.net/Qn2_1/' 
AS 
select count(country_code) as TotalStartups,country_code from companies where status='operating' and country_code NOT LIKE '' group by country_code sort by TotalStartups desc; 


--3. Total companies found by year and market segment.

DROP TABLE IF EXISTS TotComp;
CREATE TABLE TotComp
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
STORED AS TEXTFILE LOCATION 'wasbs://viggy@startupanalysis.blob.core.windows.net/Qn3/' 
AS 
select market,founded_year,count(founded_year) as Totalcounts from companies where founded_year>=2000 and founded_year<=2014 group by market,founded_year order by founded_year asc,Totalcounts desc;

--4. Companies based on highest funding.

CREATE TABLE HighFunding 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
STORED AS TEXTFILE LOCATION 'wasbs://viggy@startupanalysis.blob.core.windows.net/Qn4/' 
AS 
select name,market,status,funding_total_usd,country_code,city from companies order by funding_total_usd desc;

--5. Average funding for a company based on market segment.

DROP TABLE IF EXISTS AvgFunding;
CREATE TABLE AvgFunding
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
STORED AS TEXTFILE LOCATION 'wasbs://viggy@startupanalysis.blob.core.windows.net/Qn5/' 
AS 
select market,cast(avg(funding_total_usd)as bigint) as average from companies group by market order by average desc;

--6. Finding company which has invested more. (By money and occurences)

--By money:
DROP TABLE IF EXISTS CompInv;
CREATE TABLE CompInv
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
STORED AS TEXTFILE LOCATION 'wasbs://viggy@startupanalysis.blob.core.windows.net/Qn7/' 
AS 
select investor_name,investor_market,count(investor_name) as totalcnt,investor_country,sum(raised_amount_usd) as total from investments group by investor_name,investor_country,investor_market order by total desc;

--8. Increase/decrease on networth for the acquired company. (Company wise / segment wise)
DROP TABLE IF EXISTS Networth;
CREATE TABLE Networth
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
STORED AS TEXTFILE LOCATION 'wasbs://viggy@startupanalysis.blob.core.windows.net/Qn8/' 
AS 
select distinct c.name,c.funding_total_usd,a.acquirer_name,a.price_amount,(a.price_amount - c.funding_total_usd) as acqvalue,c.market from companies c join acquirer a on (c.name = a.company_name) sort by acqvalue desc;

--9. Companies with most funding rounds.
DROP TABLE IF EXISTS Fundrounds;
CREATE TABLE Fundrounds
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
STORED AS TEXTFILE LOCATION 'wasbs://viggy@startupanalysis.blob.core.windows.net/Qn9/' 
AS 
select name,market,funding_rounds from companies sort by funding_rounds desc;


--10. Top 5 companies with highest acquisition value

DROP TABLE IF EXISTS HighAcq;
CREATE TABLE HighAcq
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
STORED AS TEXTFILE LOCATION 'wasbs://viggy@startupanalysis.blob.core.windows.net/Qn10/' 
AS 
select company_name, company_market, sum(price_amount) as Totalprice from acquirer group by company_name,company_market sort by Totalprice desc;

--11. City/region from where highest acquistions were made.

DROP TABLE IF EXISTS HighAcqCity;
CREATE TABLE HighAcqCity
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
STORED AS TEXTFILE LOCATION 'wasbs://viggy@startupanalysis.blob.core.windows.net/Qn11/' 
AS 
select acquirer_state, count(acquirer_state) as acqcnt from acquirer where acquirer_state != '' group by acquirer_state sort by acqcnt desc;
