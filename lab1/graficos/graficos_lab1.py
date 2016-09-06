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
import seaborn
import os

from astropy.io import ascii

os.chdir('/home/bruno/Documentos/Doctorado/Cursos/fisicaComp/lab1/graficos')

# =============================================================================
#  ejercicio 2
# =============================================================================
t = ascii.read('../2/salida_ej2.dat', format='commented_header')
plt.loglog(t['h'], t['er'], 'b')
plt.xlabel('h')
plt.ylabel('error')
plt.savefig('ej_2.eps')
plt.close()

# =============================================================================
# ejercicio 3
# =============================================================================
t = ascii.read('../3/salida_ej3_a.dat')
ts = ascii.read('../3/salida_ej3_b.dat')
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
plt.figure(figsize=(14, 6))
plt.subplot(121)
t = ascii.read('../5/ej5_a.dat')
plt.plot(t['x'], t['y'], label='Euler')
t = ascii.read('../5/ej5_b.dat')
plt.plot(t['x'], t['y'], 'g', label='RK 2')
t = ascii.read('../5/ej5_c.dat')
plt.plot(t['x'], t['y'], 'orange', label='RK 4')
plt.plot(t['x'], t['exacta'], 'r--',label='sol. exacta')
plt.legend(loc='best')
plt.xlabel(r'$x$')
plt.ylabel(r'$y$')

plt.subplot(122)
t = ascii.read('../5/ej5_a.dat')
plt.semilogy(t['x'], t['err'], label='Euler')
t = ascii.read('../5/ej5_b.dat')
plt.semilogy(t['x'], t['err'], 'g', label='RK 2')
t = ascii.read('../5/ej5_c.dat')
plt.semilogy(t['x'], t['err'], 'orange', label='RK 4')
plt.ylabel(r'$\epsilon$')
plt.xlabel(r'$x$')
plt.legend(loc='best')
plt.savefig('ej5.eps')
plt.close()


# =============================================================================
# ejercicio 6
# =============================================================================
plt.figure()
#~ plt.subplot(311)
#~ t = ascii.read('../6/ej6_a.dat')
#~ plt.plot(t['t'], t['x'], label='Euler')

#~ t = ascii.read('../6/ej6_b.dat')
#~ plt.plot(t['t'], t['x'], label='RK 2')

#~ t = ascii.read('../6/ej6_c.dat')
#~ plt.plot(t['t'], t['x'], label='RK 4')

#~ plt.plot(t['t'], t['exact'], 'k--',label='sol. exacta')

#~ plt.legend(loc='best')
#~ plt.xlabel(r'$t$')
#~ plt.ylabel(r'$x$')
#~ plt.title('Posicion')

#~ plt.subplot(312)

#~ t = ascii.read('../6/ej6_a.dat')
#~ plt.plot(t['t'], t['v'], label='velocidad')

#~ t = ascii.read('../6/ej6_b.dat')
#~ plt.plot(t['t'], t['v'], label='RK 2')

#~ t = ascii.read('../6/ej6_c.dat')
#~ plt.plot(t['t'], t['v'], label='RK 4')

#~ plt.plot(t['t'], t['vexact'], 'k--',label='sol. exacta')

#~ plt.legend(loc='best')
#~ plt.xlabel(r'$t$')
#~ plt.ylabel(r'$v$')

#~ plt.subplot(313)
t = ascii.read('../6/ej6_a.dat')
plt.semilogy(t['t'], t['err'], label='Euler')

t = ascii.read('../6/ej6_b.dat')
plt.semilogy(t['t'], t['err'], label='RK 2')

t = ascii.read('../6/ej6_c.dat')
plt.semilogy(t['t'], t['err'], label='RK 4')

plt.legend(loc='best')
plt.xlabel(r'$t$')
plt.ylabel(r'$\epsilon$')

plt.savefig('ej6.eps')
plt.close()


# =============================================================================
# FFT
# =============================================================================
t = ascii.read('../7/f_t_ej7.dat')
plt.plot(t['t'], t['f'], 'b')
plt.xlabel('t')
plt.ylabel(r'$f$')
plt.savefig('f_t_ej_7.eps')
plt.close()

t = ascii.read('../7/fft_ej7.dat')
plt.plot(t['freq'], t['real'], 'r.')
plt.plot(t['freq'], t['real'], 'b')
plt.xlabel(r'$\omega$')
plt.ylabel(r'$f$')
plt.savefig('fft_ej_7.eps')
plt.close()
