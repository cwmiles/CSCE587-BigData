#first load the appropriate libraries
#step by step commands below.

iris_data <- iris[,-5]

iris_pca <- prcomp(iris_data, center = TRUE, scale. = TRUE)

print(iris_pca)

tot_var <- sum(sapply(iris_pca$sdev,function(x) x*x))

pct_var <- sapply(iris_pca$sdev,function(x) x*x/tot_var)

plot(pct_var, type="l")

sum(pct_var[1:2])

autoplot(iris_pca)

plot(iris_pca$x[,1:2])

autoplot(iris_pca, data = iris, colour = 'Species')

plot(iris_pca$x[,1:2], col=iris[,5])

autoplot(iris_pca, data = iris, colour = 'Species', label = TRUE, label.size = 3)

autoplot(iris_pca, data = iris, colour = 'Species', loadings = TRUE, loadings.colour = 'blue',loadings.label = TRUE, loadings.label.size = 3)
###in terminal
wget https://cse.sc.edu/~rose/587/CSV/icu.csv --no-check-certificate
###back in console
tmp <- icu[,-c(1, 2)]

pca_tmp <- prcomp(tmp, center = TRUE, scale. = TRUE)

print(pca_tmp)

plot(pca_tmp, type="l")

tot_var <- sum(sapply(pca_tmp$sdev,function(x) x*x))

pct_var <- sapply(pca_tmp$sdev,function(x) x*x/tot_var)

plot(pct_var, type="l")

sum(pct_var[1:10])

autoplot(pca_tmp)

plot(pca_tmp$x[,1:2])

autoplot(pca_tmp, data = icu, colour = 'STA')

plot(pca_tmp$x[,1:2], col=icu[,2]+1)

