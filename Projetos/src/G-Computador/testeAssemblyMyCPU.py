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
import argparse

# Scripts python
ROOT_PATH = subprocess.Popen(['git', 'rev-parse', '--show-toplevel'], stdout=subprocess.PIPE).communicate()[0].rstrip().decode('utf-8')
PROJ_PATH = os.path.join(ROOT_PATH, 'Projetos', 'src')
TOOLS_PATH = os.path.join(ROOT_PATH, 'Projetos', 'Z01-tools')
TOOLS_SCRIPT_PATH = os.path.join(TOOLS_PATH, 'scripts')

sys.path.insert(0,TOOLS_SCRIPT_PATH)

from assembler import assembler, clearbin
from testeAssembly import compareRam, compareFromTestDir, clearTestDir
from simulateCPU import simulateFromTestDir
from report import report
##################################################

def testeAssembly(jar, testDir, nasmDir, hackDir, gui, verbose, skip):

    pwd = os.path.dirname(os.path.abspath(__file__))
    rtlDir = os.path.join(pwd, 'Z01-Simulator-RTL')

    # global path
    os.path.abspath(nasm)
    os.path.abspath(hack)

    print("==== Assembling Files ==========================")
    clearbin(hack)
    errAssembler, logAssembler =  assembler(jar, nasm, hack, True)

    if errAssembler == 0:
        print("==== Simulating ================================")
        clearTestDir(testDir)
        if simulateFromTestDir(testDir, hackDir, gui, verbose, rtlDir=rtlDir) < 0 :
            sys.exit(1)

        # testAssembling files
        print("==== Testando ==================================")
        error, log = compareFromTestDir(testDir)

        if error < -1:
            sys.exit(1)

    # report error
    print("==== Reporting results =========================")
    r = report(log, 'G')
    error = r.assemblyTeste(log)
    r.send()

if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("-c", "--testDir", help="lista de arquivos a serem testados")
    ap.add_argument("-s", "--skipCompilation", help="não compila novamente os programas", action='store_true')
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

    if args["skipCompilation"]:
        skip = False
    else:
        skip = True

    pwd = os.path.dirname(os.path.abspath(__file__))
    testDir = PROJ_PATH + "/F-Assembly/tests/"
    nasm = PROJ_PATH + "/F-Assembly/src/nasm/"
    hack = PROJ_PATH + "/G-Computador/bin/hack/"

    jar = TOOLS_PATH+"/jar/Z01-Assembler.jar"
    testeAssembly(jar=jar, testDir=testDir, nasmDir=nasm, hackDir=hack, gui=gui, verbose=verbose, skip=skip)

