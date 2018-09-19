#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rafael Corsi @ insper.edu.br
# Dez/2017
# Disciplina Elementos de Sistemas
#
# script para gerar hack a partir de nasm
# suporta como entrada um único arquivo
# ou um diretório
# Possibilita também a geração do .mif

from os.path import join, dirname
import sys
import os
import shutil
import subprocess

# Scripts python
ROOT_PATH = subprocess.Popen(['git', 'rev-parse', '--show-toplevel'], stdout=subprocess.PIPE).communicate()[0].rstrip().decode('utf-8')
PROJ_PATH = os.path.join(ROOT_PATH, 'Projetos', 'src')
TOOLS_PATH = os.path.join(ROOT_PATH, 'Projetos', 'Z01-tools')
TOOLS_SCRIPT_PATH = os.path.join(TOOLS_PATH, 'scripts')

sys.path.insert(0,TOOLS_SCRIPT_PATH)

from toMIF import toMIF
from assembler import assembler
from testeAssembly import compareRam, compareFromTestDir
from simulateCPU import simulateFromTestDir

def testeAssembly(jar, nasmDir, hackDir):

    # global path
    os.path.abspath(nasm)
    os.path.abspath(hack)

    # compila
    print("-------------------------")
    print("- Assembling files .... " )
    print("-------------------------")
    if assembler(jar, nasm, hack, True) is not 0:
        sys.exit(-1)

if __name__ == "__main__":
    pwd = os.path.dirname(os.path.abspath(__file__))

    nasm = pwd+"/src/nasm/"
    hack = pwd+"/bin/hack/"

    jar = TOOLS_PATH+"/jar/Z01-Assembler.jar"
    testeAssembly(jar=jar, nasmDir=nasm, hackDir=hack)

