onerror {quit -code 1}
source "/home/paineira/Documents/Insper/Elementos/Z01.1/Projetos/src/C-LogicaCombinacional/vunit_out/test_output/lib.tb_mux8way.all_53d37fb647db4a97e930be8cee067762d0baa1ca/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
