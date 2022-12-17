#!/usr/bin/env python3
##find just those taxa that are oak trees from a list of species

taxa = ['Quercus robur',
'Fraxinus excelsior',
'Pinus sylvestris',
'Quercus cerris',
'Quercus petraea',]


def is_an_oak(name):
    return name.lower().startswith('quercus')     #return the lower name wich start with querus


#method 1 using for loops

oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species)

print(oaks_loops)

#get names in upper case using loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species.upper())

print(oaks_loops)

#method 2 using list comprehensions 

oaks_lc =  set([species for species in taxa if is_an_oak(species)])
print(oaks_lc)

#get names in upper case using list comprehensions
oaks_lc= set([species.upper() for species in taxa if is_an_oak(species)])
print(oaks_lc)






























