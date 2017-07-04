# Pattern-Recognition
LDA, KNN, GA, K-means on Iris, Sonar and USPS datasets.

## Data Sets
### URL Sources
- [Iris](http://archive.ics.uci.edu/ml/datasets/Iris)
- [Sonar](http://ftp.ics.uci.edu/pub/machine-learning-databases/undocumented/connectionist-bench/sonar/)
- [abalone](http://ftp.ics.uci.edu/pub/machine-learning-databases/abalone/)
- [wine](http://ftp.ics.uci.edu/pub/machine-learning-databases/wine/)
- [mnist](http://yann.lecun.com/exdb/mnist/) : handwritten digits by Yann LeCun
- [CIFAR-10](http://www.cs.toronto.edu/~kriz/cifar.html) : in 10 classes, with 6000 images per class
- [USPS](http://www-i6.informatik.rwth-aachen.de/~keysers/usps.html) :  postal code; the United States Postal Service datasets
- [Yale Face Database](http://vision.ucsd.edu/content/yale-face-database)
- [Extended Yale Face Database B](http://vision.ucsd.edu/~leekc/ExtYaleDatabase/ExtYaleB.html)

*github do not support ftp link yet*

### Iris Plants Database
#### Introduction
This is perhaps the best known database to be found in the pattern recognition literature. Fisher's paper is a classic in the field and is referenced frequently to this day.

The data set contains **3 classes of 50 instances each**, where each class refers to a type of iris plant. One class is linearly separable from the other 2; the latter are NOT linearly separable from each other.

#### Attributes Information
1. sepal length in cm
2. sepal width in cm
3. petal length in cm
4. petal width in cm
5. class: Setosa / Versicolour / Virginica

### Sonar, Mines vs. Rocks
#### Summary
This is the data set used by Gorman and Sejnowski in their study
of the classification of sonar signals using a neural network.  The
task is to train a network to discriminate between sonar signals bounced
off a metal cylinder and those bounced off a roughly cylindrical rock.

#### Description
The file "sonar.mines" contains **111 patterns** obtained by bouncing sonar
signals off a metal cylinder at various angles and under various
conditions.  The file "sonar.rocks" contains **97 patterns** obtained from
rocks under similar conditions.  The transmitted sonar signal is a
frequency-modulated chirp, rising in frequency.  The data set contains
signals obtained from a variety of different aspect angles, spanning 90
degrees for the cylinder and 180 degrees for the rock.

Each pattern is a set of **60 numbers** in the range 0.0 to 1.0.  Each number
represents the energy within a particular frequency band, integrated over
a certain period of time.  The integration aperture for higher frequencies
occur later in time, since these frequencies are transmitted later during
the chirp.

The label associated with each record contains the letter "R" if the object
is a rock and "M" if it is a mine (metal cylinder).  The numbers in the
labels are in increasing order of aspect angle, but they do not encode the
angle directly.

### USPS Dataset
The dataset consists of a training set (usps_train.jf, 1.4M) with **7291 images** and a test set (usps_test.jf, 390k) with **2007 images**.
The ".jf" format is an ASCII data file format we use because of easy portability (although the files are somewhat large) it contains:

line 1:
[number of classes [integer]] [number of features [integer]]

line 2...I+1:
[classnumber of pattern i [integer in [0;number of classes-1]]]
[features of pattern i [double]]

line I+2:
-1 (this is the end marker)

The features are floating point in [0,2] for "historical" reasons.
But this dataset **scaled to [-1:1]** instead of [0:2].

## Function List
### alg_Accuracy
alg_Accuracy computes classification accuracy  

  `ACCURACY = alg_Accuracy(PREDICT,LABEL)`  
   returns the value of accuracy.  

   PREDICT and LABEL must be a column vector with the same number of rows.
   November 2, 2016, by HanzheTeng

### alg_CrossValidation
alg_CrossValidation generates K-fold cross-validation data  

  `[TRAIN,TEST] = alg_CrossValidation(DATA,K)`  
   returns matrices with K pages for training and testing in a K-fold  
   cross-validation.  

   The row number of DATA must be divisible by K.  
   This algorithm extracts samples from DATA every K rows.  
   You can use one page of TRAIN/TEST for each validation.  
   Rows represent samples.  
   Columns represent the dimensions of samples.  
   November 2, 2016, by HanzheTeng

### alg_Fisher
alg_Fisher   [Linear Discriminant Analysis](https://en.wikipedia.org/wiki/Linear_discriminant_analysis) based on Fisher's Criterion  

   `[W,W0] = alg_Fisher(CLASS1,CLASS2)`  
   returns an eigenvector W along the optimal projective direction  
   and a value W0 as the threshold.  

   CLASS1 and CLASS2 must be matrices with the same number of columns.  
   Rows represent samples.  
   Columns represent the dimensions of samples.  
   November 2, 2016, by HanzheTeng  

### alg_KNN
alg_KNN   [K-Nearest Neighbors](https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm) Algorithm  

   `TEST_PREDICT = alg_KNN(TRAIN,TRAIN_LABEL,TEST,K)`  
   returns a column vector containing labels.  

   K is the number of the nearest neighbors.  
   TRAIN and TRAIN_LABEL must have the same number of rows.  
   TRAIN and TEST must be matrices with the same number of columns.  
   TRAIN_LABEL must have only one column.  
   Rows represent samples.  
   Columns represent the dimensions of samples.  
   This algorithm is based on Euclidean distance.  
   November 8, 2016, by HanzheTeng  

### alg_Kmeans
alg_Kmeans   [K-means Clustering](https://en.wikipedia.org/wiki/K-means_clustering) Algorithm  

   `KLABEL = alg_Kmeans(DATA,K)`  
   returns a column vector containing labels.  

   By default, kmeans uses squared Euclidean distances.  
   December 2, 2016, by HanzheTeng  

### alg_GeneticAlg
alg_GeneticAlg   [Genetic Algorithm](https://en.wikipedia.org/wiki/Genetic_algorithm)  

  `BESTGENE = alg_GeneticAlg(DATA,LABEL,GEN,POPU,Pc,Pm)`  
   returns the best gene vector.  

   GA for feature selection.  
   November 21, 2016, by HanzheTeng  

### alg_SFS
alg_SFS   Sequential Forward Selection  

   `[X,FITS] = alg_SFS(DATA,LABEL)`  
   returns a vector and its fitness.  

   SFS for feature selection.  
   November 21, 2016, by HanzheTeng  

### usps_imshow
usps_imshow shows the images of uspadata in x rows y columns  

   `usps_imshow(USPSDATA,X,Y)`

   November 10, 2016, by HanzheTeng  
