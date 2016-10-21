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

import matplotlib.pyplot as plt
import numpy as np
#import seaborn as sns
import os

from astropy.io import ascii

font = {'family'        : 'sans-serif',
        'sans-serif'    : ['Computer Modern Sans serif'],
        'weight'        : 'regular',
        'size'          : 16}

text = {'usetex'        : True,
        'fontsize'      : 16}

plt.rc('font', **font)
plt.rc('text', **text)

#sns.set_context("poster", font_scale=1.3)

os.chdir('/home/bruno/Documents/Doctorado/Cursos/fisicaComp/lab4/graficos')

crr10 = ascii.read('../ej1a/corr_L_10_T_101.dat', format='commented_header')
crr20 = ascii.read('../ej1a/corr_L_20_T_101.dat', format='commented_header')
crr40 = ascii.read('../ej1a/corr_L_40_T_101.dat', format='commented_header')
d10 = ascii.read('../ej1a/L_10_T_101.dat', format='commented_header')
d20 = ascii.read('../ej1a/L_20_T_101.dat', format='commented_header')
d40 = ascii.read('../ej1a/L_40_T_101.dat', format='commented_header')

###############################################################################
plt.figure(figsize=(10,8))
plt.subplot(311)
plt.plot(d10['m'][-500:], '.-', label=r'$10\times10$')
#~ plt.plot(d10['m'][-500:], '.')
plt.title('Magnetization vs Pasos')
plt.ylabel('Magnetization')
plt.legend(loc='lower left')

plt.subplot(312)
plt.plot(d20['m'][-500:], '.-', label=r'$20\times20$')
#~ plt.plot(d20['m'][-500:], '.')
plt.ylabel('Magnetization')
plt.legend(loc='lower left')

plt.subplot(313)
plt.plot(d40['m'][-500:], '.-', label=r'$40\times40$')
#~ plt.plot(d40['m'][-500:], '.')
plt.ylabel('Magnetization')
plt.xlabel('Monte carlo step')
plt.legend(loc='lower left')
plt.tight_layout()
plt.savefig('m_vs_t.png')
plt.close()

###############################################################################

plt.hist(d10['m'], label=r'$10\times10$', alpha=0.6, bins=np.arange(-11,11,2)/10.)
plt.hist(d20['m'], label=r'$20\times20$', alpha=0.6, bins=np.arange(-11,11,2)/10.)
plt.hist(d40['m'], label=r'$20\times40$', alpha=0.6, bins=np.arange(-11,11,2)/10.)
plt.title('Magnetization histograma')
plt.xlabel('Magnetization')
plt.legend(loc='best')
plt.xlim(-1.11, 1.11)
plt.savefig('m_hist.png')
plt.close()

###############################################################################

plt.plot(d10['e'], '.', label=r'$10\times10$')
plt.plot(d20['e']+3, '.', label=r'$20\times20$ (+3)')
plt.plot(d40['e']+6, '.', label=r'$40\times40$ (+6)')
plt.title('Energy vs time')
plt.xlabel('Monte carlo step')
plt.ylabel('Energy')
plt.ylim(-5.,7)
plt.legend(loc='best')
plt.savefig('e_vs_t.png')
plt.close()

###############################################################################
mean_energy10 = np.mean(d10['e'])
corr_energy10 = (crr10['corr_e']-mean_energy10**2)/ \
                (crr10['corr_e'][0]-mean_energy10**2)

mean_energy20 = np.mean(d20['e'])
corr_energy20 = (crr20['corr_e']-mean_energy20**2)/\
                (crr20['corr_e'][0]-mean_energy20**2)

mean_energy40 = np.mean(d40['e'])
corr_energy40 = (crr40['corr_e']-mean_energy40**2)/\
                (crr40['corr_e'][0]-mean_energy40**2)

