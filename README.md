# Toehold switch modelling

This repository provides insight into [iGEM SASTRA 2019](https://2019.igem.org/Team:SASTRA_Thanjavur)'s software effort to predict the ON/OFF ratio of toehold switches. The ON/OFF ratio represents the dynamic range of the toehold switch, an important *in vitro* metric to determine the efficacy and performance of a toehold switch.

We provide two tools to work with the design of toehold switches:

(1) GrammarParser.py:

Used to return the domain structure of a toehold switch sequence, i.e, parsing the sequence into its parts. Please see our manuscript (Baabu et al., 2021) for more details. 
Output:

Usage: 
python GrammarParser toehold_seq dot-bracket_rep

(2) predict.py:
Used to predict the efficacy (i.e, dynamic range) of a new toehold switch. Takes the following feature values in order as arguments:
(1) 

Usage:
 python predict.py arg1 arg2 arg3 ...

Output: 

(3) toehold_efficacy_predict.sh
We also provide a wrapper to automate the prediction of toehold efficacy given toehold sequence(s).


## Data

The **data** folder consists of the engineered features for the 228 toehold instances from the literature [1,2,3]: 

(1) *all_features.csv* : consisting of all the engineered sequence and structural features

(2) *selected_features.csv* : consisting features with the best predictive capabilities, post feature-selection (see our manuscript for details).

## Citation 

Our software is made freely available for the scientific community under GNU GPL v3. To cite:
Baabu et al [End-to-end computational approach to the design of RNA biosensors for miRNA biomarkers of cervical cancer](https://doi.org/10.1101/2021.07.09.451282). (2021) 

### References
---
1. Green AA, Silver PA, Collins JJ, Yin P. Toehold switches: De-novo-designed regulators of gene expression. Cell 2014. https://doi.org/10.1016/j.cell.2014.10.002. 
2.  Pardee K, Green AA, Takahashi MK, Braff D, Lambert G, Lee JW, et al. Rapid, LowCost Detection of Zika Virus Using Programmable Biomolecular Components. Cell
2016;165:1255–66. https://doi.org/10.1016/j.cell.2016.04.059.
3. Green AA, Kim J, Ma D, Silver PA, Collins JJ, Yin P. Complex cellular logic computation using ribocomputing devices. Nature 2017. https://doi.org/10.1038/nature23271.
