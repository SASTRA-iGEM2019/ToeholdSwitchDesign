# Modelling the dynamic range of second-generation toehold switches

Three open-source tools were developed for machine-learning based design of RNA devices, namely toehold switches. They have been developed for second-generation toehold switch designs, but could be adapted for first-generation toehold switches. 

(1) GrammarParser.py:

Used to return the domain structure of a toehold switch, i.e, parsing the sequence into its structural segments based on the grammar of dot-bracket representations. The dot-bracket representation could be obtained `ViennaRNNA`'s RNAfold.
 - `Input`: Toehold sequence (toehold_seq) & its dot-bracket representation (dot-bracket_rep)
 - `Usage`: `python GrammarParser toehold_seq dot-bracket_rep`
 - `Output`: Toehold switch segments

(2) predict.py:

Used to predict the efficacy (i.e, dynamic range) of a new toehold switch. Takes the non-redundant engineered feature values in order as arguments, and returns the dynamic range of the construct: 
 - `Input` (six `Features` in order): OverallMFE Frequency NetMFE BotRegMFE RBS-linkerMFE SpHeat
 - `Usage`: `python predict.py InputFeatures`
 - `Output`: Dynamic range of the given toehold switch construct

  
(3) toehold_efficacy_predict.sh:
 
    An integrated script written in bash that provides an end-to-end pipeline for the prediction of toehold efficacy for second-generation toehold switches.  

    The script does the following:
 
    (i) calls ViennaRNA RNAfold to parse the input sequence into its dot-bracket representation
 
    (ii) calls GrammarParser to then extract the segments of the toehold switch based on this dot-bracket representation
 
    (iii) calls more ViennaRNA RNAfold utilities to obtain engineered feature values for the given toehold switch sequence
 
    (iv) passes these feature values as input to 'predict.py` and returns the dynamic range of the toehold switch sequence. 
 
 - `Input`: Toehold switch sequence(s) in FASTA format.
 - `Output`: Predicted dynamic range(s) of given toehold switch sequence(s)
 - `Usage`: `sh ./toehold_efficacy_predict.sh Input_Seq_File`

    The script can be operated in **`batch` mode** by providing an `Input_Seq_File` with multiple toehold switch sequences. The dynamic ranges of all the toeholds are then predicted. 
 
### Requirements:
 
(1) [`ViennaRNA`](https://www.tbi.univie.ac.at/RNA/) must be installed and available in the path. 
 
(2) Python 
 
(3) bash shell
 

## Data

The **data** folder consists of the engineered features for the 228 toehold instances from the literature [1,2,3]: 

(1) *all_features.csv* : consisting of all the engineered sequence and structural features

(2) *selected_features.csv* : consisting features with the best predictive capabilities, post feature-selection (see our manuscript for details).

## Citation 

Our software is made freely available for the scientific community under GNU GPL v3. To cite:
 
Baabu et al [End-to-end computational approach to the design of RNA biosensors for miRNA biomarkers of cervical cancer](https://doi.org/10.1101/2021.07.09.451282). (2021) 

### Primary sources for building our dataset:
1. Green AA, Silver PA, Collins JJ, Yin P. Toehold switches: De-novo-designed regulators of gene expression. Cell 2014. https://doi.org/10.1016/j.cell.2014.10.002. 
2.  Pardee K, Green AA, Takahashi MK, Braff D, Lambert G, Lee JW, et al. Rapid, LowCost Detection of Zika Virus Using Programmable Biomolecular Components. Cell
2016;165:1255–66. https://doi.org/10.1016/j.cell.2016.04.059.
3. Green AA, Kim J, Ma D, Silver PA, Collins JJ, Yin P. Complex cellular logic computation using ribocomputing devices. Nature 2017. https://doi.org/10.1038/nature23271.
