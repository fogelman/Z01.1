onerror {quit -code 1}
source "/home/paineira/Documents/Insper/Elementos/Z01.1/Projetos/src/C-LogicaCombinacional/vunit_out/test_output/lib.tb_nand.all_d9f40c4b9b8a853c92c00dd8a102ec369f48636d/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
