create database walmartSales;

 USE walmartsales;
 
CREATE TABLE IF NOT EXISTS sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10 , 2 ) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6 , 4 ) NOT NULL,
    total DECIMAL(12 , 4 ) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10 , 2 ) NOT NULL,
    gross_margin_pct FLOAT(11 , 9 ),
    gross_income DECIMAL(12 , 4 ),
    rating FLOAT(2 , 1 )
);
    
    
    SELECT * FROM SALES;
    
/*** QUESTION 1 ***/

SELECT * FROM SALES;
SELECT TIME ,
CASE 
WHEN TIME BETWEEN '00:00:00' AND '12:00:00' THEN 'MORNING'
WHEN TIME BETWEEN '12:00:01' AND '16:00:00' THEN 'AFTERNOON'
WHEN TIME BETWEEN '16:00:01' AND '23:59:59' THEN 'EVENING'
END AS TIME_OF_DAY

FROM SALES;


/*** ADD COLUMN IN DATA ***/

SELECT * FROM SALES;
ALTER TABLE SALES ADD COLUMN TIME_OF_DAY VARCHAR(20);


UPDATE SALES
SET TIME_OF_DAY = (
	CASE
		WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);


/*** QUESTION ***/

SELECT * FROM SALES;
SELECT DATE,DAYNAME(date)
FROM SALES;
ALTER TABLE SALES ADD COLUMN DAY_NAME VARCHAR(10);
UPDATE SALES
SET DAY_NAME = DAYNAME(DATE);


/*** QUESTOIN ***/
SELECT * FROM SALES;
SELECT DATE,MONTHNAME(DATE)
FROM SALES;
ALTER TABLE SALES ADD COLUMN MONTH_NAME VARCHAR(10);
UPDATE SALES
SET MONTH_NAME = MONTHNAME(DATE);

/*** QUESTION ***/
SELECT * FROM SALES;
SELECT DISTINCT(CITY) FROM SALES;

/*** QUESTION :- IN WHICH CITY EACH BRANCH ***/

SELECT * FROM SALES;
SELECT DISTINCT(CITY),BRANCH FROM SALES;

/*** QUESTION :- HOW MANY UNIQUE PRODUCT LINE DATA HAVE ***/

SELECT * FROM SALES;

SELECT DISTINCT(PRODUCT_LINE) FROM SALES;

/***QUESTION :- What product line had the largest revenue ***/
SELECT * FROM SALES;
SELECT PRODUCT_LINE,SUM(total) AS Total_price
FROM SALES
GROUP BY PRODUCT_LINE
ORDER BY Total_price DESC;

/*** QUESTION :- WHAT IS TOTAL REVENUE BY MONTH ***/
SELECT * FROM SALES;
SELECT MONTH_NAME,SUM(TOTAL) AS TOTAL_REVENUE
FROM SALES
GROUP BY MONTH_NAME
ORDER BY TOTAL_REVENUE DESC;

/***QUESTION:-What month had the largest COGS? ***/
SELECT * FROM SALES;	
SELECT MONTH_NAME AS MONTH,SUM(COGS) AS MAX_COGS
FROM SALES
GROUP BY MONTH
ORDER BY MAX_COGS DESC;



/*** DATE 12/02/2025 ***/


/*** QUESTION What is the city with the largest revenue? ***/

SELECT * FROM SALES;
SELECT branch,city,SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue;

/*** QUESTION What product line had the largest VAT? **/

SELECT * FROM SALES;
SELECT PRODUCT_LINE AS PRODUCT,ROUND(AVG(TAX_PCT),2) AS VAT
FROM SALES
GROUP BY PRODUCT
ORDER BY VAT DESC;

/*** QUESTION  Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales ***/


SELECT * FROM SALES;
SELECT PRODUCT_LINE AS PRODUCT ,AVG(QUANTITY) AS AVG_QUAN,
CASE
    WHEN AVG(QUANTITY) > 6 THEN 'GOOD'
    ELSE 'BAD'
END AS QUALITY
FROM SALES
GROUP BY PRODUCT;

/*** QUESTION Which branch sold more products than average product sold? ***/
SELECT * FROM SALES;

SELECT BRANCH, SUM(quantity) AS QTY
FROM SALES
GROUP BY BRANCH
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM SALES);

/*** QUESTION What is the most common product line by gender ***/
SELECT * FROM SALES;

SELECT
	GENDER,
	COUNT(*) as GENDER_CNT
FROM SALES
GROUP BY GENDER
ORDER BY GENDER_CNT DESC;

/*** QUESTION Which customer type buys the most? ***/
SELECT * FROM SALES;
SELECT
CUSTOMER_TYPE,
	COUNT(*) as CUS_TYPE
FROM SALES
GROUP BY CUSTOMER_TYPE
ORDER BY CUS_TYPE DESC;

/*** QUESTION Which time of the day do customers give most ratings? ***/
SELECT * FROM SALES;
SELECT TIME_OF_DAY , AVG(RATING) AS RATING
FROM SALES
GROUP BY TIME_OF_DAY
ORDER BY RATING DESC;

/*** QUESTION Which day of the week has the best avg ratings? ***/

SELECT * FROM sales;
SELECT day_name,AVG(rating) AS rating
FROM sales
GROUP BY day_name
ORDER BY rating DESC;

/*** QUESTION  Number of sales made in each time of the day per weekday ***/
SELECT * FROM sales;
SELECT TIME_OF_DAY,day_name,COUNT(quantity) as quantity
FROM sales
WHERE day_name = 'sunday'
GROUP BY TIME_OF_DAY
ORDER BY quantity DESC;

/*** QUESTION  Which of the customer types brings the most revenue? ***/
SELECT * FROM sales;
SELECT customer_type,SUM(total) as revenue 
FROM sales
GROUP BY customer_type
ORDER BY revenue DESC;

/*** QUESTION Which city has the largest tax/VAT percent? ***/
SELECT * FROM sales;

SELECT city,ROUND(AVG(tax_pct),2) AS AVG_TAX_PCT
FROM sales
GROUP BY city
ORDER BY AVG_TAX_PCT DESC;

/*** QUESTION Which customer type pays the most in VAT? ***/

SELECT * FROM sales;
SELECT customer_type,ROUND(AVG(tax_pct),2) AS TAX
From sales
GROUP BY customer_type
ORDER BY TAX DESC;