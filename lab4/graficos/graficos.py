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

os.chdir('/home/bruno/Documents/Doctorado/Cursos/fisicaComp/lab4/graficos')

ascii.read('../L_40-T_1_01.dat', format='commented_header')

