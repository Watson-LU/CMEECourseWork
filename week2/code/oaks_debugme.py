#!/usr/bin/env python3

""" a group work on updating a debugging practice
    using doctests to make sure there is no bug
"""

__appname__ = 'oaks_debugme'
__author__ = '01_Awesome_Aardvarks'
__version__ = '0.0.1'
__license__ = 'None'

import csv
import sys
import doctest
import re
#regular expression

#Define function
def is_an_oak(name):
    """ Returns True if name is right or have a little typo
    
    >>> is_an_oak('Fagus sylvatica')
    False
    >>> is_an_oak('Quercuss')
    True
    >>> is_an_oak('Quercus')
    True
    >>> is_an_oak('Quecuss')
    True
    >>> is_an_oak('Quecusssss')
    True
    >>> is_an_oak('Quarcus')
    True
    >>> is_an_oak('uarcus')
    True

    """
    ##never leave extra space after your expectation answers in doctest
    ##that will fail even if you get your expectation right
    
    
    # will return true even if the user misses 'r', or with multiple 's' at the end, or replace 'e' with 'a'
    ## The question mark symbol ? matches zero or one occurrence of the pattern left to it.
    ## The star symbol * matches zero or more occurrences of the pattern left to it.
    ## The plus symbol + causes the resulting RE to match 1 or more repetitions of the preceding RE. ab+ will match ‘a’ followed by any non-zero number of ‘b’s; it will not match just ‘a’.
    ## Vertical bar | is used for alternation (or operator).
    ## Parentheses () is used to group sub-patterns. 
    
    pattern = '^q?u(e|a)r?cus+$'
    if re.match(pattern, name.lower()):
        return True
    else:
        return False

doctest.testmod()
# python3 -m doctest -v your_function_to_test.py

def main(argv): 
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    next(taxa, None) # ignore the header    
    csvwrite = csv.writer(g)
    csvwrite.writerow(["Genus", "Species"])
    for row in taxa: 
        print(row)
        print ("The genus is: ")
        print(row[0] + '\n')
        #strip off the space incase someone input the space due to their habit in inputting Genes name
        if is_an_oak(row[0].strip(' ')):
            print('FOUND AN OAK!\n')
            #strip off the space incase someone input the space due to their habit in inputting Genes name
            csvwrite.writerow([row[0].strip(' '), row[1]]) 
    ## shouldn't close the file before you are still using the variables come from it
    f.close()
    g.close()   
    return 0
           
if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)

