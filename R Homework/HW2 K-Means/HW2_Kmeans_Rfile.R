#1.1
View(Data587)

#1.2
plot(Data587)
plot(Data587[,1:4])

#1.3
set.seed(888)

#1.4
withinSumSqrs = numeric(20)
for (k in 1:20){
  set.seed(888)
  withinSumSqrs[k] = sum(kmeans(Data587[,1:4],centers=k)$withinss)
}
dev.new(width=300, height=200, unit="px")
plot(1:20, withinSumSqrs, type='b', xlab= "#clusters", ylab="WithinSumSqrs")
#1.5
k = 5 
best_kmeans = kmeans(Data587, k)
plot(Data587, col=best_kmeans$cluster)
#1.6
normalize = function(x){(x - min(x, na.em=TRUE))/(max(x, na.em=TRUE) - min(x, na.em=TRUE))} 
norm_dataset = as.data.frame(lapply(Data587[,1:4], normalize))

#1.7 AKA #Repeat of #4
withinSumSqrs2 = numeric(20) 
for (k in 1:20) 
{
  set.seed(888)
  withinSumSqrs2[k] = sum(kmeans(norm_dataset, centers=k)$withinss)
}
dev.new(width=300, height=200, unit="px")
plot(1:20, withinSumSqrs2, type='b', xlab= "#clusters", ylab="WithinSumSqrs2")

#1.8 AKA Repeat #5
k = 4 
best_kmeans_normalized = kmeans(Data587, k)
plot(Data587, col=best_kmeans_normalized$cluster)

#2.1
d = dist(norm_dataset, method="euclidean") # Getting the distance matrix
dendo = hclust(d, method="ward.D2") 
par(mar=c(5.1, 4.1, 4.1, 2.1)) 
plot(dendo) 

#2.2
groups = cutree(fit, k=5) # Grouping and visualizing 5 clusters
rect.hclust(fit, k=5, border="red")