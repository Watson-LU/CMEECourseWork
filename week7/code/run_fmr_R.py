""" use subprocess to realize applying R in python script"""
import subprocess
p = subprocess.Popen(["Rscript", "fmr.R"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = p.communicate()

""" print the result and check the pdf, to know that if the results were 
    run successfully."""
print(stdout.decode())

""" record the results"""
p = subprocess.Popen("Rscript --verbose fmr.R > ../results/fmr.Rout 2> ../results/fmr_errFile.Rout", shell=True).wait

