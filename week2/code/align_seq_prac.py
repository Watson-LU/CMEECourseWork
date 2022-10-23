
import csv

#To imput sequences from a csv file
with open ("../data/Seq.csv", "r") as Seq:  #read the file named Seq in the data file. but could use another file by change the name
                                            #use with open to avoid forget f.close().

    csvread = csv.reader(Seq)
    seq =[] 
    for row in csvread:
        seq.append(tuple(row))
        print(row)

print(seq)                  #to check the list

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

seq_2 = seq[1]                      ##same codes with align_seqs.py
seq_1 = seq[0]

seq2 = ''.join(seq_2)
seq1 = ''.join(seq_1)

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1                 # swap the two lengths

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)

def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 
        my_best_score = z 
print(my_best_align)
print(s1)
print("Best score:", my_best_score)


##write the results into a new file named bestscore.txt in the data file
with open('../data/bestscore.txt', 'w') as best:
    print(f"the best align sequence is: {my_best_align}" , file = best)
    print(f"the best score is : {my_best_score}" , file = best)

