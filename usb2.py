#!/usr/bin/env python3

from subprocess import check_output
def attribute (s):
    item = check_output(['lsblk', '-lnpo', 'FSAVAIL,LABEL', s[0]], universal_newlines=True).split("\n")[0].strip()
    s.append(item)
    s[0]=s[0].replace('/dev/','')
    ss=s[1].split('/')
    if (len(ss) > 2):
        s[1]=ss[len(ss)-1]
    return s
def appendLines (s):
    if (len(s)==1):
        s.append('')
    elif (len(s)>2):
        del s[2:]
    return s
def getoutputs (s):
    if (s[1]==''):
        col="gray"
    else:
        col="green"
    return "<span color='{}'><b>[{}]</b> </span><i>{}: </i>{}".format(col, s[0], s[1], s[2])
lines = check_output(['lsblk', '-lpno', 'NAME,MOUNTPOINT'], universal_newlines=True)
lines = lines.split("\n")
lines = filter(lambda s: (s!='' and s.find('SWAP')==-1 and s.find('boot')==-1), lines)
lines = list(map(lambda s: s.split(), lines))
devices = check_output(['blkid', '-o', 'device'], universal_newlines=True).split('\n')
lines = list(filter(lambda s: s[0] in devices, lines))
lines = list(map(appendLines,lines))
print(lines)
lines = list(map(attribute ,lines))
outputs=list(map(getoutputs, lines))
output='|'.join(outputs)
print(output)
print(output)
