#############################################################
### Construct visual features for training/testing images ###
#############################################################

feature <- function(img_dir, indexes="all", method="row_mean", export=T){
  
  ### Construct process features for training/testing images
  ### Sample simple feature: Extract row average raw pixel values as features
  ### This function imports all the training files, and then passes them to one of the functions defined below
  ### Which will be responsible for building the actual features
  ### The choice of method to compute features is included in the keyword argument "method"
  
  ### When you're still working on the model (debugging, not actually training it), you can work on a subset of features
  ### in order to make your code run faster. To do so, pass a list of samples (numbers corresponding to training samples)
  ### as "indexes" argument.
  
  ### Input: a directory that contains images ready for processing
  ### Output: an .RData file contains processed features for the images
  
  library(EBImage)
  
  n_files <- length(list.files(img_dir))
  
  # Read images:
  images <- list()
  
  if (indexes == "all"){
    indexes <- seq(1, n_files)
  }
  
  for(i in indexes){
    img <- readImage(paste0(img_dir,  "pet", i, ".jpg"))
    images[[length(images) + 1]] <- img
  }
  
  # Call features generation function:
  if(method == "row_mean"){
    features <- row_mean_feature(images)
  }
  
  ### output constructed features
  # if(export){
  # save(features, file = paste0("../output/feature_", data_name, "_", set_name, ".RData"))
  # }
  return(features)
}

row_mean_feature <- function(images){
  # This method turns images into grayscale, then computes mean intensity per row
  # To do so, we resize all images to 300 rows (and proportional number of columns)
  # print(dim(images))
  dat <- matrix(NA, length(images), 300)
  for(i in 1:length(images)){
    img <- images[[i]]
    gray_img <- channel(img,"gray")
    gray_img <- resize(gray_img, 300) # not specifying the last argument (y) lets keep proportions
    dat[i,] <- rowMeans(gray_img)
  }
  return(dat)
}

rgb_feature <- function(images){
  # TODO
  return()
}

hog_feature <- function(images){
  # TODO
  return()
}

sift_feature <- function(images) {
  # The sift features have already been computed
  # Download them from https://drive.google.com/a/columbia.edu/uc?id=128fqgPZa6I-ZlB_xqhFmO6KmdJyLN1nB&export=download.
  # And put them in your "output" folder
  # TODO
  return()
}