import csv

#read  a file containing:
#'species, insf  ......

with open('../data/testcsv.csv' , 'r') as f:

    csvread = csv.reader(f)
    temp =[]
    for row in csvread:
        temp.append(tuple(row))
        print(row)
        print("the species is ", row[0])


#write a file containing only species name and body mass

with open('../data/testcsv.csv', 'r') as f:
    with open('../data/bodymass.csv', 'w') as g:

        csvread = csv.reader(f)
        csvwrite = csv.writer(g)
        for row in csvread:
            print(row)
            csvwrite.writerow([row[0],row[4]])






















