#!/usr/bin/env python3
####################
#File input
###################

#open a file for reading

f = open('../sandbox/test1.txt', 'r')

#use 'implicit' for loop
#if the object is a file, python will cycle ober lines

for line in f:
    print(line)

#close the file
f.close()

#same example, skilp blank lines

f=open('../sandbox/test1.txt', 'r')

for line in f:
    if len(line.strip())>0:
    print(line)

f.close()
