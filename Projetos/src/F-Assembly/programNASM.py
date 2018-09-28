#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rafael Corsi @ insper.edu.br
# Abril/2018
# Disciplina Elementos de Sistemas
#
# Script para compilar e gravar um programa
# na FPGA.

import os
import sys
import argparse
import subprocess

# Scripts python
ROOT_PATH = subprocess.Popen(['git', 'rev-parse', '--show-toplevel'], stdout=subprocess.PIPE).communicate()[0].rstrip().decode('utf-8')
PROJ_PATH = os.path.join(ROOT_PATH, 'Projetos', 'src')
TOOLS_PATH = os.path.join(ROOT_PATH, 'Projetos', 'Z01-tools')
TOOLS_SCRIPT_PATH = os.path.join(TOOLS_PATH, 'scripts')

sys.path.insert(0,TOOLS_SCRIPT_PATH)

from assembler import assembler
from writeROM import writeROM

jar = os.path.join(TOOLS_SCRIPT_PATH, '..', 'jar', 'Z01-Assembler.jar')

def program(nasm):

    pwd = os.path.dirname(os.path.abspath(__file__))
    hack = pwd+"/../bin/hack/"+os.path.splitext(os.path.basename(nasm))[0]

    # global path
    nasm = os.path.abspath(nasm)
    hack = os.path.abspath(hack)

    # assembler
    assembler(jar, nasm, hack, True)

    # program ROM
    writeROM(hack+".mif")

if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("-i", "--nasm", required=True, help="arquivo nasm")
    args = vars(ap.parse_args())
    program(nasm=args["nasm"])
