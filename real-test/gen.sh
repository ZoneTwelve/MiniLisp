#!/bin/bash
for f in `ls *.in`;
do
  fn=`basename $f .in`
  ./smli < $f > $fn.out
done