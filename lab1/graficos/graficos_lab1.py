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

font = {'family'        : 'sans-serif',
        'sans-serif'    : ['Computer Modern Sans serif'],
        'weight'        : 'regular',
        'size'          : 16}

text = {'usetex'        : True}

plt.rc('font', **font)
plt.rc('text', **text)

os.chdir('/home/bruno/Documentos/Doctorado/Cursos/fisicaComp/lab1/graficos')

# =============================================================================
#  ejercicio 2
# =============================================================================
t = ascii.read('../2/salida_ej2.dat', format='commented_header')
plt.loglog(t['h'], t['er'], 'b')
plt.xlabel('h')
plt.ylabel('error')
plt.savefig('ej_2.png')
plt.close()

# =============================================================================
# ejercicio 3
# =============================================================================
t = ascii.read('../3/salida_ej3_a.dat')
ts = ascii.read('../3/salida_ej3_b.dat')
plt.loglog(t['n'], t['err'], 'g',alpha=0.5, label='Trapecio')
plt.loglog(t['n'], 1./(t['n']**2), 'g--', alpha=0.5, label=r'$\sim N^{-2}$')
plt.loglog(ts['n'], ts['err'], 'b', alpha=0.5, label='Simpson')
plt.loglog(t['n'], 1./(t['n']**4), 'b--', alpha=0.5, label=r'$\sim N^{-4}$')
plt.legend(loc='best')
plt.xlabel('N')
plt.ylabel(r'$\epsilon$')
plt.savefig('ej_3.png')
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
plt.savefig('ej5.png')
plt.close()


# =============================================================================
# ejercicio 6
# =============================================================================
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

plt.savefig('ej6.png')
plt.close()


# =============================================================================
# FFT
# =============================================================================
t = ascii.read('../7/f_t_ej7.dat')
plt.plot(t['t'], t['f'])
plt.xlabel('t')
plt.ylabel(r'$f$')
plt.savefig('f_t_ej_7.png')
plt.close()

t = ascii.read('../7/fft_ej7.dat')
plt.plot(t['freq'], t['real'])
#plt.plot(t['freq'], t['real'], 'b')
plt.xlabel(r'$f$')
plt.ylabel(r'$\hat{f}$')
plt.savefig('fft_ej_7.png')
plt.close()

# =============================================================================
#  Ej 8 CAOS
# =============================================================================
t = ascii.read('../8/ej8a_r_1.50.dat')
plt.plot(t['t'], t['xt_006'])
plt.plot(t['t'], t['xt_03'])
plt.plot(t['t'], t['xt_06'])
plt.plot(t['t'], t['xt_09'])
plt.xlim(0, 20)
plt.xlabel(r'$t$')
plt.ylabel(r'$x_t$')
plt.savefig('ej8a_r_1.50.png')
plt.close()


t = ascii.read('../8/ej8a_r_3.30.dat')
plt.plot(t['t'], t['xt_006'])
plt.plot(t['t'], t['xt_03'])
plt.plot(t['t'], t['xt_06'])
plt.plot(t['t'], t['xt_09'])
plt.xlim(0, 30)
plt.xlabel(r'$t$')
plt.ylabel(r'$x_t$')
plt.savefig('ej8a_r_3.30.png')
plt.close()


t = ascii.read('../8/ej8a_r_3.50.dat')
plt.plot(t['t'], t['xt_006'])
plt.plot(t['t'], t['xt_03'])
plt.plot(t['t'], t['xt_06'])
plt.plot(t['t'], t['xt_09'])
plt.xlim(0, 20)
plt.xlabel(r'$t$')
plt.ylabel(r'$x_t$')
plt.savefig('ej8a_r_3.50.png')
plt.close()

t = ascii.read('../8/ej8a_r_3.55.dat')
plt.plot(t['t'], t['xt_006'])
plt.plot(t['t'], t['xt_03'])
plt.plot(t['t'], t['xt_06'])
plt.plot(t['t'], t['xt_09'])
plt.xlim(0, 20)
plt.xlabel(r'$t$')
plt.ylabel(r'$x_t$')
plt.savefig('ej8a_r_3.55.png')
plt.close()

t = ascii.read('../8/ej8a_r_4.00.dat')
plt.plot(t['t'], t['xt_006'])
plt.plot(t['t'], t['xt_03'])
plt.plot(t['t'], t['xt_06'])
plt.plot(t['t'], t['xt_09'])
plt.xlabel(r'$t$')
plt.xlim(0, 50)
plt.ylabel(r'$x_t$')
plt.savefig('ej8a_r_4.00.png')
plt.close()

plt.hist(t['xt_06'])


# power spectrum for several rfourierej8a_r_4.00.dat

t = ascii.read('../8/fourierej8a_r_1.50.dat')
plt.plot(t['freq'], t['real']**2., label=r'$r=1.5$')

t = ascii.read('../8/fourierej8a_r_3.30.dat')
plt.plot(t['freq'], t['real']**2., label=r'$r=3.3$')

t = ascii.read('../8/fourierej8a_r_3.50.dat')
plt.plot(t['freq'], t['real']**2., label=r'$r=3.5$')

t = ascii.read('../8/fourierej8a_r_3.55.dat')
plt.plot(t['freq'], t['real']**2., label=r'$r=3.55$')

t = ascii.read('../8/fourierej8a_r_4.00.dat')
plt.plot(t['freq'], t['real']**2., label=r'$r=4.0$')

plt.xlabel(r'$f$')
plt.ylabel(r'$P(f)^2$')
plt.ylim(0, 0.002)
plt.xlim(1, 99)
plt.legend(loc='best')
plt.savefig('ej8b.png')
plt.close()


t = ascii.read('../8/ej8c.dat')
plt.hist(t['xt'][300:], normed=True, bins=16)
plt.xlabel(r'$x$')
plt.savefig('ej8c.png')
plt.close()


t = ascii.read('../8/ej8d.dat')
t600 = 600 > t['t']
t300 = t['t'] > 300
tb = t[t300 & t600]
ra_lo = 3.847 < t['r']
ra_hi = t['r'] < 3.857
xa_lo = 0.13 < t['xt']
xa_hi = t['xt'] < 0.185
ta = t[t300]#ra_lo & ra_hi & xa_lo & xa_hi & t300]

plt.plot(tb['r'], tb['xt'], 'r.')
plt.xlabel(r'$r$')
plt.ylabel(r'$x_t$')
plt.xlim(3.4, 4.)
plt.savefig('ej8d_1.png')
plt.close()

plt.plot(ta['r'], ta['xt'], 'r.')
plt.xlabel(r'$r$')
plt.ylabel(r'$x_t$')
plt.ylim(0.13, 0.185)
plt.xlim(3.847, 3.857)
plt.savefig('ej8d_2.png')
plt.close()


os.chdir('/home/bruno/Documentos/Doctorado/Cursos/fisicaComp/lab1')
