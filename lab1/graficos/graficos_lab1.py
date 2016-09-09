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

os.chdir('/home/bruno/Documentos/Doctorado/Cursos/fisicaComp/lab1/graficos')

#~ # =============================================================================
#~ #  ejercicio 2
#~ # =============================================================================
#~ t = ascii.read('../2/salida_ej2.dat', format='commented_header')
#~ plt.loglog(t['h'], t['er'], 'b')
#~ plt.xlabel(r'$h$')
#~ plt.ylabel(r'$\epsilon$')
#~ plt.savefig('ej_2.png')
#~ plt.close()

#~ # =============================================================================
#~ # ejercicio 3
#~ # =============================================================================
#~ t = ascii.read('../3/salida_ej3_a.dat')
#~ ts = ascii.read('../3/salida_ej3_b.dat')
#~ plt.loglog(t['n'], t['err'], 'g',alpha=0.5, label='Trapecio')
#~ plt.loglog(t['n'], 1./(t['n']**2), 'g--', alpha=0.5, label=r'$\sim N^{-2}$')
#~ plt.loglog(ts['n'], ts['err'], 'b', alpha=0.5, label='Simpson')
#~ plt.loglog(t['n'], 1./(t['n']**4), 'b--', alpha=0.5, label=r'$\sim N^{-4}$')
#~ plt.legend(loc='best')
#~ plt.xlabel('N')
#~ plt.ylabel(r'$\epsilon$')
#~ plt.savefig('ej_3.png')
#~ plt.close()

#~ # =============================================================================
#~ # ejercicio 5
#~ # =============================================================================
#~ plt.figure(figsize=(14, 6))
#~ plt.subplot(121)
#~ t = ascii.read('../5/ej5_a.dat')
#~ plt.plot(t['x'], t['y'], label='Euler')
#~ t = ascii.read('../5/ej5_b.dat')
#~ plt.plot(t['x'], t['y'], 'g', label='RK 2')
#~ t = ascii.read('../5/ej5_c.dat')
#~ plt.plot(t['x'], t['y'], 'orange', label='RK 4')
#~ plt.plot(t['x'], t['exacta'], 'r--',label='sol. exacta')
#~ plt.legend(loc='best')
#~ plt.xlabel(r'$x$')
#~ plt.ylabel(r'$y$')

#~ plt.subplot(122)
#~ t = ascii.read('../5/ej5_a.dat')
#~ plt.semilogy(t['x'], t['err'], label='Euler')
#~ t = ascii.read('../5/ej5_b.dat')
#~ plt.semilogy(t['x'], t['err'], 'g', label='RK 2')
#~ t = ascii.read('../5/ej5_c.dat')
#~ plt.semilogy(t['x'], t['err'], 'orange', label='RK 4')
#~ plt.ylabel(r'$\epsilon$')
#~ plt.xlabel(r'$x$')
#~ plt.legend(loc='best')
#~ plt.savefig('ej5.png')
#~ plt.close()


#~ # =============================================================================
#~ # ejercicio 6
#~ # =============================================================================
#~ t = ascii.read('../6/ej6_a.dat')
#~ plt.semilogy(t['t'], t['err'], label='Euler')

#~ t = ascii.read('../6/ej6_b.dat')
#~ plt.semilogy(t['t'], t['err'], label='RK 2')

#~ t = ascii.read('../6/ej6_c.dat')
#~ plt.semilogy(t['t'], t['err'], label='RK 4')

#~ plt.legend(loc='best')
#~ plt.xlabel(r'$t$')
#~ plt.ylabel(r'$\epsilon$')

#~ plt.savefig('ej6.png')
#~ plt.close()


#~ # =============================================================================
#~ # FFT
#~ # =============================================================================
#~ t = ascii.read('../7/f_t_ej7.dat')
#~ plt.plot(t['t'], t['f'])
#~ plt.xlabel('t')
#~ plt.ylabel(r'$f$')
#~ plt.savefig('f_t_ej_7.png')
#~ plt.close()

#~ t = ascii.read('../7/fft_ej7.dat')
#~ plt.plot(t['freq'], t['real'])
#~ #plt.plot(t['freq'], t['real'], 'b')
#~ plt.xlabel(r'$f$')
#~ plt.ylabel(r'$\hat{f}$')
#~ plt.savefig('fft_ej_7.png')
#~ plt.close()

