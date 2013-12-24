import pandas as pd
import re
import os
import glob


def clip(files):
    data = pd.DataFrame()
    units = []
    for f in files:
        df = [re.split(r'\s{2,}|\,(?=\d)', re.sub('[()]', '', d.strip())) for d in f if re.findall(r'[A-Z]{5}', d)]
        df = pd.DataFrame(df)
        matched = re.findall(r'providing ([^]]*), reported', " ".join(f[0:2]).replace('\n', ''))
        if matched:
            units.append(matched[0])
            df['type'] = matched[0]
        data = data.append(df)
    data.columns = ['hosp', 'cases', 'lineDays', 'rate', 'ciLow', 'ciHigh', 'adherence', 'extra', 'area']
    data.replace(to_replace='-------', value='', inplace=True)
    data.loc[data.extra.notnull(), 'adherence'] = data.loc[data.extra.notnull(), 'extra']
    data.drop_duplicates(inplace=True)
    del data['extra']
    data.to_csv('clip2012.csv', index=False)
    
    
def clabsi(files):
    data = pd.DataFrame()
    units = []
    for f in files:
        df = [re.split(r'\s{2,}|\,(?=\d)', re.sub('[()]', '', d.strip())) for d in f if re.findall(r'[A-Z]{5}', d)]
        df = pd.DataFrame(df)
        matched = re.findall(r'providing ([^]]*), reported', " ".join(f[0:2]).replace('\n', ''))
        if matched:
            units.append(matched[0])
            df['type'] = matched[0]
        data = data.append(df)
    
    data.columns = ['hosp', 'cases', 'lineDays', 'sir', 'ciLow', 'ciHigh', 'extra', 'area']
    data.replace(to_replace='-------', value='', inplace=True)
    data.drop_duplicates(inplace=True)
    del data['extra']
    #data[data.duplicated()]
    data.to_csv('clabsi2012.csv', index=False)

if __name__ == "__main__":
    filenames = glob.glob('*.txt')
    clipfiles = [open(name).readlines() for name in filenames[0:14]]
    clabsifiles = [open(name).readlines() for name in filenames[15:37]]
    clip(clipfiles)
    clabsi(clabsifiles)
