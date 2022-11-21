""" This is blah blah"""

# Use the subprocess.os module to get a list of files and directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

import subprocess
import os
#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    for f in files:
        if f.startswith("C"):
            FilesDirsStartingWithC.append(os.path.join(home,f))
        
         
    
print(FilesDirsStartingWithC)  
  
  
  
#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:


# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
FilesDirsStartingWithC_c = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    for f in files:
        if f.startswith("C"):
            FilesDirsStartingWithC_c.append(os.path.join(home,f))
    for x in files:
        if x.startswith("c"):
            FilesDirsStartingWithC_c.append(os.path.join(home,x))    

print(FilesDirsStartingWithC_c)  


#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
DirsStartingWithC_c = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    for f in dir:
        if f.startswith("C"):
            DirsStartingWithC_c.append(os.path.join(home,f))
    for x in dir:
        if x.startswith("c"):
            DirsStartingWithC_c.append(os.path.join(home,x))    



print(DirsStartingWithC_c)  

