""" work for preliminary dealting with data selection and classification,
    besides, clean the dataset for pop and time >0 """

import pandas as pd

data = pd.read_csv("../data/LogisticGrowthData.csv")
print("Loaded {} columns.".format(len(data.columns.values)))

print(data.columns.values)
data.Time.min()      #check for min of time
data.PopBio.min()
data.PopBio.max()

data2 = data[(data['Time'] >= 0) & (data['PopBio'] >= 0) ]   # select the row that Time and PopBio greater than 0

data2.Time.min()     #check again for min of time
data2.PopBio.min()

## concatenate the id together as the unique ids
data2.insert(0,"ID", data.Species + "_" + data.Temp.map(str) +"_" + data.Medium + "_" +data.Citation)

# show the all groups of unique ids
print(data2.ID.unique())

# test if a row and column contains at least one missing value
print(data2.isnull().any())      # the results is none of the missing value in this data set.

# take one out for example
data_subset_1 = data2[data2['ID']=='Chryseobacterium.balustinum_5_TSB_Bae, Y.M., Zheng, L., Hyun, J.E., Jung, K.S., Heu, S. and Lee, S.Y., 2014. Growth characteristics and biofilm formation of various spoilage bacteria isolated from fresh produce. Journal of food science, 79(10), pp.M2072-M2080.']
data_subset_1.head()
data_subset_1.to_csv('../data/subset1.csv', index = False)

### contenate the whole datasets

data3= data2.ID.unique()
data3

for i in range(len(data3)):
    data_subset = data2[data2['ID']== data3[i]]
    data_subset.to_csv('../sandbox/'+str(i+1)+'.csv')

