#!/bin/bash
bison -d -o main.tab.c main.y
gcc -c -g -I.. main.tab.c
flex -o main.yy.c main.l
gcc -c -g -I.. main.yy.c
gcc -o program main.tab.o main.yy.c -ll
