##########
#storing objects
############

#to save an object for later use
my_dictionary = {"a key" :10, "another key": 11}

import pickle

f =open('../sandbox/testp.p', 'wb') ## the b is accept binary files
pickle.dump(my_dictionary, f)
f.close()

#load the data again 
f= open('../sandbox/testp.p', 'rb')
another_dictionary = pickle.load(f)
f.close()

print(another_dictionary)







