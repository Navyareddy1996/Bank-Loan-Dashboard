use Bank_LoanDB
select * from financial_loan
---Total Loan Application
select count(id) as Total_Loan_Application from financial_loan
---monitor month-to-date(MTD) Loan application and track changes month-over-month
select count(id) as MTD_Total_loan_application from financial_loan
where MONTH(issue_date)=112 and YEAR(issue_date)=2021
select count(Id) as PMTD_Total_Loan_applications from financial_loan
where month(issue_date)=11 and year(issue_date)=2021
---Total funded amount
select sum(loan_amount) as total_funded_amount from financial_loan
---monitor month_to_date total funded amount
select sum(loan_amount) as total_funded_amount from financial_loan where month(issue_date)=12 and year(issue_date)=2021
---MOM changes
select sum(loan_amount) as MTD_total_funded_amount from financial_loan
where month(issue_date)=11 and year(issue_date)=2021
---total amount received
select sum(total_payment) as total_amount_received from financial_loan
---month_to_date total amount received
select sum(total_payment) as MTD_total_amount_received from financial_loan 
where month(issue_date)=12 and year(issue_date)=2021
---MOM changes
select sum(total_payment) as PMTD_total_amount_received from financial_loan
where month(issue_date)=11 and year(issue_date)=2021
---average interest rate
select avg(int_rate) *100 as avg_interest_rate from financial_loan
select ROUND(avg(int_rate),4) *100 as avg_interest_rate from financial_loan
---month_to_date
select avg(int_rate) as MTD_avg_interest_rate from financial_loan
where month(issue_date)=12 and year(issue_date)=2021
---MOM changes
select avg(int_rate) as PMTD_avg_interest_rate from financial_loan
where month(issue_date)=11 and year(issue_date)=2021
---avg dti(debt_to_income) ratio
select avg(dti) * 100 as avg_dti_income from financial_loan
select round(avg(dti),2) * 100 as avg_dti_income from financial_loan
---month_to_date
select avg(dti) * 100 as MTD_avg_dti_income from financial_loan 
where month(issue_date)=12 and year(issue_date)=2021
---MOM changes
select avg(dti) * 100 as PMTD_avg_dti_income from financial_loan
where month(issue_date)=11 and year(issue_date)=2021
---good loan application percentage
select (count(case when loan_status='Fully Paid'or loan_status='Current' then id end) *100)/count(id) as good_loan_percentage from financial_loan
---good loan application 
select count(id) as good_loan_application from financial_loan
where loan_status='fully paid' or loan_status='current'
---godd_loan funded amount
select sum(loan_amount) as good_loan_funded_amount from financial_loan
where loan_status in('fully paid' , 'current')
---good loan received amount
select sum(total_payment) as good_loan_received_amount from financial_loan
where loan_status='fully paid' or loan_status='current'
---Bad loan application percentage
select (count(case when loan_status='charged off' then id end))*100/count(id) as bad_loan_application_percentage from financial_loan
---total bad loan application 
select count(id) as bad_loan_application from financial_loan
where loan_status='charged off'
---bad loan funded amount
select sum(loan_amount) as bad_loan_funded_amount from financial_loan
where loan_status='charged off'
---bad loan amount received
select sum(total_payment) as bad_loan_amount_received from financial_loan
where loan_status='charged off'
---loan status grid view
select loan_status,
count(id) as total_loan_applications,
sum(total_payment) as total_amount_received,
sum(loan_amount) as total_funded_amount,
avg(int_rate * 100) as inerest_rate,
avg(dti * 100)as dti
from financial_loan group by loan_status
--mtd grid view
select loan_status,sum(total_payment) as MTD_total_amount_received,
sum(loan_amount) as MTD_total_funded_amount
 from financial_loan where month(issue_date)=12 group by loan_status
 ---DASHBOARD OVERVIEW
 ---Monthly trends by issue date
 select 
 month(issue_date) as month_number,
 datename(month,issue_date) as month_name,
 count(id) as Total_loan_applications,sum(loan_amount) as total_amount_funded,
 sum(total_payment) as total_received_amount 
 from financial_loan
 group by month(issue_date),datename(month,issue_date) 
 order by month(issue_date),datename(month,issue_date) 
 ---Regional analysis by state
 select address_state,
 count(id) as total_loan_application,
 sum(loan_amount)as total_funded_amount,
 sum(total_payment) as total_amount_received 
 from financial_loan
 group by address_state
 order by address_state
 ---loan term analysis
 select term,
 count(id) as total_loan_application,
 sum(loan_amount) as total_funded_amount,
 sum(total_payment) as total_received_amount 
 from financial_loan 
 group by term 
 order by term
 ---employee length analysis
 select emp_length,
 count(id) as total_loan_application,
 sum(loan_amount) as total_funded_amount,
 sum(total_payment) as total_received_amount 
 from financial_loan 
 group by emp_length
 order by emp_length
 ---loan purpose breakdown
 select purpose,
 count(id) as total_loan_application,
 sum(loan_amount) as total_funded_amount,
 sum(total_payment) as total_received_amount 
 from financial_loan 
 group by purpose
 order by count(id) asc
 ---home ownership
 select home_ownership,
 count(id) as total_loan_application,
 sum(loan_amount) as total_funded_amount,
 sum(total_payment) as total_received_amount 
 from financial_loan 
 group by home_ownership
 order by count(id) desc
 ---in above queries we can apply filters for further queries using where clause



