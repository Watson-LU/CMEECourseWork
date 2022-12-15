#!/usr/bin/env python3

"""This script is python version of get_TreeHeight.R"""

__appname__ = 'get_TreeHeight.py'
__author__ = '01_Awesome_Aardvarks'
__version__ = '0.0.1'
__license__ = 'None'

import sys
import numpy as np
import csv


def Cal_TH(degrees, distance):
    """Calculates the height of a tree given distance of each tree
    from its base and angle to its top, using the trigonometric formula"""

    radians = degrees * np.pi / 180
    height = distance * np.tan(radians)

    return height

def main(argv):
    """Main entry point of program"""
    try:
        input = sys.argv[1]
    except (FileNotFoundError, IndexError) as error:
        print("Your input is nonsense! We will work on trees.csv file.")
        input = "../data/trees.csv"

    
    Treedata = []
     
    with open(input) as f:
    # Append file to list
      mydata = csv.reader(f)

      for row in mydata:
          Treedata.append(row)

    # Add tree heights to list
    Treedata[0].append("Tree.Height.m")

    for i in range(1, len(Treedata)):
        Treedata[i].append(Cal_TH( float(Treedata[i][2]), float(Treedata[i][1]) ))
    
    path = "../results/" + input.split("/")[2].split(".")[0] + "_treeheights.csv"

    w = open(path, 'w')
    write = csv.writer(w)
    for row in Treedata:
        write.writerow(row)
          

if __name__ == '__main__':
    status = main(sys.argv)
    sys.exit(status)