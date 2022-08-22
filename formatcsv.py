#!/bin/python3

import os
import csv

if (len(os.sys.argv) == 1):
    os.system("cat > ggg")
else:
    os.system("cat "+os.sys.argv[1]+ " > ggg")
if (os.stat("ggg").st_size != 0):
    wf=[]
    with open("ggg","r") as file:
        reader=csv.reader(file)
        rr=next(reader)
        for item in rr:
            wf.append(len(item))
        for row in reader:
            i=0
            for item in row:
                if (wf[i]<len(item)) : wf[i]=len(item)
                i+=1
    with open("ggg","r") as file:
        reader=csv.reader(file)
        for row in reader:
            i=0
            for item in row:
                format_xl= "{:"+str(wf[i])+"s} "
                print(format_xl.format(item), end="|")  
                i+=1
            print("\n")
os.remove("ggg")

