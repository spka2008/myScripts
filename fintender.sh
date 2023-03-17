#!/bin/bash

zaja='/winC/финтендер/'$1
mkdir $zaja
d=$(date +"%Y%m%d_%H")
image="IMG_$d*"
mv /home/serg/Загрузки/маркер.pdf $zaja
mv /home/serg/Загрузки/$image $zaja
ls $zaja
