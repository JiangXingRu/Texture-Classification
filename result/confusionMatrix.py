import numpy as np
import matplotlib.pyplot as plt
from pylab import *
conf_arr=[[0,0,0,0,0,0,0,0,0,0,],
[0,0,0,0,0,0,0,0,0,0,],
[0,0,0.1,0,0,0,0,0,0,0,],
[0,0,0,0.4,0,0,0,0,0,0,],
[0,0,0,0,1,0,0,0,0,0,],
[0,0,0,0,0.4,0.8,0,0,0,0,],
[0,0,0,0,0,0.7,0.8,0,0,0,],
[0,0,0,0,0,0,0.8,0.6,0,0,],
[0,0,0,0,0,0,0,0.6,0,0,],
[0,0,0,0,0,0,0,0,0.4,0,],
];
fig = plt.figure()
plt.clf()
ax = fig.add_subplot(111)
ax.set_aspect(1)
#res = ax.imshow(conf_arr, cmap=plt.cm.jet,
               # interpolation='nearest')
res = ax.imshow(conf_arr, cmap='Reds',
                interpolation='nearest')
width = len(conf_arr)
height = len(conf_arr[0])
##for x in xrange(width):
##    for y in xrange(height):
##        ax.annotate(str(conf_arr[x][y]), xy=(y, x),
##                    horizontalalignment='center',
##                    verticalalignment='center')
cb = fig.colorbar(res)
alphabet = ['0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0'];
plt.xticks(fontsize=12)
plt.yticks(fontsize=12)
locs, labels = plt.xticks(range(width), alphabet[:width])
#for t in labels:
    # t.set_rotation(90)
#plt.xticks('orientation', 'vertical')
#locs, labels = xticks([1,2,3,4], ['Frogs', 'Hogs', 'Bogs', 'Slogs'])
#setp(alphabet, 'rotation', 'vertical')
plt.yticks(range(height), alphabet[:height])
plt.savefig('confusion_matrix.png', format='png')