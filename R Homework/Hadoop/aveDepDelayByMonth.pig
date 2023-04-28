# -- Airline Data
# Year, Month, DayofMonth, DayOfWeek, DepTime, CRSDepTime, ArrTime, CRSArrTime, UniqueCarrier, FlightNum,
# TailNum, ActualElapsedTime, CRSElapsedTime, AirTime, ArrDelay, DepDelay, Origin, Dest, Distance, TaxiIn,
# TaxiOut, Cancelled, CancellationCode, Diverted, CarrierDelay, WeatherDelay, NASDelay, SecurityDelay, LateAircraftDelay

#PigLatin Script modified by Cort Miles

flights = load '2008.csv' using PigStorage(',');
flight_details = FOREACH flights GENERATE $1 as month, (int)$15 AS depDelay;
grp_month = GROUP flight_details by month;
aveDepDelay= foreach grp_month generate group, AVG(flight_details.depDelay);
store aveDepDelay into 'aveDepDelayByMonthPigResults';
