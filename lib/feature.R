#############################################################
### Construct visual features for training/testing images ###
#############################################################

### Generic code for any feature, will call specific functions corresponding to the "method" chosen:
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
  } else if(method == "rgb_feature"){
    features <- rgb_feature(images)
  }
  else if(method == "hog"){
    features <- hog_feature(images)
  }
  
  ### output constructed features
  # if(export){
  # save(features, file = paste0("../output/feature_", data_name, "_", set_name, ".RData"))
  # }
  return(features)
}


### Functions for each way to construct features:
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
  ### load libraries
  library("EBImage")
  # library(grDevices)
  ### Define the b=number of R, G and B
  nR <- 12
  nG <- 12
  nB <- 12 
  # we split the intensity range [0,1] into 12 bins, for each channel
  # therefore we get 1728 bins that are a partition of all possible colors
  # (since each color is a combination of red intensity, blue intensity, green intensity)
  rBin <- seq(0, 1, length.out=nR)
  gBin <- seq(0, 1, length.out=nG)
  bBin <- seq(0, 1, length.out=nB)
  mat=array()
  freq_rgb=array()
  dat <- matrix(NA, length(images), nR*nG*nB)
  
  ########extract RGB features############
  for (i in 1:length(images)){
    img <- images[[i]]
    img_as_rgb <-array(c(img,img,img),dim = c(nrow(img),ncol(img),3))
    freq_rgb <- as.data.frame(table(factor(findInterval(img_as_rgb[,,1], rBin), levels=1:nR), 
                                    factor(findInterval(img_as_rgb[,,2], gBin), levels=1:nG),
                                    factor(findInterval(img_as_rgb[,,3], bBin), levels=1:nB)))
    dat[i,] <- as.numeric(freq_rgb$Freq)/(ncol(img)*nrow(img)) # normalization
    
    mat_rgb <-img_as_rgb
    dim(mat_rgb) <- c(nrow(img_as_rgb)*ncol(img_as_rgb), 3)
  }
  
  return(dat)
}


hog_feature <- function(images){
  library("OpenImageR")
  
  n_files = length(images)
  cropped <- list()
  resized <- list()
  # Step 1: crop all images to square and centered, then resize to 64*64
  for (i in 1:n_files){
      cropped[[i]] <- if(ncol(images[[i]]) > nrow(images[[i]])){
          cropImage(images[[i]], nrow(images[[i]]) - 1, nrow(images[[i]]) - 1,
          type = "equal_spaced")
      } else {
          cropImage(images[[i]], ncol(images[[i]]) - 1, ncol(images[[i]]) - 1,
          type = "equal_spaced")
      }
      resized[[i]] <- resizeImage(cropped[[i]], 64, 64, method = "bilinear")
  }
  
  # Step 2: extract hog feature for each image (cell and orientation numbers may be changed with tuning)
  hog <- matrix(NA, nrow = n_files, ncol = 72)
  for (i in 1:n_files){
      hog[i, ] <- HOG(resized[[i]], cells = 3, orientations = 8)
  }
  
  return(hog)
}

sift_feature <- function(images) {
  # The sift features have already been computed
  # Download them from https://drive.google.com/a/columbia.edu/uc?id=128fqgPZa6I-ZlB_xqhFmO6KmdJyLN1nB&export=download.
  # And put them in your "output" folder
  # TODO
  return()
}
