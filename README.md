# Spring2018


# Project 2: Predictive Modelling

----


### [Project Description](doc/)

Term: Spring 2018

+ Project title: Predictive Modelling - Dogs or Cats?
+ Team Number: Group 2
+ Team Members: Jerome Kafrouni, Ayano Kase, Joo Kim, Chunzi Wang, Chuyuan Wang
+ Project summary: In this project, we built an image classification model that distinguishes between pictures of dogs and cats. The process consists of two parts: feature extraction and model training. We adopted SIFT, RGB, HOG, and HSV feature extraction methods to train on classification models GBM, Random Forest, XGBOOST, Logistics Regression, and SVM. In addition, we used Convolutional Neural Networks for feature extraction and classification. After model evaluation and comparison, the optimal model is....

### Performance Analysis

<Insert table with accuracy % and computational time>

#### Feature Extractio Methods
+ SIFT
+ RGB
+ HOG
+ HSV

#### Classification Models
+ Gradient Booster Machine
+ XGBoost
+ Random Forest
+ Logistic Regression
+ Support Vector Machine

### Github Structure

+ The root code of our project is available at [Main.Rmd](doc/main.Rmd)
+ All the feature extraction methods are written under [feature.R](lib/feature.R)
+ All the classification models are written under [train.R](lib/train.R)
+ Code for CNN is available at 
+ Data?

### Contirbution Statement

+ Jerome Kafrouni
+ Ayano Kase
+ Joo Kim
+ Chunzi Wang
+ Chuyuan Wang


Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
