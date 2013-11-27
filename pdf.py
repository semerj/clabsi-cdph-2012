import re
import os
import csv
import glob

input = 'text/'
output = 'csv/'
txt_files = os.path.join(input, '*.txt')

def clean_text(file):
    with open(file, 'r') as input_file:
        data = input_file.readlines()
    list = []
    for d in data:
        list.append(filter(None, re.split(r'\s{2,}', d.strip())))
    with open(os.path.splitext(file)[0] + '.csv', 'w') as output_file:
        writer = csv.writer(output_file)
        writer.writerows(list)
        
for file in glob.glob(txt_files):
    clean_text(file)