#~ # =============================================================================
#~ #  Ej 8 CAOS
#~ # =============================================================================
#~ t = ascii.read('../8/ej8a_r_1.50.dat')
#~ plt.plot(t['t'], t['xt_006'], 'b.-', label=r'$x_0 = 0.06$', lw=0.9)
#~ plt.plot(t['t'], t['xt_03'], 'r,-', label=r'$x_0 = 0.3$', lw=0.9)
#~ plt.plot(t['t'], t['xt_06'], 'gv-', label=r'$x_0 = 0.6$', lw=0.9)
#~ plt.plot(t['t'], t['xt_09'], 'y1-', label=r'$x_0 = 0.9$', lw=0.9)
#~ plt.xlim(0, 20)
#~ plt.legend(loc='best')
#~ plt.title(r'$r = 1.5$')
#~ plt.xlabel(r'$t$')
#~ plt.ylabel(r'$x_t$')
#~ plt.savefig('ej8a_r_1.50.png')
#~ plt.close()


#~ t = ascii.read('../8/ej8a_r_3.30.dat')
#~ plt.plot(t['t'], t['xt_006'], 'b.-', label=r'$x_0 = 0.06$', lw=0.9)
#~ plt.plot(t['t'], t['xt_03'], 'r,-', label=r'$x_0 = 0.3$', lw=0.9)
#~ plt.plot(t['t'], t['xt_06'], 'gv-', label=r'$x_0 = 0.6$', lw=0.9)
#~ plt.plot(t['t'], t['xt_09'], 'y1-', label=r'$x_0 = 0.9$', lw=0.9)
#~ plt.xlim(0, 30)
#~ plt.ylim(-0.1, 1.1)
#~ plt.legend(loc='best')
#~ plt.title(r'$r = 3.3$')
#~ plt.xlabel(r'$t$')
#~ plt.ylabel(r'$x_t$')
#~ plt.savefig('ej8a_r_3.30.png')
#~ plt.close()


#~ t = ascii.read('../8/ej8a_r_3.50.dat')
#~ plt.plot(t['t'], t['xt_006'], 'b.-', label=r'$x_0 = 0.06$', lw=0.9)
#~ plt.plot(t['t'], t['xt_03'], 'r,-', label=r'$x_0 = 0.3$', lw=0.9)
#~ plt.plot(t['t'], t['xt_06'], 'gv-', label=r'$x_0 = 0.6$', lw=0.9)
#~ plt.plot(t['t'], t['xt_09'], 'y1-', label=r'$x_0 = 0.9$', lw=0.9)
#~ plt.title(r'$r = 3.5$')
#~ plt.xlim(0, 20)
#~ plt.legend(loc='best')
#~ plt.ylim(-0.1, 1.1)
#~ plt.xlabel(r'$t$')
#~ plt.ylabel(r'$x_t$')
#~ plt.savefig('ej8a_r_3.50.png')
#~ plt.close()

#~ t = ascii.read('../8/ej8a_r_3.55.dat')
#~ plt.plot(t['t'], t['xt_006'], 'b.-', label=r'$x_0 = 0.06$', lw=0.9)
#~ plt.plot(t['t'], t['xt_03'], 'r,-', label=r'$x_0 = 0.3$', lw=0.9)
#~ plt.plot(t['t'], t['xt_06'], 'gv-', label=r'$x_0 = 0.6$', lw=0.9)
#~ plt.plot(t['t'], t['xt_09'], 'y1-', label=r'$x_0 = 0.9$', lw=0.9)
#~ plt.xlim(0, 20)
#~ plt.ylim(-0.1, 1.1)
#~ plt.legend(loc='best')
#~ plt.title(r'$r = 3.55$')
#~ plt.xlabel(r'$t$')
#~ plt.ylabel(r'$x_t$')
#~ plt.savefig('ej8a_r_3.55.png')
#~ plt.close()

#~ t = ascii.read('../8/ej8a_r_4.00.dat')
#~ plt.plot(t['t'], t['xt_006'], 'b.-', label=r'$x_0 = 0.06$', lw=0.9)
#~ plt.plot(t['t'], t['xt_03'], 'r,-', label=r'$x_0 = 0.3$', lw=0.9)
#~ plt.plot(t['t'], t['xt_06'], 'gv-', label=r'$x_0 = 0.6$', lw=0.9)
#~ plt.plot(t['t'], t['xt_09'], 'y1-', label=r'$x_0 = 0.9$', lw=0.9)
#~ plt.ylim(-0.5, 1.6)
#~ plt.legend(loc='best')
#~ plt.xlabel(r'$t$')
#~ plt.title(r'$r = 4.$')
#~ plt.xlim(0, 50)
#~ plt.ylabel(r'$x_t$')
#~ plt.savefig('ej8a_r_4.00.png')
#~ plt.close()



