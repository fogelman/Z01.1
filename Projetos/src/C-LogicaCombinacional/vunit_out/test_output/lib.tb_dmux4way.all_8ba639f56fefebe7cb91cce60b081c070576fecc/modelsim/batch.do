onerror {quit -code 1}
source "/home/paineira/Documents/Insper/Elementos/Z01.1/Projetos/src/C-LogicaCombinacional/vunit_out/test_output/lib.tb_dmux4way.all_8ba639f56fefebe7cb91cce60b081c070576fecc/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
