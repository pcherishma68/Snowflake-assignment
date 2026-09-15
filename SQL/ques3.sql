

-- 1. Select the database
USE DATABASE SNOWFLAKE_ASSIGNMENT_DB;

-- 2. Select the schema
USE SCHEMA ASSIGNMENT_SCHEMA;


-- 3. Create the target table
CREATE OR REPLACE TABLE STUDENT_DATA (
    STUDENT_ID INT,
    NAME VARCHAR(50),
    DEPARTMENT VARCHAR(50),
    MARKS INT
);

-- Verify table structure
DESC TABLE STUDENT_DATA;


-- 4. Create an internal stage
CREATE OR REPLACE STAGE STUDENT_STAGE;


-- 5. Upload the CSV file from the local computer

PUT 'file://C:/Users/mansimaheshwari/Desktop/snowflake/students.csv.txt'
    @STUDENT_STAGE
    AUTO_COMPRESS = TRUE;


-- 6. Verify that the file was uploaded
LIST @STUDENT_STAGE;


-- 7. Load data from the stage into the table
COPY INTO STUDENT_DATA
FROM @STUDENT_STAGE
FILE_FORMAT = (
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
);


-- 8. Verify the loaded data
SELECT *
FROM STUDENT_DATA
ORDER BY STUDENT_ID;


-- 9. Verify total number of records
SELECT COUNT(*) AS TOTAL_STUDENTS
FROM STUDENT_DATA;
