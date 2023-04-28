###CSCE 587 HW Decision Tree
###Cort Miles
###Notes for steps in txt file.

for (i in 1:6)
{
  if(i == 1)
  {
    cpval <- 0.008
    print(sprintf("cpval is",cpval, fmt='%s %#.5f'))
  }
  else
  {
    cpval <- cpval/2
    print(sprintf("cpval is",cpval, fmt='%s %#.5f'))
  }
  
  for (i in 1:9)
  {
    # the indices for the ith test partition
    test_indices = c(class0[i,],class1[i,])
    
    # the ith test partion
    test_partition = titsub[test_indices,] 
    
    # the ith training parition
    train_partition = titsub[-test_indices,] 
    
    # train the ith tree model
    m <- rpart( Survived ~ Pclass + Sex + Age + SibSp +Parch, data =train_partition, 	method="class", control=rpart.control(minsplit=2,cp=cpval))
    
    # aggregate the results from the 10 models
    if (i==1) confMat = table(predict(m, test_partition[,2:6], type= 'class'), 	test_partition[,1])
    else confMat = confMat + table(predict(m, test_partition[,2:6], type='class'), 	test_partition[,1])
  }
  
  print(sprintf("Step 2: The sensitivity on the test partitions is",sensitivity(confMat)*100,fmt='%s %#.2f'))
  print(sprintf("Step 2: The specificity on the test partitions is",specificity(confMat)*100,fmt='%s %#.2f'))
  
  
  for (i in 1:9)
  {
    # the indices for the ith test partition
    test_indices = c(class0[i,],class1[i,])
    
    # the ith test partion
    test_partition = titsub[test_indices,] 
    
    # the ith training parition
    train_partition = titsub[-test_indices,] 
    
    # train the ith model
    m <- rpart( Survived ~ Pclass + Sex + Age + SibSp +Parch, data =train_partition, 		 method="class", control=rpart.control(minsplit=2,cp=cpval))
    
    # aggregate the results from the 10 models
    if (i==1) confMat = table(predict(m, train_partition[,2:6], type= 'class'), 	train_partition[,1])
    else confMat = confMat + table(predict(m, train_partition[,2:6], type='class'), 	train_partition[,1])
    
  }
  print(sprintf("Step 4: The sensitivity on the training partitions is",sensitivity(confMat)*100,fmt='%s %#.2f'))
  print(sprintf("Step 4: The specificity on the training partitions is",specificity(confMat)*100,fmt='%s %#.2f'))
  
  
}

