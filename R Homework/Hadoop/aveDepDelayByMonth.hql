create table temp_flights(tf string);
LOAD DATA INPATH '/user/maria_dev/2008.csv' OVERWRITE INTO TABLE temp_flights;
CREATE TABLE flights (month STRING, depDelay STRING);
insert overwrite table flights
SELECT 
     regexp_extract(tf, '^(?:([^,]*),?){2}', 1) month,
     regexp_extract(tf, '^(?:([^,]*),?){16}', 1) depDelay
from temp_flights;
SELECT month, sum(depDelay)/count(depDelay) FROM flights where depDelay != 'NA' GROUP BY month;
