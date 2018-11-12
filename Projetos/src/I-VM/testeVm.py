#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rafael Corsi @ insper.edu.br
# Dez/2017
# Disciplina Elementos de Sistemas

from os.path import join, dirname
import sys
import os
import shutil
import subprocess
import argparse

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
from vmtranslator import vmtranslator
from compileVM import compileVM

def testeVM(jarAssembler, jarVM, testDir, vmDir, nasmDir, hackDir, gui, verbose):

    compileVM(False, jarVM)

    # montador
    print("-------------------------")
    print("- Assembling files .... " )
    print("-------------------------")
    assembler(jarAssembler, nasm, hack, True)

    # simulando
    print("-------------------------")
    print("- Simulating .... ")
    print("-------------------------")
    simulateFromTestDir(testDir, hackDir, gui, verbose)

    # testAssembling files
    print("-------------------------")
    print("- Testando .... ")
    print("-------------------------")
    compareFromTestDir(testDir)

if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("-c", "--testDir", help="lista de arquivos a serem testados")
    ap.add_argument("-v", "--verbose", help="log simulacao", action='store_true')
    ap.add_argument("-g", "--gui", help="carrega model sim", action='store_true')
    args = vars(ap.parse_args())

    if args["verbose"]:
        verbose = True
    else:
        verbose = False

    if args["gui"]:
        gui = True
    else:
        gui = False

    pwd = os.path.dirname(os.path.abspath(__file__))
    testDir = pwd+"/tests/"
    vmDir = pwd+"/src/vm/"
    nasm = pwd+"/bin/nasm/"
    hack = pwd+"/bin/hack/"

    jarAssembler = TOOLS_PATH+"/jar/Z01-Assembler.jar"
    jarVM = TOOLS_PATH+"/jar/Z01-VMTranslator.jar"
    testeVM(jarAssembler, jarVM, vmDir=vmDir, testDir=testDir, nasmDir=nasm, hackDir=hack, gui=gui, verbose=verbose)

