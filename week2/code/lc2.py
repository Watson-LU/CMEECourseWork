# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
 
#Step1:
# Months and rainfall values when the amount of rain was greater than 100mm:
rain_great_100mm = set([ r1 for r1 in rainfall if r1[1] > 100]) 
print(rain_great_100mm)                       #use comprehensions method to list certain value in rainfall into a new tuple 

# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

#Step2:
#Months and rainfall values when the amount of rain was greater than 50mm:
rain_great_50mm = set([ r2 for r2 in rainfall if r2[1] > 50]) 
print(rain_great_50mm)                       #similar command as above

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

#step3.1:
rain_great_100mm_1 = set()              #create a new empty set          
for r11 in rainfall:                    #find certain value in rainfall list
    if r11[1] > 100:                    #use if statement to find the rainfall bigger than 100mm            
        rain_great_100mm_1.add(r11)     #add the value that meet the requirement into the new set    

print(rain_great_100mm_1)               #print the new set


#step3.2:
rain_great_50mm_1 = set()
for r22 in rainfall:
    if r22[1] >50:                      #similar command as above
        rain_great_50mm_1.add(r22)

print(rain_great_50mm_1)




 

