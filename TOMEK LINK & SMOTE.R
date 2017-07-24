########### Handling Unbalanced data by TOMEK & SMOTE ####################

## Creating dummy variables
set.seed(1234)
train$responded = ifelse(train$responded == "no",0,1 )
dummy = dummy.data.frame(train)
tomek = ubTomek(dummy[,-30], dummy[,30])
model_train_tomek = cbind(tomek$X,tomek$Y)
names(model_train_tomek)[30] = "responded"

## TOMEK Indices 
removed.index = tomek$id.rm

# Converting responded to factor variable
train$responded = ifelse(train$responded == 0,"no","yes")
train$responded = as.factor(train$responded)
train_tomek = train[-removed.index,]

## SMOTE
set.seed(1234)
train_tomek_smote <- SMOTE(responded ~ ., train_tomek, perc.over = 400)
table(train_tomek_smote$responded)
