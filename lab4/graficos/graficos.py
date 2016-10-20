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
import seaborn as sns
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

sns.set_context("poster", font_scale=1.3)

os.chdir('/home/bruno/Documentos/Doctorado/Cursos/fisicaComp/lab4/graficos')

d = ascii.read('../L_40-T_1_01.dat', format='commented_header')
plt.plot(d['m'], '.')
plt.title('Magnetization vs time')
plt.ylabel('Magnetization')
plt.xlabel('Monte carlo step')
plt.savefig('m_vs_t.png')
plt.close()

plt.hist(d['m'])
plt.title('Magnetization histograma')
plt.xlabel('Magnetization')
plt.savefig('m_hist.png')
plt.close()

plt.plot(d['e'], '.')
plt.title('Energy vs time')
plt.xlabel('Monte carlo step')
plt.ylabel('Energy')
plt.savefig('e_vs_t.png')
plt.close()


crr = ascii.read('../autocorr.dat', format='commented_header')

plt.plot(crr['u_corr'], crr['corr_e']/crr['corr_e'][0], '.')
plt.title('Autocorrelacion de E')
plt.xlabel(r'$\tau$')
plt.savefig('e_corr.png')
plt.close()

plt.plot(crr['u_corr'], crr['corr_m']/crr['corr_m'][0], '.')
plt.title('Autocorrelacion de M')
plt.xlabel(r'$\tau$')
plt.savefig('m_corr.png')
plt.close()


os.chdir('..')
