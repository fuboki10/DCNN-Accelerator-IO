import os as os
import json

def writeLine(line, counter, file):
    doubleQ = '"'
    index = doubleQ + str(counter)+doubleQ
    number = doubleQ+line+doubleQ+'\n'
    file.writelines(index + ': '+ number)
out = open("sample.txt", "w")
out.write('{\n')
dirPath =  './Filters - Weights - Biases'
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
        dict[counter] = line
        elements = line.split(" ")
        for element in elements:
            writeLine(element, counter, out)
            counter += 1
out.write('}')

# jsonObj = json.dumps(dict)
# with open("sample.txt", "w") as outfile:
#     json.dump(outfile, dict)