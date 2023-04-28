#! /usr/bin/env python

import sys
last_key = None
count = 0
sum = 1
min = 1
max = 1

# keys come grouped together
# so we need to keep track of state a little bit
# thus when the key changes , we need to reset
# our counter, and write out the count we've accumulated

for line in sys.stdin:
   line = line.strip()
   key, value1, value2 = line.split("\t")

   # we have to be able to deal with missing values
   
   if value1 =="NA" and value2=="NA":
       continue
   elif value1 == "NA": #for if the TaxiIn is "NA"
       value = float(value2)
   elif value2 == "NA": #for if the TaxiOut is "NA"
       value = float(value1)
   else: #otherwise we join 
       value = float(value1)+float(value2)

   # if this is the first iteration
   if not last_key:
       last_key = key
       count = 1
       sum = value
       min = value
       max = value
       
    # if they're the same, log it
   elif key == last_key:
        count = count + 1
        sum = sum + value
        #check for new min and maxes
        if value > max:
            max = value
        if value < min:
            min = value

   else: 
        result = [last_key,float(min),float(max),float(sum/count)]
        print("\t".join(str(v) for v in result))
        last_key = key
        count = 1
        sum = value
        #reset or min and max will be wrong.
        min = value
        max = value

# this is to catch the final value that we output
# the float(sum/count can stay) we just need to add caculation for the min and max
print("\t".join(str(v) for v in [last_key,float(min),float(max), float(sum/count)]))