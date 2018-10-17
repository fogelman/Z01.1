#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Curso de Elementos de Sistemas
# Desenvolvido por: Rafael Corsi <rafael.corsi@insper.edu.br>
#
# Adaptado de :     Pedro Cunial   <pedrocc4@al.insper.edu.br>
#                   Luciano Soares <lpsoares@insper.edu.br>
# Data de criação: 07/2017
##################################################
from os.path import join, dirname
import sys
import os
import shutil
import subprocess

ROOT_PATH = subprocess.Popen(['git', 'rev-parse', '--show-toplevel'], stdout=subprocess.PIPE).communicate()[0].rstrip().decode('utf-8')
PROJ_PATH = os.path.join(ROOT_PATH, 'Projetos', 'src')
TOOLS_PATH = os.path.join(ROOT_PATH, 'Projetos', 'Z01-tools')
TOOLS_SCRIPT_PATH = os.path.join(TOOLS_PATH, 'scripts')
PROJ_C_PATH = os.path.join(PROJ_PATH, 'C-LogicaCombinacional')
PROJ_D_PATH = os.path.join(PROJ_PATH, 'D-UnidadeLogicaAritmetica')
PROJ_E_PATH = os.path.join(PROJ_PATH, 'E-LogicaSequencial')

sys.path.insert(0,TOOLS_SCRIPT_PATH)
sys.path.insert(0,PROJ_C_PATH)
sys.path.insert(0,PROJ_D_PATH)
sys.path.insert(0,PROJ_E_PATH)

from testeVHDL import vhdlScript
from testeLogicaCombinacional import tstLogiComb
from testeULA import tstUla
from testeLogicaSequencial import tstLogiSeq
from report import report

##################################################


class tstHW(object):

    def __init__(self):
        self.pwd = os.path.dirname(os.path.abspath(__file__))
        self.rtl = os.path.join(self.pwd, 'src/rtl/')
        self.tst = os.path.join(self.pwd, 'tests/vhd/')
        self.log = os.path.join(TOOLS_PATH,'log','logG.xml')
        self.work = vhdlScript(self.log)

    def addSrc(self, work):
        work.addSrc(self.rtl)
        work.addSrcFile(self.rtl+'Dispositivos/RAM/RAM16K.vho')
        work.addSrcFile(self.rtl+'Dispositivos/Screen/Screen.vho')
 
    def addTst(self, work):
        work.addSrc(self.tst)

    def add(self, work):
        self.addSrc(work)
        self.addTst(work)

if __name__ == "__main__":
    # Init ALU
    tstCu = tstHW()
    tstLogiComb = tstLogiComb()
    tstUla = tstUla()
    tstSeq = tstLogiSeq()

    tstLogiComb.addSrc(tstCu.work)
    tstUla.addSrc(tstCu.work)
    tstSeq.addSrc(tstCu.work)
    tstCu.add(tstCu.work)
    tstCu.work.run()

    print("===================================================")
    print("Reporting test result to server")
    r = report(tstCu.log, 'G')
    error = r.hw()
    r.send()
    sys.exit(error)
    print("===================================================")
