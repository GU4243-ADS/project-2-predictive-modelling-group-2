#########################################################
### Train a classification model with training images ###
#########################################################


train <- function(dat_train, label_train, model, par = NULL){
  
  ### Train a Gradient Boosting Model (GBM) using processed features from training images
  
  ### Input: 
  ###  -  processed features from images 
  ###  -  class labels for training images
  ### Output: training model specification
  
  if(model == "gbm"){
    return(train_gbm(dat_train, label_train, par))
  } else if(model == "xgboost"){
    return(train_xgboost(dat_train, label_train, par))
  }
}

train_xgboost <- function(dat_train, label_train, par){
  library("xgboost")
  
  ### Train with xgboost
  if(is.null(par)){
    max_depth <- 2
  } else {
    max_depth <- par$max_depth
  }
  
  fit_boosted_tree <- xgboost(data = dat_train, 
                      label = label_train,
                      max.depth = max_depth, 
                      eta = 0, 
                      nthread = 2, 
                      nround = 2, 
                      objective = "binary:logistic",
                      verbose = 0)
  
  return(list(fit = fit_boosted_tree))
}

train_gbm <- function(dat_train, label_train, par){
  ### load libraries
  library("gbm")
  
  ### Train with gradient boosting model
  if(is.null(par)){
    depth <- 3
  } else {
    depth <- par$depth
  }
  fit_gbm <- gbm.fit(x = dat_train, y = label_train,
                     n.trees = 2000,
                     distribution = "bernoulli",
                     interaction.depth = depth, 
                     bag.fraction = 0.5,
                     verbose = FALSE)
  best_iter <- gbm.perf(fit_gbm, method = "OOB", plot.it = FALSE)
  return(list(fit = fit_gbm, iter = best_iter))
}