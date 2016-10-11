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

os.chdir('/home/bruno/Documentos/Doctorado/Cursos/fisicaComp/lab3/graficos')

t = ascii.read('../ej2ab_ran2mod.dat', format='commented_header')
plt.plot(t['n'], t['rms'] + 200, 'r.-', label='ran2 + 200', lw=1, alpha=0.5)

t = ascii.read('../ej2ab_mzran.dat', format='commented_header')
plt.plot(t['n'], t['rms'] + 100, 'bo-', label='mzran + 100', lw=1, alpha=0.5)

t = ascii.read('../ej2ab_mstw.dat', format='commented_header')
plt.plot(t['n'], t['rms'], 'gv-', label='Mtwister', lw=1, alpha=0.5)

plt.legend(loc='best')
plt.xlabel(r'$n$')
plt.ylabel(r'$<(R(n) - R(0))^2>$')
plt.savefig('rms_vs_n.png')
plt.close()

t = ascii.read('../ej2ab_ran2mod.dat', format='commented_header')
plt.subplot(211)
plt.plot(t['n'], t['quad1'], '.-', label='Cuad. I', alpha=0.5)
plt.plot(t['n'], t['quad2'], '.-', label='Cuad. II', alpha=0.5)
plt.plot(t['n'], t['quad3'], '.-', label='Cuad. III', alpha=0.5)
plt.plot(t['n'], t['quad4'], '.-', label='Cuad. IV', alpha=0.5)
plt.axhline(y=250000, label=r'$N/4$', alpha=0.5, lw=1.2)
plt.legend(loc='best')
plt.ylabel(r'Conteo Cuadrantes')

plt.subplot(212)
plt.plot(t['n'], t['quad5'], '.-', label='Origen')

plt.xlabel(r'$n$')
plt.ylabel(r'Conteo Cuadrantes')
plt.semilogy()

plt.legend(loc='best')
plt.savefig('quads_vs_nranmod.png')
plt.close()

plt.hist(t['quad1'], alpha=0.5)
plt.hist(t['quad2'], alpha=0.5)
plt.hist(t['quad3'], alpha=0.5)
plt.hist(t['quad4'], alpha=0.5)
plt.hist(t['quad5'], alpha=0.5)
plt.xlabel(r'Conteo por cuadrante')
plt.savefig('quads_hist_ranmod.png')
plt.close()

t = ascii.read('../ej2ab_mzran.dat', format='commented_header')
plt.subplot(211)
plt.plot(t['n'], t['quad1'], '.-', label='Cuad. I', alpha=0.5)
plt.plot(t['n'], t['quad2'], '.-', label='Cuad. II', alpha=0.5)
plt.plot(t['n'], t['quad3'], '.-', label='Cuad. III', alpha=0.5)
plt.plot(t['n'], t['quad4'], '.-', label='Cuad. IV', alpha=0.5)
plt.axhline(y=250000, label=r'$N/4$', alpha=0.5, lw=1.2)
plt.legend(loc='best')
plt.ylabel(r'Conteo Cuadrantes')

plt.subplot(212)
plt.plot(t['n'], t['quad5'], '.-', label='Origen')

plt.xlabel(r'$n$')
plt.ylabel(r'Conteo Cuadrantes')
plt.semilogy()

plt.legend(loc='best')
plt.savefig('quads_vs_n_mzran.png')
plt.close()

plt.hist(t['quad1'], alpha=0.5)
plt.hist(t['quad2'], alpha=0.5)
plt.hist(t['quad3'], alpha=0.5)
plt.hist(t['quad4'], alpha=0.5)
plt.hist(t['quad5'], alpha=0.5)
plt.xlabel(r'Conteo por cuadrante')
plt.savefig('quads_hist_mzran.png')
plt.close()

t = ascii.read('../ej2ab_mstw.dat', format='commented_header')
plt.subplot(211)
plt.plot(t['n'], t['quad1'], '.-', label='Cuad. I', alpha=0.5)
plt.plot(t['n'], t['quad2'], '.-', label='Cuad. II', alpha=0.5)
plt.plot(t['n'], t['quad3'], '.-', label='Cuad. III', alpha=0.5)
plt.plot(t['n'], t['quad4'], '.-', label='Cuad. IV', alpha=0.5)
plt.axhline(y=250000, label=r'$N/4$', alpha=0.5, lw=1.2)
plt.legend(loc='best')
plt.ylabel(r'Conteo Cuadrantes')

plt.subplot(212)
plt.plot(t['n'], t['quad5'], '.-', label='Origen')

plt.xlabel(r'$n$')
plt.ylabel(r'Conteo Cuadrantes')
plt.semilogy()

plt.legend(loc='best')
plt.savefig('quads_vs_n_mstw.png')
plt.close()

plt.hist(t['quad1'], alpha=0.5)
plt.hist(t['quad2'], alpha=0.5)
plt.hist(t['quad3'], alpha=0.5)
plt.hist(t['quad4'], alpha=0.5)
plt.hist(t['quad5'], alpha=0.5)
plt.xlabel(r'Conteo por cuadrante')
plt.savefig('quads_hist_mstw.png')
plt.close()

# =============================================================================
#  ejercicio 3
# =============================================================================

t = ascii.read('../ej3a.dat', format='commented_header')
plt.loglog(t['n'], t['n']**(-0.5), label=r'$N^{-1/2}', lw=1.7)
plt.loglog(t['n'], t['err'], '.-',label=r'MC',
           markersize=8, lw=1.4, alpha=0.7)

t = ascii.read('../ej3b.dat', format='commented_header')
plt.loglog(t['n'], t['err2'], 'v-',label=r'IS, $k=2$',
           markersize=8, lw=1.4, alpha=0.7)
plt.loglog(t['n'], t['err3'], 'h-',label=r'IS, $k=3$', lw=0.4, alpha=0.7)

plt.legend(loc='best')
plt.ylabel(r'$log(|\epsilon|)$')
plt.xlabel(r'$N$')
plt.savefig('errorMC.png')
plt.close()
