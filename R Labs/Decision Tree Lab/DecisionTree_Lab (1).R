#Cort Miles Decision Tree Lab

#1: import rpart (just click checkbox)

#2: assign rpart to view the tree
fit = rpart(Species ~ Petal.Length + Petal.Width + Sepal.Length + Sepal.Width, 
  method = "class", data=iris, control =rpart.control(minsplit=2, cp=0.001))

#3: examine the tree
print(fit)

#4: Reset canvas
par(mar=c(5.1,4.1,4.1,2.1))

#5: Plot the tree - Note this shows no labels and just gives tree design
plot(fit, uniform=TRUE, main="Classification Tree for Iris Dataset")

#6: Look at the tree with labels
text(fit, use.n=TRUE, all=TRUE, cex=.5)
