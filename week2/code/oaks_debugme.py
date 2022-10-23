import csv
import sys
import doctest                          #import doctest to test the codes

#Define function
def is_an_oak(name):
    #import ipdb; ipdb.set_trace()          # first use idpd to find out the bug is happended in 'quercs'
    """ Returns True if name is starts with 'quercus' 
    >>> is_an_oak('Faggus sylvatica')       
        'False'
    >>> is_an_oak('quercs')
        'False'
    >>> is_an_oak('quercus')
        'True'
    >>> is_an_oak('quercuss')
        'False'
    >>> is_an_oak('qquercus')
        'False'

    """                                      # use the structure of doctest to test each situation if they could be passed.
    return name.lower().endswith('quercus')  ## the input of ('quercus') could solve the first bug that no "FOUND AN OAK" happened
                                             ## the change command of "startswith" to "endswith" could only partly solve the second bug. like the fifth test which is failed.
                                             ## the final solutions is double check by "startswith" and "endswith" command. 

def main(argv): 
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)


doctest.testmod()                           #to finish the doctest