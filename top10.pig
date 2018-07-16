--Top find the top buyers from the txns.txt and respective details for each customer.

--1.Load the data

txn = load '/home/hduser/Downloads/tottransperfom/txns1.txt' using PigStorage(',') as (txnid, txndt, custid:int, amount:double, category, product, city, state, spendby);

txn = foreach txn generate custid,amount;

--dump txn;



--2.Group the data on custid

groupbycust = group txn by custid;

--dump groupbycust;

--describe groupbycust; 

--groupbycust: {group: int,txn: {(custid: int,amount: double)}}



--3.Aggregating the amount for each customer

sumbycust =  foreach groupbycust generate group,ROUND_TO(SUM(txn.amount),2) as total;

--dump sumbycust;



--4.

orderbyamt = order sumbycust by total desc;

top10 = limit orderbyamt 10;

--dump top10;


--5.Joining the bags

--1.Load the  customer data

cust = load '/home/hduser/Downloads/tottransperfom/custs.txt' using PigStorage(',') as (custid:int, firstname:chararray, lastname:chararray, age:int, profession:chararray);
--dump cust;

joined_cust_top10 = join top10 by $0, cust by $0;


--dump joined_cust_top10;

final = foreach joined_cust_top10 generate $0, $3, $4, $5, $6, $1;
 
--dump final; 

finaltop10 = order final by $3 desc;

dump finaltop10;
