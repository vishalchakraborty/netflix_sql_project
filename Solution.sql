  --   Netflicx Project
     DROP TABLE NETFLIX
Create table netflix
(
show_id	Varchar(10),
type Varchar(20),
title	Varchar(200),
director  VARCHAR(400),
casts	VARCHAR(1000),
country VARCHAR(150),
data_added VARCHAR(50),
release_year	INT,
rating	varchar(10),
duration	VARCHAR(50),
listed_in	VARCHAR(100),
description VARCHAR(300)

);


SELECT * FROM NETFLIX;

SELECT COUNT(*) AS TOTAL_DATA FROM NETFLIX;


SELECT 
DISTINCT TYPE 
  FROM NETFLIX;

SELECT 
    DISTINCT DIRECTOR
	   FROM NETFLIX;



-- 15 Business Problems & Solutions

--Q 1. Count the number of Movies vs TV Shows

SELECT TYPE,
   COUNT (*) AS TOTAL_CONTENT 
       FROM NETFLIX  GROUP BY TYPE ;
--Q 2. Find the most common rating for movies and TV shows
SELECT TYPE,RATING,
  -- MAX(RATING ) AS HIGH
  COUNT(*) AS NO_OF_RATING
    FROM NETFLIX 
	   GROUP BY TYPE, RATING
	      ORDER BY TYPE,NO_OF_RATING DESC;

-- Q3. List all movies released in a specific year (e.g., 2020)
SELECT * FROM NETFLIX 
   WHERE TYPE = 'Movie'
   AND
   release_year = 2020;


-- Q4. Find the top 5 countries with the most content on Netflix

SELECT COUNTRY , COUNT(*) AS NUMBER_OF_CONT 
   FROM NETFLIX GROUP BY 1 
       ORDER BY  NUMBER_OF_CONT
	       DESC LIMIT 5 ;

SELECT 
  UNNEST(STRING_TO_ARRAY(COUNTRY,',')) AS NEW_COUNTRY,
  COUNT(SHOW_ID)AS TOTAL_CONTENT
FROM NETFLIX                                            -- THE BEST WAY OF DOING THIS IT ABOLISHES THE NULL COUNTRY AND MAKE THOSE COUNTRY INTO SINGLE ONE WHICH ARE COMBINED--
GROUP BY NEW_COUNTRY
ORDER BY TOTAL_CONTENT DESC
LIMIT 5;

-- Q5. Identify the longest movie

SELECT 
   * FROM NETFLIX WHERE 
        TYPE = 'Movie'
		and 
		DURATION = (select MAX(DURATION) FROM NETFLIX)
		  LIMIT 1;


--Q 6. Find content added in the last 5 years
select
  *
  From NETFLIX 
    WHERE 
	 TO_DATE(data_added,'Month DD,YYYY') >= current_date - Interval '5 Years';


select Current_date - Interval '5 years';


-- Q7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT * FROM NETFLIX WHERE DIRECTOR = 'Rajiv Chilaka';  -- Where Director is only 'Rajiv Chilaka'  !!!!!


SELECT * FROM NETFLIX WHERE DIRECTOR
      LIKE  '%Rajiv Chilaka%' ;  -- In this there is also some flim where other director are there with 'Rajiv Chilaka'  !!!!!
	                             --  IN THIS PROGRAM WE HAVE USED LIKE FUNCTION !!!!

	  
-- QQ 8. List all TV shows with more than 5 seasons   
 -- In this we will use split Funtion

SELECT 
  SPLIT_PART('APPLE MANGO CHERRY' , ' ',1)
 -- In this program we can see that we have splited the three world by giving them a sertain number and the answer is APPLE
--- So this is the power of split function


SELECT 
     *,
  SPLIT_PART(DURATION,' ',1) AS SEASONS
FROM NETFLIX 
where 
   type = 'TV Show'
   and 
     duration  > '5 Season'

   
-- Select * from Netflix 
 

-- Q9. Count the number of content items in each genre
select * from netflix;

select UNNEST(STRING_TO_ARRAY(LISTED_IN,',')) AS GENRA ,
COUNT(*) AS  NO_OF_CONTENT
from Netflix 
  GROUP BY  GENRA  
   ORDER BY NO_OF_CONTENT DESC;

-- Q10.Find each year and the average numbers of content release in India on netflix.
 -- omg what is this program
     
SELECT 
EXTRACT (YEAR FROM TO_DATE(data_added,'Month DD,YYYY')) AS Date,
COUNT(*),
COUNT(*)::Numeric/(SELECT COUNT(*) FROM NETFLIX WHERE COUNTRY = 'India')::Numeric* 100 As Average_content_per_year
    FROM NETFLIX 
        WHERE COUNTRY = 'India'
              GROUP BY  DATE
  

-- Select ( UNNEST(STRING_TO_ARRAY(LISTED_IN,',')) )AS GENRA , 
-- count(genra)
--  RELEASE_YEAR FROM NETFLIX WHERE 
--   COUNTRY = 'India' 
--      group by 
  
   
-- return top 5 year with highest avg content release!

-- Q11. List all movies that are documentaries

Select * from netflix where Listed_in Like  %documentary%

SELECT * FROM NETFLIX WHERE TYPE = 'Movie' and
listed_in
      LIKE  '%Documentaries%' 
	
-- 12. Find all content without a director

Select * from Netflix where director is null


-- 13. Find how many movies actor 'Salman Khan' appeared in last 15 years!

select * from Netflix where type ='Movie' and
  casts Ilike '%salman khan%'    
  and                                          -- we need the data of last 10 year's
  Release_year > Extract(year from current_date) - 15

  
-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

select
UNNEST(string_to_array(casts,',')) AS ACTORS,
     COUNT(*) AS TOTAL_CONTENTS
from Netflix
    WHERE COUNTRY ILIKE '%INDIA'
GROUP BY 1
   ORDER BY 2 DESC
LIMIT 10
-- 15.
-- Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.
WITH new_table AS (
    SELECT *,
        CASE 
            WHEN description ILIKE '%kill%' 
            OR description ILIKE '%violence%' THEN 'Bad_film'
            ELSE 'Good_content'
        END AS category
    FROM netflix
)
SELECT 
    category,
    COUNT(*) AS total_content
FROM new_table
GROUP BY category;









select * from Netflix 
 where 
   description Ilike '%kill%'
   or 
description Ilike '%violence%'
   

select String_to_array(description,',') as keys from Netflix where keys = 'Kill'

