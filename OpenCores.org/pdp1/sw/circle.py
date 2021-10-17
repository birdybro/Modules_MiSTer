from math import *
from time import sleep
from sys import stdout

t=0
while True:
    print cos(t), sin(t)
    stdout.flush()
    sleep(0.0002)
    t+=0.001
