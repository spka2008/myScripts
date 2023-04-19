#!/usr/bin/env python3

from subprocess import check_output
def fsavail (s):
    item = check_output(['lsblk', '-lnpo', 'FSAVAIL', s[0]], universal_newlines=True).split("\n")[0].strip()
    s.append(item)
    s[0]=s[0].replace('/dev/','')
    ss=s[2].split('/')
    if (len(ss) > 2):
        s[2]=ss[len(ss)-1]
    return s
def getoutputs (s):
    if (s[2]==''):
        col="gray"
    else:
        col="green"
    return "<span color='{}'>[{}] </span><i>{}: </i>{}".format(col, s[0], s[2], s[3])
lines = check_output(['lsblk', '-lpno', 'NAME,TYPE,MOUNTPOINT'], universal_newlines=True)
lines = lines.split("\n")
lines = filter(lambda s: (s.find('part')!=-1 and s.find('SWAP')==-1 and s.find('boot')==-1), lines)
lines = list(map(lambda s: s.split(' '), lines))
lines = list(map(fsavail ,lines))
outputs=list(map(getoutputs, lines))
output='|'.join(outputs)
#lines = list(map(lambda l: list(filter(lambda s: s != '',l)), lines))
print(output)
print(output)
