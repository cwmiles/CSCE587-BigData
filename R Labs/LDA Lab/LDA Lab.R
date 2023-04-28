#first load the appropriate libraries
#step by step commands below.

iris_data <- iris[,-5]

iris_LDA <- lfda(iris_data, iris[, 5], r = 2, metric="plain")

autoplot(iris_LDA, data = iris, frame = TRUE, frame.colour =  'Species')

autoplot(iris_LDA, data = iris, colour="Species", frame = TRUE, frame.colour = 'Species')

Iris <- data.frame(rbind(iris3[,,1], iris3[,,2], iris3[,,3]),Sp = rep(c("s","c","v"), rep(50,3)))

set.seed(587)
train <- sample(1:150, 75)

table(Iris$Sp[train])

z <- lda(Sp ~ ., Iris, prior = c(1,1,1)/3, subset = train)

iris_x <- (z$scaling[,1]) %*% t(iris[,-5])

iris_y <- (z$scaling[,2]) %*% t(iris[,-5])

plot(iris_y~iris_x)

plot(iris_y~iris_x, col=iris[,5])

test <- c(1:150)[-train]

table(Original=Iris[test,]$Sp, predict(z, Iris[test,])$class)

#load icu data

icu_LDA <- lfda(icu[,-c(1:2)], icu[, 2], r = 2, metric="plain")

autoplot(icu_LDA, data=icu, colour="STA", frame=TRUE, frame.colour='STA')
