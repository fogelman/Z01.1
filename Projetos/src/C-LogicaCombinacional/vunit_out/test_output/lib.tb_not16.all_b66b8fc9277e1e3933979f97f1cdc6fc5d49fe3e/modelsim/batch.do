onerror {quit -code 1}
source "/home/paineira/Documents/Z01.1/Projetos/src/C-LogicaCombinacional/vunit_out/test_output/lib.tb_not16.all_b66b8fc9277e1e3933979f97f1cdc6fc5d49fe3e/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
