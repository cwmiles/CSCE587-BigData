#Cort Miles
#Time S Lab
library("astsa", lib.loc="~/R/x86_64-redhat-linux-gnu-library/3.5")
# for data set
(mydata = c(1,2,3,2,1))
(mydata = as.ts(mydata))
(mydata = ts(mydata,start=1950))
(mydata = ts(mydata,start=c(1950,3),frequency=4))
time(mydata)
(x=window(mydata,start=c(1951,1),end=c(1951,3)))
#create a new time series
x=ts(1:5)
#now add two lagged columns: 2nd col shift time base back, 3rd col shift forward
cbind(x,lag(x),lag(x,-1))
ts.intersect(x, lag(x,1), lag(x, -1))
diff(x)
#Note: diff(x,2) isnt the 2nd order differencing, the 2nd order differencing is given by
diff(diff(x))

x=-5:5
y=5*cos(x)

op=par(mfrow=c(3,2))
plot(x,main="plot(x)")
plot(x,y,main="plot(x,y)")
plot.ts(x,main="plot.ts(x)")
plot.ts(x,y,main="plot.ts(x,y)")
#time series plot function on x & y
ts.plot(ts(x),ts(y),col=1:2,main="ts.plot(x,y)")
#reset the graphical paramters
par(op)
set.seed(1999)
#sample 10 points normally distributed w mu=0 and sd=1
x = rnorm(10,0,1)
y=x+rnorm(10,0,1)
summary(fit <- lm(y~x))
plot(x,y)
abline(fit)
resid(fit)
fitted(fit)
lm(y~0 + x)
#load data sets cmort – cardiovascular mortality and part – particulate pollution
data(cmort, part)
#find the time series intersection with cmort, part, and part lagged
#4 weeks gets rid of non-overlaping sections of part & part4
ded = ts.intersect(cmort,part,part4=lag(part,-4), dframe=TRUE)
fit = lm(cmort~part+part4, data=ded, na.action=NULL)
summary(fit)
#load Johnson&Johnson quarterly earnings
data(jj)
trend = time(jj)-1970
#Create an array of factors corresponding to quarters
Q = factor(rep(1:4,21))
reg = lm(log(jj)~0 + trend + Q, na.action=NULL)
model.matrix(reg)
summary(reg)
#AR(1) with mean 50
x = arima.sim(list(order=c(1,0,0),ar=.9),n=100)+50
plot(x)
x = arima.sim(list(order=c(2,0,0),ar=c(1,-.9)),n=100)
plot(x)
x = arima.sim(list(order=c(1,1,1),ar=.9,ma=-.5),n=200)
plot(x)
#we want reproduceable results
set.seed(555)
# run simulation for 200 points
x = 50 + arima.sim(list(order=c(1,0,1),ar=.9, ma=-.5),n=200)
# display autocorrelation function & partial autocorrelation function
acf(x); pacf(x)
#or use this function to plot both
acf2(x)
#fit to model
(x.fit = arima(x,order=c(1,0,1)))
#fit the ARIMA model assuming ARIMA(1,0,1)
sarima(x,1,0,1)
# finally forecast using x and an ARIMA(1,0,1) model
sarima.for(x,10,1,0,1)
