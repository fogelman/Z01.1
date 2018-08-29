#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Curso de Elementos de Sistemas
# Desenvolvido por: Rafael Corsi <rafael.corsi@insper.edu.br>
#
# Adaptado de :     Pedro Cunial   <pedrocc4@al.insper.edu.br>
#                   Luciano Soares <lpsoares@insper.edu.br>
# Data de criação: 07/2017

from os.path import join, dirname
import sys
import os
import shutil
import subprocess

ROOT_PATH = subprocess.Popen(['git', 'rev-parse', '--show-toplevel'], stdout=subprocess.PIPE).communicate()[0].rstrip().decode('utf-8')
PROJ_PATH = os.path.join(ROOT_PATH, 'Projetos', 'src')
TOOL_PATH = os.path.join(ROOT_PATH, 'Projetos', 'Z01-tools')
TOOL_SCRIPT_PATH = os.path.join(TOOL_PATH, 'scripts')
PROJ_C_PATH = os.path.join(PROJ_PATH, 'C-LogicaCombinacional')

sys.path.insert(0,TOOL_SCRIPT_PATH)
sys.path.insert(0,PROJ_C_PATH)

from testeVHDL import vhdlScript
from testeLogicaCombinacional import tstLogiComb
from report import report

class tstUla(object):

    def __init__(self):
        self.pwd = os.path.dirname(os.path.abspath(__file__))
        self.rtl = self.pwd+'/src/rtl/'
        self.tst = os.path.join(self.pwd,'tests/')
        self.log = os.path.join(TOOL_PATH,'log','logD.xml')
        self.work = vhdlScript(self.log)

    def addSrc(self, work):
        work.addSrc(self.rtl)

    def addTst(self, work):
        if work.addTstConfigFile(self.tst) is False:
            sys.exit(1)


    def add(self, work):
        self.addSrc(work)
        self.addTst(work)

if __name__ == "__main__":
    ## Init ALU
    tstUla = tstUla()

    ## Logica Combinacional RTL
    tstLogiComb = tstLogiComb()
    tstLogiComb.addSrc(tstUla.work)

    print("---------- Portas Logicas            ")
    print("---------- 04-Unidade-Logica-Aritmetica")
    tstUla.add(tstUla.work)
    tstUla.work.run()

    print("===================================================")
    print("Reporting test result to server")
    r = report(tstUla.log, 'D')
    error = r.hw()
    r.send()
    sys.exit(error)
    print("===================================================")


