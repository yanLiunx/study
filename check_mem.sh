#!/bin/bash

memt=$(free | awk '/Mem:/{print $2}')
memu=$(free | awk '/Mem:/{print $3}')
echo $(expr $memu \* 100 / $memt)%
