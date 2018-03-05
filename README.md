# Spring2018


# Project 2: Predictive Modelling

----


### [Project Description](doc/)

![](figs/dogscats_descrp.png)

Term: Spring 2018

+ Project title: Predictive Modelling - Dogs or Cats?
+ Team Number: Group 2
+ Team Members: Jerome Kafrouni, Ayano Kase, Joo Kim, Chunzi Wang, Chuyuan Zhou
+ Project summary: In this project, we built an image classification model that distinguishes between pictures of dogs and cats. The process consists of two parts: feature extraction and model training. We adopted SIFT, RGB, HOG, and HSV feature extraction methods to train on classification models GBM, Random Forest, XGBOOST, Logistics Regression, and SVM. In addition, we used Convolutional Neural Networks for feature extraction and classification. After model evaluation and comparison, we find that the optimal model is CNN. However, the trade-off between accuracy and time is an area for further improvement. 
+ Performance Analysis

![](figs/performance_result.png)

#### Contribution Statement

+ Jerome Kafrouni
+ Ayano Kase
  - Built, trained, and tested SVM (linear and rbf) on all the features
  - Created README.md
  - Contributed to the presentation slide deck
+ Joo Kim
+ Chunzi Wang
+ Chuyuan Zhou
  - Built, trained, and tested GBM on all features 
  - Contributed to README.md
  - Contributed to the presentation slide deck


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
