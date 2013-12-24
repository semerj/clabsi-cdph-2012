import pandas as pd
import re
import os
import glob


def clip(files):
    data = pd.DataFrame()
    units = []
    for f in files:
        df = [re.split(r'\s{2,}', d.strip()) for d in f if re.findall(r'[A-Z]{5}', d)]
        df = pd.DataFrame(df)
        matched = re.findall(r'providing ([^]]*), reported', " ".join(f[0:2]).replace('\n', ''))
        if matched:
            units.append(matched[0])
            df['type'] = matched[0]
        data = data.append(df)
    data.columns = ['hosp', 'cases', 'lineDays', 'rate', 'ci', 'adherence', 'extra', 'area']
    data.replace(to_replace='-------', value='', inplace=True)
    data.loc[data.extra.notnull(), 'adherence'] = data.loc[data.extra.notnull(), 'extra']
    del data['extra']
    return data
    #data.to_csv('clip2012.csv', index=False)
    
    
def clabsi(files):
    data = pd.DataFrame()
    units = []
    for f in files:
        df = [re.split(r'\s{2,}', d.strip()) for d in f if re.findall(r'[A-Z]{5}', d)]
        df = pd.DataFrame(df)
        matched = re.findall(r'providing ([^]]*), reported', " ".join(f[0:2]).replace('\n', ''))
        if matched:
            units.append(matched[0])
            df['type'] = matched[0]
        data = data.append(df)
    
    data.columns = ['hosp', 'cases', 'lineDays', 'sir', 'ci', 'extra', 'area']
    del data['extra']
    data.to_csv('clabsi2012.csv', index=False)

#    data['ci'] = data['ci'].str.replace('[(,)]', '')
#    data['ci-low'] = data.ci.str.split().str[0]
#    data['ci-high'] = data.ci.str.split().str[1]
#    del data['ci']
#    data = data[['hosp', 'procs', 'procCount', 'infCount', 'sir', 'ci-low', 'ci-high', 'comp']]
    
#    data.to_csv('clip2012.csv', index=False)    


if __name__ == "__main__":
    filenames = glob.glob('*.txt')
    clipfiles = [open(name).readlines() for name in filenames[0:14]]
    clabsifiles = [open(name).readlines() for name in filenames[15:37]]
    clip(clipfiles)
    #clabsi(clabsifiles)
