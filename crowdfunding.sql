use crowdfunding;
/*
set sql_safe_updates=0;
alter table project_1
add constraint fk_creator
foreign key (creator_id)
references creator(id);

alter table project_1
add constraint fk_location
foreign key(location_id)
references location(id);

alter table project_1
add constraint fk_category
foreign key (category_id)
references category(id);

select category_id 
from project_1 where category_id not in(select id from category);

update project_1
set category_id = null where category_id not in(select id from category);

select count(category_id) from project_1; 

alter table project_1
add constraint fk_date
foreign key (created_date)
references date(date);

show create table project_1;

create index idx_creator on project_1(creator_id);
create index idx_location on project_1(location_id);
create index idx_category on project_1(category_id);
create index idx_date on project_1(created_date);

/*
Total Amount Raised by Each Category
*/
SELECT 
    cat.name AS category_name,
    CONCAT(ROUND(SUM(p.usd_pledged) / 1000000, 2), ' M') 
        AS total_amount
FROM project_1 p
JOIN category cat 
    ON p.category_id = cat.id
GROUP BY cat.name
ORDER BY SUM(p.usd_pledged) DESC;

/*
Total Number of Projects based on outcome

*/

select state ,count(id) as total_project
from project_1
group by state 
order by total_project ;

/*
Total Number of Projects based on Locations top 10
*/

select country,count(id) as total_project from project_1
group by country
order by total_project desc limit 10;

/*
Total Number of Projects based on  Category
*/

select cat.name,count(p.id) as total_project
from project_1 p join category cat on p.category_id=cat.id
group by cat.name
order by total_project desc limit 10;
/*
Total Number of Projects created by Year
*/

select d.year ,
count(p.id) as Total_project 
from project_1 p join date d 
on p.created_date =d.date
group by d.year
order by total_project desc; 

/*
Total Number of Projects created by Quarter
*/
select d.quarter,
count(p.id) as Total_project
from project_1 p join date d
on p.created_date = d.date
group by d.quarter
order by Total_project desc;

/*
Total Number of Projects created by Month,year,quarter
*/

select d.`month name`,d.year,d.quarter,
count(p.id) as Total_project 
from project_1 p join date d
on p.created_date =d.date
group by d.`month name`,d.year,d.quarter
order by Total_project desc;

/*
    Total No of Successful Projects
*/
 select state,count(id) as Total_Project 
 from project_1
 where state =  'successful'
 group by state;
 
 /*
  Total Amount Raised
 */
   SELECT 
    CONCAT(ROUND(SUM(usd_pledged) / 1000000000, 2), ' B') 
    AS Total_Amount
FROM project_1;

/*
Total amaount Raised by Successful Project
*/

SELECT state,
    CONCAT(ROUND(SUM(usd_pledged) / 1000000000, 2), 'B') AS Total_Amount
FROM project_1
WHERE state = 'successful'
group by state;

/*
Total Number of Backers
*/
SELECT 
    CONCAT(ROUND(SUM(backers_count) / 1000000, 2), ' M') 
        AS Total_Backers
FROM project_1;

/*
Avg NUmber of Days for successful projects
*/
SELECT 
    ROUND(AVG(`project duration days`), 2) 
        AS avg_days_successful_projects
FROM project_1
WHERE state = 'successful';


/*
Top Successful Projects Based on Number of Backers
*/
SELECT 
    id,
    backers_count,
    RANK() OVER (ORDER BY backers_count DESC) AS backer_rank
FROM project_1
WHERE state = 'successful'
LIMIT 10;

/*
Top Successful Projects Based on Amount Raised
*/
SELECT 
    id AS successful_project,
    CONCAT(ROUND(usd_pledged / 1000000, 2), ' M') 
        AS Amount_Raised
FROM project_1
WHERE state = 'successful'
ORDER BY usd_pledged DESC
LIMIT 5;

/*
Percentage of Successful Projects overall
*/

SELECT 
    state,
    COUNT(*) AS total_projects,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2)
        AS Percentage
FROM project_1
GROUP BY state
ORDER BY Percentage DESC;

/*
Percentage of Successful Projects  by Category
*/
SELECT 
    c.name AS category_name,
    COUNT(*) AS total_projects,
    ROUND(
        SUM(p.state = 'successful') * 100.0 
        / COUNT(*),
    2) AS success_percentage
FROM project_1 p
JOIN category c 
    ON p.category_id = c.id
GROUP BY c.name
HAVING COUNT(*) >= 50
ORDER BY success_percentage DESC
LIMIT 10;

/*
Percentage of Successful Projects by Year , Month 
*/
SELECT 
    YEAR(launched_date) AS project_year,
    MONTHNAME(launched_date) AS project_month,
    
    COUNT(*) AS total_projects,
    
    ROUND(
        SUM(state = 'successful') * 100.0 / COUNT(*),
    2) AS success_percentage

FROM project_1
GROUP BY 
    YEAR(launched_date),
    MONTHNAME(launched_date)

ORDER BY 
    project_year,
    project_month;
    
/*

Percentage of Successful projects by Goal Range
*/
SELECT 
    `goal range`,
    COUNT(*) AS total_projects,
    ROUND(
        SUM(state = 'successful') * 100.0 / COUNT(*),
    2) AS success_percentage
FROM project_1
GROUP BY `goal range`
HAVING COUNT(*) >= 50
ORDER BY success_percentage DESC;











