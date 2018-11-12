#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rafael Corsi @ insper.edu.br
# Dez/2017
# Disciplina Elementos de Sistemas
#
from os.path import join, dirname
import sys
import os
import shutil
import subprocess
import argparse

# Scripts python
ROOT_PATH = subprocess.Popen(['git', 'rev-parse', '--show-toplevel'], stdout=subprocess.PIPE).communicate()[0].rstrip().decode('utf-8')
PROJ_PATH = os.path.join(ROOT_PATH, 'Projetos', 'src')
TOOL_PATH = os.path.join(ROOT_PATH, 'Projetos', 'Z01-tools')
TOOL_SCRIPT_PATH = os.path.join(TOOL_PATH, 'scripts')
sys.path.insert(0,TOOL_SCRIPT_PATH)
from report import report

def assemblerReport(logFile, send):
    pwd = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'Assembler/')

    print("==== Results ============================")
    r = report('', 'H')

    print(logFile)
    if logFile is None:
        if r.assembler(pwd+'logJCode.txt'):
            print("==== ERRO ======================================")
            print('=> Erro Teste Java, analise log do maven!   ')
            print('=> Code ')
            print("================================================")
            sys.exit(-1)

        if r.assembler(pwd+'logJParser.txt'):
            print("==== ERRO ======================================")
            print('=> Erro Teste Java, analise log do maven! 2')
            print('=> Parser ')
            print("================================================")
            sys.exit(-1)

        if r.assembler(pwd+'logJSymbolTable.txt'):
            print("==== Testando ==================================")
            print('=> Erro Teste Java, analise log do maven! 3')
            print('=> Symbol Table ')
            print("================================================")
            sys.exit(-1)
    else:
        if r.assembler(pwd+logFile):
            print("==== ERRO ======================================")
            print('=> Erro Teste Java, analise log do maven! 4')
            print("================================================")
            sys.exit(-1)

    if(send):
        print("==== Reporting results =========================")
        r.parSend()

if __name__ == "__main__":

    ap = argparse.ArgumentParser()
    ap.add_argument("-f", "--logFile", help="log file a ser enviado")
    args = vars(ap.parse_args())

    logFile = None
    if args['logFile']:
        logFile = args['logFile']

    assemblerReport(logFile, True)

