
# coding: utf-8

# In[36]:

# Import all necessary packages
import math
import numpy as np
import pandas as pd
from pandas.tools.plotting import scatter_matrix
from matplotlib import pyplot as plt
import glob
from sklearn.decomposition import PCA

import matplotlib
matplotlib.style.use('ggplot')


# In[9]:

data = pd.read_csv("./Data/Data/Reduced_Census/Census/ks101ew")


# In[40]:

frame = pd.DataFrame()
dataList = []
fileNames = glob.glob('./Data/Reduced_Census/Census/ks*')
for file in fileNames:
    data = pd.read_csv(file, index_col='GeographyCode')
    dataList.append(data)
    

frame = pd.concat(dataList, axis=1)



# In[51]:

pca = PCA(n_components=2)
pca.fit(frame)
frame.isnull().values.any()
X = pca.fit_transform(frame)
plt.scatter(X[:,0], X[:,1])


# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:



