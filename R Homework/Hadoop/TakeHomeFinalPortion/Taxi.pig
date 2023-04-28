# -- Airline Data
# Year, Month, DayofMonth, DayOfWeek, DepTime, CRSDepTime, ArrTime, CRSArrTime, UniqueCarrier, FlightNum,
# TailNum, ActualElapsedTime, CRSElapsedTime, AirTime, ArrDelay, DepDelay, Origin, Dest, Distance, TaxiIn,
# TaxiOut, Cancelled, CancellationCode, Diverted, CarrierDelay, WeatherDelay, NASDelay, SecurityDelay, LateAircraftDelay

#PigLatin Script modified by Cort Miles

#flights = load '2008.csv' using PigStorage(',');
#flight_details = FOREACH flights GENERATE $1 as month, (int)$15 AS depDelay;
#grp_month = GROUP flight_details by month;
#aveDepDelay= foreach grp_month generate group, AVG(flight_details.depDelay);
#store aveDepDelay into 'aveDepDelayByMonthPigResults';
#pig 

#PigLatin Script for Taxi modified by Cort Miles
#------------------------------------------

data = load 'wholeEnchilada.csv' using PigStorage(',');
taxiInfo = FOREACH data GENERATE $8 as airline, $16 as origin, (float) $19 as taxiIn, (float) $20 as taxiOut;
airorigincat = FOREACH taxiInfo GENERATE CONCAT(airline,'-',origin) AS airlineorigin, (float) taxiIn + taxiOut AS sumtt;
key = GROUP airorigincat by airlineorigin;
values = FOREACH key GENERATE group, MIN(airorigincat.sumtt) AS minTaxiTimebyAirlineOrigin, MAX(airorigincat.sumtt) AS maxTaxiTimebyAirlineOrigin, AVG(airorigincat.sumtt) AS aveTaxiTimebyAirlineOrigin;
store values into 'TaxiPigResultstmp';

hadoop fs -getmerge TaxiPigResultstmp tmpResults
sort < tmpResults > TaxiPigResults
hadoop fs -put TaxiPigResults