# power spectrum for several rfourierej8a_r_4.00.dat

#~ t = ascii.read('../8/fourierej8a_r_1.50.dat')
#~ peak = max(t['real'][101:-1]**2.)
#~ plt.plot(t['freq'], (t['real']**2.)/peak, '.-', label=r'$r=1.5$')

#~ t = ascii.read('../8/fourierej8a_r_3.30.dat')
#~ peak = max(t['real'][101:-1]**2.)
#~ plt.plot(t['freq'], (t['real']**2.)/peak, '.-', label=r'$r=3.3$')

#~ t = ascii.read('../8/fourierej8a_r_3.50.dat')
#~ peak = max(t['real'][101:-1]**2.)
#~ plt.plot(t['freq'], (t['real']**2.)/peak, '.-', label=r'$r=3.5$')

#~ t = ascii.read('../8/fourierej8a_r_3.55.dat')
#~ peak = max(t['real'][101:-1]**2.)
#~ plt.plot(t['freq'], (t['real']**2.)/peak, '.-', label=r'$r=3.55$')

#~ t = ascii.read('../8/fourierej8a_r_4.00.dat')
#~ peak = max(t['real'][101:-1]**2.)
#~ plt.plot(t['freq'], (t['real']**2.)/peak, '.-', label=r'$r=4.0$')

#~ plt.title(r'Espectro de potencia $P(f)$ normalizado')
#~ plt.xlabel(r'$f$')
#~ plt.ylabel(r'$P(f)$')
#~ plt.ylim(0, 1.2)
#~ plt.xlim(1, 99)
#~ plt.legend(loc='best')
#~ plt.savefig('ej8b.png')
#~ plt.close()


#~ t = ascii.read('../8/ej8c.dat')
#~ plt.hist(t['xt'][300:], normed=True, bins=16)
#~ plt.xlabel(r'$x$')
#~ plt.savefig('ej8c.png')
#~ plt.close()


t = ascii.read('../8/ej8d.dat', format='commented_header', guess=False,
               fast_reader={'parallel':True, 'use_fast_converter':True})
t600 = 600 > t['t']
t300 = t['t'] > 300
tb = t[t300 & t600]
plt.plot(tb['r'], tb['xt'], 'r.', ms=0.9)
plt.xlabel(r'$r$')
plt.ylabel(r'$x_t$')
plt.xlim(3.4, 4.)
plt.savefig('ej8d_1.png')
plt.close()

t = ascii.read('../8/ej8d_2.dat', format='commented_header', guess=False,
               fast_reader={'parallel':True, 'use_fast_converter':True})
plt.plot(t['r'], t['xt'], 'r.', ms=0.9)
plt.xlabel(r'$r$')
plt.ylabel(r'$x_t$')
plt.ylim(0.13, 0.185)
plt.xlim(3.847, 3.856)
plt.savefig('ej8d_2.png')
plt.close()


t = ascii.read('../8/ej8e.dat', format='commented_header', guess=False,
               fast_reader={'parallel':True, 'use_fast_converter':True})

plt.plot(t['r'], t['lam'], 'r.-', label=r'$\lambda$')
#s, ms=1.5)
plt.xlabel(r'$r$')
plt.legend(loc='best')
plt.ylabel(r'$\lambda$')
plt.savefig('ej8e.png')
plt.close()



#~ # =============================================================================
#~ # Ej 9
#~ # =============================================================================
#~ sns.set_context('talk')
#~ t5 = ascii.read('../9/ej9a_e5.dat', guess=False, format='commented_header',
                #~ fast_reader={'parallel':True, 'use_fast_converter':True})
#~ t20 = ascii.read('../9/ej9a_e20.dat', guess=False, format='commented_header',
                #~ fast_reader={'parallel':True, 'use_fast_converter':True})
#~ t100 = ascii.read('../9/ej9a_e100.dat', guess=False, format='commented_header',
                #~ fast_reader={'parallel':True, 'use_fast_converter':True})
#~ plt.figure(figsize=(12, 8))
#~ plt.subplot(221)
#~ plt.plot(t5['t'], t5['q1'], '.-', label=r'$E=5$', ms=2, lw=0.5)
#~ plt.plot(t20['t'], 10.+ t20['q1'], '.-', label=r'$E=20$', ms=2, lw=0.5)
#~ plt.plot(t100['t'], 50. + t100['q1'], '.-', label=r'$E=100$', ms=2, lw=0.5)
#~ plt.xlabel(r'$t$')
#~ plt.ylabel(r'$q_1$')
#~ plt.legend(loc='best')

