create database loan
use loan

CREATE TABLE `Loan_payments_data` (
	`Loan_ID` VARCHAR(11) NOT NULL, 
	loan_status VARCHAR(18) NOT NULL, 
	`Principal` DECIMAL(38, 0) NOT NULL, 
	terms DECIMAL(38, 0) NOT NULL, 
	effective_date DATE NOT NULL,
    effective_month VARCHAR(17),
	due_date DATE NOT NULL, 
	paid_off_time VARCHAR(17), 
	past_due_days Varchar(20) not null, 
	age DECIMAL(38, 0) NOT NULL, 
	education VARCHAR(20) NOT NULL, 
	`Gender` VARCHAR(6) NOT NULL
);


load data infile 
"E:\Loan_payments_data.csv"
into table `Loan_payments_data`
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows ;

select * from `Loan_payments_data` 

# Important Questions that can be Extracted From this Dataset are given below 

# 1. What is the average loan amount?

select avg(Principal) as Average_loan_Amount from `Loan_payments_data`

# 2. What is the most common loan term (in Days)?

select terms, count(*) as number_of_times_Repeated from `Loan_payments_data` 
group by terms
order by number_of_times_Repeated desc
limit 1

# 3. What is the delinquency rate for loans? 

# The percentage of loans that are not being repaid on time. 
# You can calculate the delinquency rate by dividing the number of delinquent loans by the total number of loans and multiplying by 100. 
# A loan is considered delinquent if the paid_off_time is later than the due date.

select  * from `Loan_payments_data` 

SELECT COUNT(*) AS delinquent_loans , (COUNT(*)/500)*100 as delinquency_rate
FROM `Loan_payments_data` 
WHERE paid_off_time > due_date

# 4. find loans with a term less than 1 month:

select * from `Loan_payments_data` 
where terms < 30
order by terms desc

# 5. Distribution of loan amounts by education level:

select education , sum(Principal) as Total_Amount  from `Loan_payments_data` 
group by education

# 6. Most common loan terms:

select Principal , terms,count(*) as Number_of_Times from `Loan_payments_data`
group by terms

# 7. Average time to pay off a loan (in days):

select paid_off_time,due_date, Avg(DATEDIFF(due_date,paid_off_time))as Average_time_to_pay_off_a_loan from `Loan_payments_data`


# 8. Total loan Amount :

select sum(Principal) as Total_Loan_Amount from `Loan_payments_data`

# 9. Total loan Amount Remaining after PAIDOFF :

SELECT loan_status , sum(Principal) as Total_Amount
FROM `loan_payments_data`
group by loan_status
having loan_status != 'PAIDOFF'


# 10. Number of loans taken by male ?

select Gender ,loan_status,count(loan_status) No_of_paidoff_Loans_Taken from `Loan_payments_data` 
where loan_status = 'PAIDOFF'

select Gender ,loan_status,count(loan_status) No_of_collection_Loans_Taken from `Loan_payments_data` 
where loan_status = 'COLLECTION'

select Gender ,loan_status,count(loan_status) No_of_collection_paid_off_Loans_Taken from `Loan_payments_data` 
where loan_status = 'COLLECTION_PAIDOFF'

# 10. Number of loans taken by gender ?

select Gender , count(Gender) as Number_of_Loans_Taken from `Loan_payments_data`
group by Gender

# 11. Amount of loans taken by loan status catagory ?

select loan_status , sum(Principal) as Total_loan_amount from `Loan_payments_data`
group by loan_status

# 12. Amount of loans taken by Month ?

select effective_month , sum(Principal) as Total_Amount_of_loan_Given from `Loan_payments_data`
group by effective_month
order by Total_Amount_of_loan_Given desc

