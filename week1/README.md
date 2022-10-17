# Project name: Week1 practice work

## Brief Description
It is for the week1 practices and works, with the practice of writing README file. The first work is for FASTA exercise, which answer 5 questions and store the code in the UnixPrac1.txt while store the file in the data directory. The second work is for shell script, which use a "sh" file to change comma separated values and converts it to a space sperated values file. The target files are in the data directory. The last work is for LaTeX practice. To test ComplieLaTeX_practicework.sh with FirstExample.tex ,which allow others run it from their computer.

## Languages
Generally use bash and work in the both terminal and VSC.

## Dependencies
generally no

## Installation
The practice runs with the basic commands, all installations are stored in the class bootcamp, no other special projects or packages required. 

## Project stucture and Usage
The project contains two parts. The first part contains practice works during the class. The second part display the answer codes of thw whole week1 practices.
The first part is ignored. The second part is divided as FASTA exercise, Shell script and LaTeX practice.                                                                         1.In the FASTA exercise, there are 5 questions, files are stored in data directory (407228326.fasta, 407228412.fasta, E.coli.fasta):  
    Q1: the CountLines.sh script is used to cover the question. 
    Q2:  print as below:
    ```bash
     tail -n +2 filename
    ```
    Q3: print as below:
    ```bash
    tail -n +2 filename |tr -d '\n' | wc -c
    ```
    Q4:print as below:
    ```bash
    grep -o "ATGC" filename |wc -l
    ```
    Q5:use variables to refer and store caculated values: for example
    ```bash
    AA= `grep -o "A" filename |wc -l`
    ```
    then use expr to calculate, for example:
    ``` bash
    AT = $(ex[r $AA +$TT])
    ```
    ultemately, caculate the ratio in decimals use awk command:
    ratio=$(echo | awk "{print $AT/%GC}") 

2.In the shell script practice, the temperature txt files (1800.csv , 1801.csv , 1802.csv, 1803.csv) should be bashed by csvtospace.sh script as below:
    ```bash
    bash csvtospace.sh ../data/ filename
    ```

3.In the LaTeX practice, in order to enable others to ran the code in their computer, the CompileLaTeX_practicework.sh is to work for it.
    ```bash
    bash CompileLaTeX_practicework.sh FirstExample.tex
    ```

Finished.

## Author name and Contact
Author name: Jintao Lu
Contact: jl8722@ic.ac.uk