#~ plt.subplot(222)
#~ plt.plot(t5['t'], t5['q2'], '.-', label=r'$E=5$', lw=0.5, ms=2.)
#~ plt.plot(t20['t'], 15.+ t20['q2'], '.-', label=r'$E=20$', lw=0.5, ms=2.)
#~ plt.plot(t100['t'], 60. + t100['q2'], '.-', label=r'$E=100$', lw=0.5, ms=2.)
#~ plt.xlabel(r'$t$')
#~ plt.ylabel(r'$q_2$')
#~ plt.legend(loc='best')

#~ plt.subplot(223)
#~ plt.plot(t5['t'], t5['p1'], '.-', label=r'$E=5$', lw=0.5, ms=2)
#~ plt.plot(t20['t'], 15.+ t20['p1'], '.-', label=r'$E=20$', lw=0.5, ms=2)
#~ plt.plot(t100['t'], 60. + t100['p1'], '.-', label=r'$E=100$', lw=0.5, ms=2)
#~ plt.xlabel(r'$t$')
#~ plt.ylabel(r'$p_1$')
#~ plt.legend(loc='best')

#~ plt.subplot(224)
#~ plt.plot(t5['t'], t5['p2'], '.-', label=r'$E=5$', lw=0.5, ms=2)
#~ plt.plot(t20['t'], 15.+ t20['p2'], '.-', label=r'$E=20$', lw=0.5, ms=2)
#~ plt.plot(t100['t'], 60. + t100['p2'], '.-', label=r'$E=100$', lw=0.5, ms=2)
#~ plt.xlabel(r'$t$')
#~ plt.ylabel(r'$p_2$')
#~ plt.legend(loc='best')
#~ plt.savefig('ej9a_pq.png')
#~ plt.close()

#~ plt.plot(t5['t'], t5['e'], '.-', label=r'$E=5$', lw=0.5, ms=2)
#~ plt.plot(t20['t'], t20['e'], '.-', label=r'$E=20$', lw=0.5, ms=2)
#~ plt.plot(t100['t'], t100['e'], '.-', label=r'$E=100$', lw=0.5, ms=2)
#~ plt.ylabel(r'E')
#~ plt.legend(loc='best')
#~ plt.xlabel(r'$t$')
#~ plt.savefig('ej9a_e.png')
#~ plt.close()

#~ t5 = ascii.read('../9/ej9b_e5.dat', guess=False, format='commented_header',
                #~ fast_reader={'parallel':True, 'use_fast_converter':True})
#~ plt.figure(figsize=(10,10))
#~ plt.plot(t5['q1'], t5['p1'], '.', ms=0.8)
#~ plt.xlabel(r'$q_1$')
#~ plt.ylabel(r'$p_1$')
#~ plt.title(r'Diagrama de Poincare con $E=5$')
#~ plt.axes().set_aspect('equal', 'datalim')
#~ plt.savefig('ej9b_e5.png')
#~ plt.close()

#~ t20 = ascii.read('../9/ej9b_e20.dat', guess=False, format='commented_header',
                #~ fast_reader={'parallel':True, 'use_fast_converter':True})
#~ plt.figure(figsize=(10,10))
#~ plt.plot(t20['q1'], t20['p1'], '.', ms=0.8)
#~ plt.xlabel(r'$q_1$')
#~ plt.ylabel(r'$p_1$')
#~ plt.title(r'Diagrama de Poincare con $E=20$')
#~ plt.axes().set_aspect('equal', 'datalim')
#~ plt.savefig('ej9b_e20.png')
#~ plt.close()

#~ t100 = ascii.read('../9/ej9b_e100.dat', guess=False, format='commented_header',
                #~ fast_reader={'parallel':True, 'use_fast_converter':True})
#~ plt.figure(figsize=(10,10))
#~ plt.plot(t100['q1'], t100['p1'], '.', ms=0.8)
#~ plt.xlabel(r'$q_1$')
#~ plt.ylabel(r'$p_1$')
#~ plt.title(r'Diagrama de Poincare con $E=100$')
#~ plt.axes().set_aspect('equal', 'datalim')
#~ plt.savefig('ej9b_e100.png')
#~ plt.close()


os.chdir('/home/bruno/Documentos/Doctorado/Cursos/fisicaComp/lab1')
