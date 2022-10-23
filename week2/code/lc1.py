birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

##step1
latin_names = list(latin[0] for latin in birds)    # use list comprehension to code with latin name
print(latin_names)
##step2
common_names = list(common[1] for common in birds ) # also use list comprehension method
print(common_names)
##step3
mean_body_masses = list(mean [2] for mean in birds) #use list comprehension method
print(mean_body_masses)

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

##step1                         #use for loop to list the certain name of each species
latin_names2 = []               #create the empty list   
for i in birds:                 #for loop to find value in lists that already exist
    latin_names2.append(i[0])   #take the each value into the empty list           

print(latin_names2)                 #the same as above command
##step2
common_names2 = []
for k in birds:
    common_names2.append(k[1])

print(common_names2)                #the sme as above command
##step3
mean_body_masses2 = []
for m in birds:
    mean_body_masses2.append(m[2])

print(mean_body_masses2)


 