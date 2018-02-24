# NY-Property-Fraud-Detection
Trying to find unusual observations in the NY Property dataset. 

1. NY Data Cleaning.ipynb -> Cleaning the data for fields considered important and used for further analysis
2. Variable Creation.r -> Creating expert variables
3. Zscore_PCA.ipynb -> Z-scale the variables -> Perform PCA -> Z-scale again
4. autoencoders.ipynb -> Running autoencoder with 3 hidden layers (1 code layer, 1 encoding and 1 decoding layer) 
5. Binning.r -> After performing heuristic calculations and autoencoders, performing quantile binning and scoring records based on bin it belongs. 

We have used two algorithms in conjecture to find unusual observation. One was simple adding the z scores of derived, z-saled PCA's to see how far the observation is from the origin. Second method was encoder. The results were combined from the two methods and binning was performed. Top records were then examined for unusual behavior. 
