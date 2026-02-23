create database dataanalytics_db;
use dataanalytics_db;
create table data(UDI int,	Product_ID varchar(30),Type char,Air_temperature float
,Process_temperature float,Rotational_speed float,Torque float,Tool_wear int,Machine_failure int,
	TWF	int,HDF int,PWF	int ,OSF int,RNF int);
    desc data;
    select * from data;
    SELECT * FROM data LIMIT 10000;
    #Mean for single column
SELECT AVG(Air_temperature) FROM data;
#Mean for multiple column
SELECT AVG(Process_temperature) AS mean_column1,
       AVG(Rotational_speed) AS mean_column2,
       AVG(Torque) AS mean_column3,
       AVG(Tool_wear) AS mean_column4
FROM data;






# median

SELECT Air_temperature AS median_experience
FROM (
    SELECT Air_temperature , ROW_NUMBER() OVER (ORDER BY Air_temperature) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM data
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

SELECT Process_temperature AS median_experience1
FROM (
    SELECT Process_temperature , ROW_NUMBER() OVER (ORDER BY Process_temperature) AS row_num1,
           COUNT(*) OVER () AS total_count
    FROM data
) AS subquery
WHERE row_num1 = (total_count + 1) / 2 OR row_num1 = (total_count + 2) / 2;

SELECT Rotational_speed AS median_experience1
FROM (
    SELECT Rotational_speed , ROW_NUMBER() OVER (ORDER BY Rotational_speed) AS row_num2,
           COUNT(*) OVER () AS total_count
    FROM data
) AS subquery
WHERE row_num2 = (total_count + 1) / 2 OR row_num2 = (total_count + 2) / 2;

SELECT Torque AS median_experience1
FROM (
    SELECT Torque , ROW_NUMBER() OVER (ORDER BY Torque) AS row_num3,
           COUNT(*) OVER () AS total_count
    FROM data
) AS subquery
WHERE row_num3 = (total_count + 1) / 2 OR row_num3 = (total_count + 2) / 2;

SELECT Tool_wear AS median_experience1
FROM (
    SELECT Tool_wear , ROW_NUMBER() OVER (ORDER BY Tool_wear) AS row_num4,
           COUNT(*) OVER () AS total_count
    FROM data
) AS subquery
WHERE row_num4 = (total_count + 1) / 2 OR row_num4 = (total_count + 2) / 2;
   
   
   
   
   # mode

     SELECT Type AS mode_workex
FROM (
    SELECT Type, COUNT(*) AS frequency
    FROM data
    GROUP BY Type
    ORDER BY frequency DESC
    LIMIT 1
) AS subquery;




# Second Moment Business Decision/Measures of Dispersion


# Variance
SELECT
    VARIANCE(Air_temperature) AS variance_column1,
    VARIANCE(Process_temperature) AS variance_column2,
    VARIANCE(Rotational_speed) AS variance_column3,
    VARIANCE(Torque) AS variance_column4,
    VARIANCE(Tool_wear) AS variance_column5
FROM
    data;
    
    
    # Standard Deviation 
SELECT
    STDDEV(Air_temperature) AS workex_stddev,
    STDDEV(Process_temperature) AS std_dev_column2,
    STDDEV(Rotational_speed) AS std_dev_column3,
    STDDEV(Torque) AS std_dev_column4,
    STDDEV(Tool_wear) AS std_dev_column5
FROM
    data;

# Range
SELECT
    MAX(Air_temperature) - MIN(Air_temperature) AS range_column1,
    MAX(Process_temperature) - MIN(Process_temperature) AS range_column2,
    MAX(Rotational_speed) - MIN(Rotational_speed) AS range_column3,
    MAX(Torque) - MIN(Torque) AS range_column4,
    MAX(Tool_wear) - MIN(Tool_wear) AS range_column5
FROM
    data;
#9.20001220703125	8.0999755859375	   1718	    72.79999852180481	253
#Skewness Calculation:
SELECT
    (
        SUM(POWER(Air_temperature - (SELECT AVG(Air_temperature) FROM data), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Air_temperature) FROM data), 3))
    ) AS skewness,
    (
        (SUM(POWER(Air_temperature- (SELECT AVG(Air_temperature) FROM data), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Air_temperature) FROM data), 4))) - 3
    ) AS kurtosis
FROM data;
#Air_temperature =0.11425680383772466	-0.8361437098452749

SELECT
    (
        SUM(POWER(Process_temperature - (SELECT AVG(Process_temperature) FROM data), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Process_temperature) FROM data), 3))
    ) AS skewness,
    (
        (SUM(POWER(Process_temperature- (SELECT AVG(Process_temperature) FROM data), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Process_temperature) FROM data), 4))) - 3
    ) AS kurtosis
FROM data;
#Process_temperature=0.01502488349446522	-0.5000848435465675

SELECT
    (
        SUM(POWER(Rotational_speed - (SELECT AVG(Rotational_speed) FROM data), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Rotational_speed) FROM data), 3))
    ) AS skewness,
    (
        (SUM(POWER(Rotational_speed- (SELECT AVG(Rotational_speed) FROM data), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Rotational_speed) FROM data), 4))) - 3
    ) AS kurtosis
FROM data;
#Rotational_speed =1.9928720166048364	7.388649004260019

SELECT
    (
        SUM(POWER(Torque - (SELECT AVG(Torque) FROM data), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Torque) FROM data), 3))
    ) AS skewness,
    (
        (SUM(POWER(Torque- (SELECT AVG(Torque) FROM data), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Torque) FROM data), 4))) - 3
    ) AS kurtosis
FROM data;
#Torq=-0.009515170189557984	-0.013833933344572724

SELECT
    (
        SUM(POWER(Tool_wear - (SELECT AVG(Tool_wear) FROM data), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Tool_wear) FROM data), 3))
    ) AS skewness,
    (
        (SUM(POWER(Tool_wear- (SELECT AVG(Tool_wear) FROM data), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Tool_wear) FROM data), 4))) - 3
    ) AS kurtosis
FROM data;
#Tool_wear=0.027288145044007204	-1.166753784684022