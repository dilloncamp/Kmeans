# -*- coding: utf-8 -*-
"""
Created on Mon Apr 23 14:03:19 2018

@author: dillon
"""

from skimage import io
from sklearn.cluster import KMeans
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as image

img = io.imread('bird_small.png')
img_r = (img / 255.0).reshape(-1,3)

#Fit K-means on resized image. n_clusters is the desired number of colors 
k_colors = KMeans(n_clusters=128).fit(img_r)
#Assign colors to pixels based on their cluster center
#Each row in k_colors.cluster_centers_ represents the RGB value of a cluster centroid
#k_colors.labels_ contains the cluster that a pixel is assigned to
#The following assigns every pixel the color of the centroid it is assigned to
img128=k_colors.cluster_centers_[k_colors.labels_]
#Reshape the image back to 128x128x3 to save
img128=np.reshape(img128, (img.shape))
#Save image
image.imsave('img128.png',img128)

