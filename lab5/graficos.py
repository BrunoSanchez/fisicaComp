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
import numpy as np
from astropy.io import ascii
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
#import seaborn

pos = ascii.read('fcc_part.dat')

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
plt.plot(pos['x'], pos['y'], pos['z'], 'bo')
plt.plot(pos['x'][0:4], pos['y'][0:4], pos['z'][0:4], 'r')
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_zlabel('z')
plt.savefig('fcc_init.png')
plt.close()


vel = ascii.read('vel_init.dat')
v2 = vel['vx']**2 + vel['vy']**2 + vel['vz']**2

plt.hist(v2, normed=True)
plt.xlabel(r'$v^2$')
plt.savefig('init_velocities.png')
plt.close()


energ = ascii.read('energies_temp.dat')

et_mean = np.mean(energ['etot'])
et_std  = np.std(energ['etot'])
ek_mean = np.mean(energ['ek'])
ek_std  = np.std(energ['ek'])
eu_mean = np.mean(energ['eu'])
eu_std  = np.std(energ['eu'])
pt_mean = np.mean(energ['P'])
pt_std  = np.std(energ['P'])
temp_mean = np.mean(energ['temp'])
temp_std  = np.std(energ['temp'])
t_min = np.min(energ['step'])
t_max = np.max(energ['step'])


plt.plot(energ['step'], energ['ek'], label=r'$E_k$')
plt.plot(energ['step'], energ['eu'], label=r'$E_{u}$')
plt.plot(energ['step'], energ['etot'], label=r'$E_{tot}$')
plt.legend(loc='best')
plt.savefig('energies.png')
plt.close()


plt.figure(figsize=(12, 4))
plt.subplot(131)
plt.hist(energ['ek'], normed=True, alpha=0.8)
plt.vlines([ek_mean, ek_mean+ek_std, ek_mean-ek_std], 0, 0.03)
plt.xlabel(r'$E_k$')
plt.ylim(0,0.03)
plt.subplot(132)
plt.hist(energ['eu'], normed=True, alpha=0.8)
plt.vlines([eu_mean, eu_mean+eu_std, eu_mean-eu_std], 0, 0.03)
plt.xlabel(r'$E_u$')
plt.ylim(0,0.03)
plt.subplot(133)
plt.hist(energ['etot'], normed=True, alpha=0.8)
plt.vlines([et_mean, et_mean+et_std, et_mean-et_std], 0, 7)
plt.xlabel(r'$E_{tot}$')
plt.tight_layout()
plt.savefig('energydistribution.png')
plt.close()


plt.plot(energ['step'], energ['temp'], label=r'$T$')
plt.legend(loc='best')
plt.savefig('temperature.png')
plt.close()


plt.plot(energ['step'], energ['P'], label=r'$P(t)$')
plt.xlabel(r'$t$')
plt.ylabel(r'$P$')
plt.legend(loc='best')
plt.savefig('presion.png')
plt.close()


hist_vel = ascii.read('histogram_v.dat')
delt = hist_vel['bin'][1]-hist_vel['bin'][0]
plt.bar(hist_vel['bin'], hist_vel['countsvx']/2560000.,
        align='center', alpha=0.5, width=delt)

plt.bar(hist_vel['bin'], hist_vel['countsvy']/2560000.,
        align='center', alpha=0.5, width=delt, color='green')

plt.bar(hist_vel['bin'], hist_vel['countsvz']/2560000.,
        align='center', alpha=0.5, width=delt, color='red')

plt.show()
plt.close()
