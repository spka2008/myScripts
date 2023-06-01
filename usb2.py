#!/usr/bin/env python3

from subprocess import check_output
def attribute (s):
    item = check_output(['lsblk', '-lnpo', 'FSAVAIL,LABEL', s[0]], universal_newlines=True).split("\n")[0].strip()
    item = item.split(' ')[0]
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
    return "<span color='{}'><b>[{}]</b> </span><i>{}: </i>{}".format(col, s[0], s[2], s[3])
lines = check_output(['lsblk', '-lpno', 'NAME,TYPE,MOUNTPOINT'], universal_newlines=True)
lines = lines.split("\n")
lines = filter(lambda s: (s!='' and s.find('SWAP')==-1 and s.find('boot')==-1), lines)
lines = list(map(lambda s: s.split(' '), lines))
devices = check_output(['blkid', '-o', 'device'], universal_newlines=True).split('\n')
lines = list(filter(lambda s: s[0] in devices, lines))
lines = list(map(attribute ,lines))
outputs=list(map(getoutputs, lines))
output='|'.join(outputs)
print(output)
print(output)
