--To find the total sales,max single value transaction, min single value transaction

--SQL : select sum(amount), max(amount), min(amount) from txnrecords;

--SQL : select custid,sum(amount), max(amount), min(amount) from txnrecords group by custid;

--1.Load the data

txn = load '/home/hduser/Downloads/tottransperfom/txns1.txt' using PigStorage(',') as (txnid, txndt, custid:int, amount:double, category, product, city, state, spendby);

txn = foreach txn generate amount;

--dump txn;

--2.Group all the tuple(row)

groupall = group txn all;

--dump groupall;

totalsales = foreach groupall generate ROUND_TO(SUM(txn.amount),2), MAX(txn.amount), MIN(txn.amount);

dump totalsales;

 
