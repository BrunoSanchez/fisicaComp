#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  graficos.py
#
#  Copyright 2016 Bruno S <bruno@oac.unc.edu.ar>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#
#
from astropy.io import ascii
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt


pos = ascii.read('fcc_part.dat')

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
plt.plot(pos['x'], pos['y'], pos['z'], 'bo')
plt.plot(pos['x'][0:4], pos['y'][0:4], pos['z'][0:4], 'r')
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_zlabel('z')
plt.show()

vel = ascii.read('vel_init.dat')
v2 = vel['vx']**2 + vel['vy']**2 + vel['vz']**2

plt.hist(v2)
plt.show()

energ = ascii.read('energies_temp.dat')
plt.plot(energ['step'], energ['e_k'])
plt.show()
