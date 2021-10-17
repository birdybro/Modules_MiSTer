import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors as colors
import matplotlib.animation as animation
from random import randint

width=1024
height=1024

def generator():
    while True:
        x = randint(0,width-1)
        y = randint(0,height-1)
        yield (x,y)

def init():
    return [im]

def run(point):
    # TODO: This doesn't update the image?
    fb = im.get_array()
    fb *= 0.99   # decay
    if point:     # plot new point
        #print point
        x,y=point
        fb[y,x]=1.0
    im.set_array(fb)
    return [im]

fig,ax = plt.subplots()
# TODO: this is white to green, want black to green?
cmap = plt.get_cmap("Greens")
#ax.axis('off')
fb = np.ndarray((width,height), np.float32)
fb.fill(0)
#for x in range(width):
#    fb[x,:] *= x/float(width)
#print fb
im = ax.imshow(fb, cmap, colors.Normalize(0,1))

ani = animation.FuncAnimation(fig, run, generator, interval=1)
plt.show()

