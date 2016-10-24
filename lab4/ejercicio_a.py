#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  ejercicio_a.py
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
import shutil
import shlex
import subprocess
import os
import numpy as np


# =============================================================================
# Ejercicio 1
# =============================================================================

# =============================================================================
# Apartado a
# =============================================================================

 # Es necesario simular redes de 10x10, 20x20, y 40x40,
 # y calcular las correlacionesde la energia y la magnetizacion.
bornpath = os.path.abspath('.')
if not os.path.exists('./ej1a'):
    os.makedirs('ej1a')

os.chdir('ej1a')
cmd = '../ej1a.out 1.01 10 "L_10_T_101.dat" "corr_L_10_T_101.dat" &'
cmd = shlex.split(cmd)
print cmd
subprocess.call(cmd)


cmd = '../ej1a.out 1.01 20 "L_20_T_101.dat" "corr_L_20_T_101.dat"'
cmd = shlex.split(cmd)
print cmd
subprocess.call(cmd)

cmd = '../ej1a.out 1.01 40 "L_40_T_101.dat" "corr_L_40_T_101.dat"'
cmd = shlex.split(cmd)
print cmd
subprocess.call(cmd)

# =============================================================================
# Apartado b
# =============================================================================
#~ if not os.path.exists('../ej1b'):
    #~ os.makedirs('../ej1b')

#~ os.chdir('../ej1b')
#~ temperatures = np.arange(0.01, 1.3, 0.01)
#~ L = [10, 20, 40]
#~ for anl in L:
    #~ outfile = " L_{}_T_{}.dat".format(anl, 0.001)
    #~ outcorr = " corr_L_{}_T_{}.dat ".format(anl, 0.001)
    #~ spinfile = "spinfile_L_{}.dat".format(anl)
    #~ spinpart = "False "+spinfile
    #~ cmd = "../ej1b.out {} {} ".format(0.01, anl) + outfile + outcorr + spinpart
    #~ print cmd
    #~ cmd = shlex.split(cmd)
    #~ subprocess.call(cmd)
    #~ print """#########################################
    #~ #########################################\n \n"""
    #~ for t in temperatures:
        #~ outfile = " L_{}_T_{}.dat".format(anl, t)
        #~ outcorr = " corr_L_{}_T_{}.dat ".format(anl, t)
        #~ spinpart = "True " + spinfile
        #~ cmd = "../ej1b.out {} {} ".format(t, anl) + outfile + outcorr + spinpart
        #~ cmd = shlex.split(cmd)
        #~ subprocess.call(cmd)
        #~ print """#########################################
#~ #########################################\n\n"""

# =============================================================================
# Apartado b BIS
# =============================================================================




os.chdir(bornpath)






