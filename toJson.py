import os as os
import json

def writeLine(line, counter, file):
    doubleQ = '"'
    index = doubleQ + str(counter)+doubleQ
    number = doubleQ+line+doubleQ+'\n'
    file.writelines(index + ': '+ number)

out = open("cnn.json", "w")

dirPath =  './files'
files = os.listdir(dirPath)
counter = 1
dict = {}

for file in files:
    f = open(dirPath + '/' +file, 'r')
    lines = f.readlines()
    for line in lines:
        line = line.replace("\n", "")
        if line == "" or line == "----------------------":
            continue
        elements = line.split(" ")
        for element in elements:
            dict[counter] = float(element)
            counter += 1

json.dump(dict, out)