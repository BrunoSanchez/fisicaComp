#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  graficos_lab1.py
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
#import seaborn

from astropy.io import ascii

# =============================================================================
#  ejercicio 2
# =============================================================================
t = ascii.read('salida_ej2.dat', format='commented_header')
plt.loglog(t['h'], t['er'], 'b')
plt.xlabel('h')
plt.ylabel('error')
plt.savefig('ej_2.ps')
plt.close()

# =============================================================================
# ejercicio 3
# =============================================================================
t = ascii.read('salida_ej3_a.dat')
ts = ascii.read('salida_ej3_b.dat')
plt.loglog(t['n'], t['err'], 'g',alpha=0.5, label='trapecio')
plt.loglog(t['n'], 1./(t['n']**2), 'g--', alpha=0.5, label=r'$\sim N^{-2}$')
plt.loglog(ts['n'], ts['err'], 'b', alpha=0.5, label='simpson')
plt.loglog(t['n'], 1./(t['n']**4), 'b--', alpha=0.5, label=r'$\sim N^{-4}$')
plt.legend(loc='best')
plt.xlabel('N')
plt.ylabel(r'$\epsilon$')
plt.savefig('ej_3.eps')
plt.close()

# =============================================================================
# ejercicio 5
# =============================================================================
t = ascii.read('ej5_a.dat')
plt.plot(t['x'], t['y'], label='posicion')
plt.plot(t['x'], t['exacta'], 'r--',label='sol. exacta')
plt.legend(loc='best')
plt.xlabel(r'$x$')
plt.ylabel(r'$y$')
plt.savefig('ej5_a.eps')
plt.close()

t = ascii.read('ej5_b.dat')
plt.plot(t['x'], t['y'], label='posicion')
plt.plot(t['x'], t['exacta'], 'r--',label='sol. exacta')
plt.legend(loc='best')
plt.xlabel(r'$x$')
plt.ylabel(r'$y$')
plt.savefig('ej5_b.eps')
plt.close()

t = ascii.read('ej5_c.dat')
plt.plot(t['x'], t['y'], label='posicion')
plt.plot(t['x'], t['exacta'], 'r--',label='sol. exacta')
plt.legend(loc='best')
plt.xlabel(r'$x$')
plt.ylabel(r'$y$')
plt.savefig('ej5_c.eps')
plt.close()


# =============================================================================
# ejercicio 6
# =============================================================================
t = ascii.read('ej6_a.dat')
plt.plot(t['t'], t['x'], label='posicion')
plt.plot(t['t'], t['v'], label='velocidad')
plt.plot(t['t'], np.sin(t['t']) + np.cos(t['t']), 'r--',label='sol. exacta')
plt.legend(loc='best')
plt.xlabel(r'$t$')
plt.ylabel(r'$x$')
plt.savefig('ej6_a.eps')
plt.close()

t = ascii.read('ej6_b.dat')
plt.plot(t['t'], t['x'], label='posicion')
plt.plot(t['t'], np.sin(t['t']) + np.cos(t['t']), 'r--',label='sol. exacta')
plt.plot(t['t'], t['v'], label='velocidad')
plt.legend(loc='best')
plt.xlabel(r'$t$')
plt.ylabel(r'$x$')
plt.savefig('ej6_b.eps')
plt.close()

t = ascii.read('ej6_c.dat')
plt.plot(t['t'], t['x'], label='posicion')
plt.plot(t['t'], np.sin(t['t']) + np.cos(t['t']), 'r--',label='sol. exacta')
plt.plot(t['t'], t['v'], label='velocidad')
plt.legend(loc='best')
plt.xlabel(r'$t$')
plt.ylabel(r'$x$')
plt.savefig('ej6_c.eps')
plt.close()


# =============================================================================
# FFT
# =============================================================================
t = ascii.read('f_t_ej7.dat')
plt.plot(t['t'], t['f'], 'b')
plt.xlabel('t')
plt.ylabel('f')
plt.savefig('f_t_ej_7.ps')
plt.close()

t = ascii.read('fft_ej7.dat')
