onerror {quit -code 1}
source "/home/paineira/Documents/Z01.1/Projetos/src/C-LogicaCombinacional/vunit_out/test_output/lib.tb_mux4way.all_eb305fd8bfee2240fe2d11f62749d522292ea5cb/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
