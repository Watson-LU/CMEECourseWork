#!/usr/bin/env python3

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

 
taxa_dic1 = {r[0] for r in taxa if 'Carnivora' in r[1] }
print("Carnivora:",taxa_dic1)                                   #search Carnivora in taxa and output the latin name into the new dictionary
taxa_dic2 ={r[0] for r in taxa if 'Afrosoricida' in r[1] }
print("Afrosoricida:",taxa_dic2)                                #search Afrosoricida in taxa and output the latin name into the new dictionary
taxa_dic3 ={r[0] for r in taxa if 'Rodentia' in r[1] }
print("Rodentia:",taxa_dic3)                                    #search Rodentia in taxa and output the latin name into the new dictionary
taxa_dic4 ={r[0] for r in taxa if 'Chiroptera' in r[1] }
print("Chiroptera:",taxa_dic4)                                  #search Chiroptera in taxa and output the latin name into the new dictionary

taxa_dic = { "Carnivora" :taxa_dic1 , "Afrosoricida" :taxa_dic2 , "Rodentia" :taxa_dic3 , "Chiroptera" :taxa_dic4 }
print(taxa_dic)                                                 #let all outcome into one set,if the single output is find,just ignore this step!


# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc.
#  OR,
# 'Chiroptera': {'Myotis lucifugus'} ... etc
