#!/bin/csh


#Clear the terminal
reset

#Tapenade directory NEEDS TO BE CHANGED TO LOCAL INSTALL
set TAPENADE_HOME = /home/gvernier/Adjoint/Tapenade/tapenade3.13/

#Tapenade options
set opts = "-tgtvarname _tl -tgtfuncname _tlm -adjvarname _ad -adjfuncname _adm"


#Generate tangent linear code
#----------------------------
@ start_time = `date +%s`

rm -rf tlm/
mkdir tlm/
rm -rf tlm/tapenadehtml

$TAPENADE_HOME/bin/tapenade ${opts} -d -O tlm/ -head "gsw_pot_to_insitu.t_from_pt (t_from_pt pt_in)/(t_from_pt pt_in)" gsw_pot_to_insitu.f90 modules/*0 toolbox/*0

cd tlm/

#Rename file ending to match the model
#May want to delete the files you dont need here

cd ../

@ end_time = `date +%s`
@ diff = $end_time - $start_time
echo "TLM generation took $diff seconds"


#Generate adjoint code
#---------------------
@ start_time = `date +%s`

rm -rf adm/
mkdir adm/
rm -rf adm/tapenadehtml

$TAPENADE_HOME/bin/tapenade ${opts} -b -O adm/ -head "gsw_pot_to_insitu.t_from_pt (t_from_pt pt_in)/(t_from_pt pt_in)" gsw_pot_to_insitu.f90 modules/*0 toolbox/*0

cd adm/

#Rename file ending to match the model
#May want to delete the files you dont need here

cd ../

@ end_time = `date +%s`
@ diff = $end_time - $start_time
echo "ADM generation took $diff seconds"

