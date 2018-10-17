# Rafael Corsi @ insper.edu.br
# /2018
# Disciplina Elementos de Sistemas
#
# Abril/2018

import os
import time
import sys

PATH_TOOLS_SCRIPT = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'tools', 'scripts')
sys.path.insert(0,PATH_TOOLS_SCRIPT)
from writeSOF import writeSOF

def generateMySOF():
    pwd = os.path.dirname(os.path.abspath(__file__))

    # change to quartus dir
    os.chdir(pwd+'/Quartus')


if __name__ == "__main__":
    generateMySOF()
