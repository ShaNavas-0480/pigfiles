

retail = load '/home/hduser/Downloads/retail/retail data/D12' using PigStorage(';') as (trn_dt:chararray, custid:chararray, age, zip, category, product, qty, cost, sales:long);

retail = foreach retail generate trn_dt,custid,sales;

--retail10 = limit retail 10;

--dump retail10;

groupall = group retail all;

--describe groupall;

maxsales = foreach groupall generate MAX(retail.sales);

--dump maxsales;

describe maxsales;

highvalcost = filter retail by sales == maxsales.$0;

dump highvalcost;

store highvalcost into '/home/hduser/pig/Retail_A1'using PigStorage(',');
