#!/usr/bin/env python3
# Rafael Corsi @ insper.edu.br
# /2018
# Disciplina Elementos de Sistemas
#
# Abril/2018
from os.path import join, dirname
import sys
import os
import shutil
import subprocess
import argparse
import time

# Scripts python
ROOT_PATH = subprocess.Popen(['git', 'rev-parse', '--show-toplevel'], stdout=subprocess.PIPE).communicate()[0].rstrip().decode('utf-8')
PROJ_PATH = os.path.join(ROOT_PATH, 'Projetos', 'src')
TOOLS_PATH = os.path.join(ROOT_PATH, 'Projetos', 'Z01-tools')
TOOLS_SCRIPT_PATH = os.path.join(TOOLS_PATH, 'scripts')

sys.path.insert(0,TOOLS_SCRIPT_PATH)

from writeSOF import writeSOF

PATH_CDF = os.path.join(TOOLS_SCRIPT_PATH, '..', 'sof', 'DE0_CV_Default.cdf')

def programSOF():

    # primeiro reinicia o driver do jtagd
    # no linux
    if(os.name == 'posix'):
        os.system("killall jtagd")
        time.sleep(1)
        os.system("jtagconfig")

    writeSOF(PATH_CDF)

if __name__ == "__main__":
    programSOF()
