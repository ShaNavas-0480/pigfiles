

book = load '$INPUTFILE' using TextLoader() as (lines:chararray);

transform = foreach book generate TOKENIZE(lines) as word;

transform = foreach transform generate FLATTEN(word) as word1;

describe transform;

--dump transform;

groupbyword = group transform by word1;

--dump groupbyword;

countofeachword = foreach groupbyword generate group,COUNT(transform);

--dump countofeachword;

sorted = order countofeachword by $1 asc,$0;

dump sorted;

stored = store sorted into '$OUTPUT';
