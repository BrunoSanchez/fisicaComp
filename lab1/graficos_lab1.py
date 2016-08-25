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

from astropy.io import ascii

t = ascii.read('salida_ej2.dat', format='commented_header')

plt.loglog(t['h'], t['er'], 'b')
plt.xlabel('h')
plt.ylabel('error')
plt.savefig('ej_2.ps')
plt.close()


t = ascii.read('f_t_ej7.dat')

plt.plot(t['t'], t['f'], 'b')
plt.xlabel('t')
plt.ylabel('f')
plt.savefig('f_t_ej_7.ps')
plt.close()

