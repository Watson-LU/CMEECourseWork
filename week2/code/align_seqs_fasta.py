#!/usr/bin/env python3

"""
Calculate the match score between two sequences. Print and save the best score and best sequence.
Usage: python3 align_seqs_fasta.py seq1.fasta seq2.fasta (in terminal)
"""

__appname__ = 'align_seqs_fasta'
__author__ = '01_Awesome_Aardvarks'
__version__ = '0.0.1'
__license__ = 'None'

import sys

def prepare_data(file1, file2):
    """Read contents of file and returns sequences without new line characters or comments"""
    f1 = open(file1, "r")
    inf1 = f1.readlines()[1:] # skip the first line (header)
    seq1 = ''.join(inf1).replace("\n", "")
    f1.close()

    f2 = open(file2, "r")
    inf2 = f2.readlines()[1:] # skip the first line (header)
    seq2 = ''.join(inf2).replace("\n", "")
    f2.close()

    return seq1, seq2


def get_inf(file1, file2):
    """define the shorter seq as seq1, another as seq2, and get the length of both sequence for further usage."""
    seq1, seq2 = prepare_data(file1, file2)
    seq1 = seq1
    seq2 = seq2
    l1 = 0
    l2 = 0
    if len(seq1) > len(seq2):
        l1 = len(seq1)
        l2 = len(seq2)
    else:
        seq1, seq2 = seq2, seq1 # swap the two sequence
        l1 = len(seq1)
        l2 = len(seq2)

    return seq1, seq2, l1, l2

def calculate_score(s1, s2, l1, l2, startpoint):
    """count the “score” as total of number of bases matched."""
    matched = ""  
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]:  # if the bases match
                matched = matched + "*"  # * indicates a match
                score = score + 1
            else:
                matched = matched + "-"  # - indicates no match
    
    return score

def find_best_alignment(file1, file2):
    """input the inf given by previous function, compare scores to find the best alignment 
    by iteratively comparing their "matching" scores, and save the alignment in a txt file. """

    s1, s2, l1, l2 = get_inf(file1, file2)

    best_align = None
    best_align_score = -1 

    for i in range(l1):
        score = calculate_score(s1, s2, l1, l2, i)
        
        if score > best_align_score:
            best_align = "." * i + s2
            best_align_score = score
    
    write_file(best_align, best_align_score,s1)
    return best_align, best_align_score


def write_file(best_align, best_align_score,s1):
    """write output into file"""
    f = open('../results/align_seqs_fasta_results.txt', 'w')
    f.write("Best alignment score:" + str(best_align_score)+ "\n")
    f.write("Best alignment: "+ str(best_align)+ "\n"+ str(s1) + "\n")
    f.close()
    print("Results have been saved into ../results/align_seqs_fasta_results.txt")



#Entry point
def main(argv):
    """main entry"""
    try:
        fasta_input1 = argv[1] # if file not found then use the default data
        fasta_input2 = argv[2]
    except (FileNotFoundError, IndexError) as error:
        print("your input has some problems, this script will use the default input")
        fasta_input1 = "../data/407228326.fasta"
        fasta_input2 = "../data/407228412.fasta"
    find_best_alignment(fasta_input1,fasta_input2)


if __name__ == "__main__":
    status = main(sys.argv) 
    sys.exit(status)