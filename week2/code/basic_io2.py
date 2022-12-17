#!/usr/bin/env python3
############# 
#file output
##############

#open a file for reading

list_to_save =range(100)

f = open('../sandbox/testout.txt' ,'w')
for i in list_to_save:
    f.write(str(i) +'\n')   ##add a new line at the end

f.close()









