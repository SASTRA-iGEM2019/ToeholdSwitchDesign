#!/bin/bash

while true; do
    read -p "Enter switch sequence: " switch
    case $switch in
        [ATGCUatgcu]* ) touch switchSeq | echo "$switch" > switchSeq; break;; #GET SWITCH SEQUENCE AND OUTPUT TO FILE
        * ) echo -e "\nPLEASE PROVIDE A VALID SEQUENCE";;
    esac
done

while true; do
    read -p "Enter trigger sequence: " trigger
    case $trigger in
        [ATGCUatgcu]* ) touch triggerSeq | echo "$trigger" > triggerSeq; break;; #GET TRIGGER SEQUENCE AND OUTPUT TO FILE
        * ) echo -e "\nPLEASE PROVIDE A VALID SEQUENCE";;
    esac
done

switch_mfe=$(RNAfold switchSeq | grep -oE "\-?\d{1,2}\.\d{1,2}")   #SWITCH MINIMUM FREE ENERGY
trigger_mfe=$(RNAfold triggerSeq | grep -oE "\-?\d{1,2}\.\d{1,2}") #TRIGGER MINIMUM FREE ENERGY

echo -n "$switch&$trigger" > dimer; #OUTPUT DIMER TO USE IN RNACOFOLD

dimer_mfe=$(RNAcofold dimer | grep -oE "\-?\d{1,2}\.\d{1,2}") #SWITCH-TRIGGER COMPLEX MINIMUM FREE ENERGY

switch_db=$(RNAfold switchSeq | grep -oE "[\.\(\)]*\s" | head -n1)  #DOT-BRACKET STRUCTURE OF SWITCH FROM RNAFOLD
trigger_db=$(RNAfold triggerSeq | grep -oE "[\.\(\)]*\s" | head -n1) #DOT-BRACKET STRUCTURE OF TRIGGER FROM RNAFOLD

echo -e "Switch Sequence: $switch\n"
echo -e "Trigger Sequence: $trigger\n"

echo -e "Switch MFE: $switch_mfe \n"
echo -e "Switch DB: $switch_db\n"

echo -e "Trigger MFE: $trigger_mfe \n"
echo -e "Trigger DB: $trigger_db\n"

echo -e "Dimer MFE: $dimer_mfe \n"

net_mfe=$(echo "$switch_mfe + $trigger_mfe - $dimer_mfe" | bc) #NET MINIMUM FREE ENERGY OF COMPLEX 
echo -e "Net MFE: $net_mfe \n"

sh_37=$(RNAheat --Tmin=37 --Tmax=38 switchSeq | head -n1 | grep -oE "\d\.\d{1,}")  #SPECIFIC HEAT OF SWITCH AT 37 DEG CELSIUS
echo -e "SH 37: $sh_37 \n"

freq_mfe=$(RNAfold -p --MEA switchSeq | grep -oE "0\.\d{3,}") #FREQUENCY OF MFE SWITCH STRUCTURE IN ENSEMBLE
echo -e "Freq of MFE structure: $freq_mfe \n"

# CALLING THE GRAMMAR PARSER TO OBTAIN:

python3 GrammarParser.py $switch $switch_db 

# 1. Toehold Domain
# 2. Ascending bottom stem
# 3. Loop region opposite to AUG
# 4. Ascending top stem
# 5. RBS loop
# 6. Descending top stem
# 7. Start codon AUG
# 8. Descending bottom stem
# 9. Linker 

# A. Bottom Region - dimer between the 5' end toehold domain + ascending bottom stem AND the 3' descending bottom stem + linker
# B. RBS-Linker domain - sequence from the RBS loop till the 3' end of the linker

rbs_linker_mfe=$(RNAfold rbs_linker | grep -oE "\-?\d{1,2}\.\d{1,2}")
echo -e "RBS Linker MFE: $rbs_linker_mfe \n"

bottom_region_mfe=$(RNAcofold bottom_region | grep -oE "\-?\d{1,2}\.\d{1,2}")
echo -e "Bottom Region MFE: $bottom_region_mfe \n"


on_off=$(python predict_linear.py $switch_mfe $bottom_region_mfe $rbs_linker_mfe $net_mfe $freq_mfe $sh_37) #COEFFICIENT VALUES FOR ON/OFF RATIO PREDICTION

echo -e "--------------------------\nPREDICTED ON/OFF RATIO: $on_off\n--------------------------\n"

rm switchSeq triggerSeq rbs_linker dimer bottom_region dot.ps rna.ps  # REMOVE ALL FILES