plt.plot(crr10['u_corr'], corr_energy10, '.', label=r'$10\times10$' )
plt.plot(crr20['u_corr'], corr_energy20, '.', label=r'$20\times20$' )
plt.plot(crr40['u_corr'], corr_energy40, '.', label=r'$40\times40$' )
plt.title('Autocorrelacion de E')
plt.xlabel(r'$\tau$')
plt.legend(loc='best')
plt.savefig('e_corr.png')
plt.close()

###############################################################################
mean_mag10 = np.mean(d10['m'])
corr_mag10 = (crr10['corr_m']-mean_mag10**2)/ \
             (crr10['corr_m'][0]-mean_mag10**2)
mean_mag20 = np.mean(d20['m'])
corr_mag20 = (crr20['corr_m']-mean_mag20**2)/\
             (crr20['corr_m'][0]-mean_mag20**2)
mean_mag40 = np.mean(d40['m'])
corr_mag40 = (crr40['corr_m']-mean_mag40**2)/\
             (crr40['corr_m'][0]-mean_mag40**2)

plt.plot(crr10['u_corr'], corr_mag10, '.', label=r'$10\times10$' )
plt.plot(crr20['u_corr'], corr_mag20, '.', label=r'$20\times20$' )
plt.plot(crr40['u_corr'], corr_mag40, '.', label=r'$40\times40$' )
plt.title('Autocorrelacion de M')
plt.legend(loc='best')
plt.xlabel(r'$\tau$')
plt.savefig('m_corr.png')
plt.close()

###############################################################################

# =============================================================================
# Apartado b
# =============================================================================
temperatures = np.arange(0.1, 1.3, 0.01)
L = 40
outfile = "../ej1b/L_{}_T_{}.dat".format(L, 0.001)
outcorr = "../ej1b/corr_L_{}_T_{}.dat".format(L, 0.001)

d = ascii.read(outfile, format='commented_header')
c = ascii.read(outcorr, format='commented_header')


t_axis = []
m_mean = []
m2_mean= []
e_mean = []
e2_mean= []

m_std = []
m2_std = []
e_std  = []
e2_std = []
xhi = []
cv = []

#~ t_axis.append(0.001)
#~ m_mean.append(np.mean(d['m']))
#~ m2_mean.append(np.mean(d['m2']))

#~ e_mean.append(np.mean(d['e']))
#~ e2_mean.append(np.mean(d['e2']))

#~ m_std.append(np.std(d['m']))
#~ m2_std.append(np.std(d['m2']))

#~ e_std.append(np.std(d['e']))
#~ e2_std.append(np.std(d['e2']))

for t in temperatures:
    outfile = "../ej1b/L_{}_T_{}.dat".format(L, t)
    outcorr = "../ej1b/corr_L_{}_T_{}.dat".format(L, t)

    d = ascii.read(outfile, format='commented_header')
    c = ascii.read(outcorr, format='commented_header')

    t_axis.append(t)
    m_mean.append(np.mean(d['m']))
    m2_mean.append(np.mean(d['m2']))

    e_mean.append(np.mean(d['e']))
    e2_mean.append(np.mean(d['e2']))

    m_std.append(np.std(d['m']))
    m2_std.append(np.std(d['m2']))

    e_std.append(np.std(d['e']))
    e2_std.append(np.std(d['e2']))
    xhi.append(L*L*(np.mean(d['m'])**2 - np.mean(d['m2']))/(2.2692*t))
    cv.append(L*L*(np.mean(d['e'])**2 - np.mean(d['e2']))/(2.2692*t*t))

t_axis = np.array(t_axis)
m_mean = np.array(m_mean)
m2_mean= np.array(m2_mean)
e_mean = np.array(e_mean)
e2_mean= np.array(e2_mean)

m_std = np.array(m_std)
m2_std = np.array(m2_std)
e_std  = np.array(e_std)
e2_std = np.array(e2_std)

plt.plot(t_axis, xhi)
plt.plot(t_axis, cv)

plt.show()



os.chdir('..')
