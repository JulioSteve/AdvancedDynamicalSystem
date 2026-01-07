import numpy as np
import scipy as sp
import matplotlib.pyplot as plt

x1 = np.fromfile('x1.bin', dtype=float)
v1 = np.fromfile('v1.bin', dtype=float)
dt = 0.1
t = np.linspace(0,1000,len(x1))

fig, ax = plt.subplots(1,2, layout="constrained", figsize=(1920/300,1080/300))
ax[0].plot(t,x1, marker=",", ms=1, ls="None", color="black")
ax[0].set_title("Trajectory")
ax[1].plot(x1,v1, marker=",", ms=1, ls="None", color="black")
ax[1].set_title("Phase space")
plt.show()/home/jules/Bureau/Github/Astronomy2/N/HandsOn1.ipynb