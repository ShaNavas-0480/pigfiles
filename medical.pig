amy	hr	8000
jack	hr	7500
joe	finance	9000
daniel	admin	4750
tim	TS	4750
tim	TS	3500
tim	TS	2750

To find the AVG for each person?

ans: medical = load '/home/hduser/Downloads/medical' using PigStorage('\t') as (name:chararray, department:chararray, salary:long);


medical = foreach medical generate names,salary;

groupbysalary = group medical by name;

average = foreach groupbysalary generate group, AVG(medical.salary);

dump average; 
