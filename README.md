# Modelling the dynamic range of second-generation toehold switches

Three open-source tools were developed for machine-learning based design of RNA devices, namely toehold switches. They have been developed for second-generation toehold switch designs, but could be adapted for first-generation toehold switches. Our software is made freely available for the scientific community under GNU GPLv3. 

(1) GrammarParser.py:

Used to return the domain structure of a toehold switch, i.e, parsing the sequence into its structural segments based on the grammar of dot-bracket representations. The dot-bracket representation could be obtained by `ViennaRNNA`'s RNAfold.
 - `Input`: Toehold switch sequence (`toehold_seq`) & predicted dot-bracket representation (`dot-bracket_rep`)
 - `Output`: Parsed domain sequences 
 -  Usage: `python GrammarParser toehold_seq dot-bracket_rep`

(2) predict_linear.py:

Used to predict the efficacy (i.e, dynamic range) of a new toehold switch. Takes the non-redundant engineered feature values in order as arguments, and returns the dynamic range of the construct: 
 - `Input` (six `Features` in order): `Overall Switch MFE` `Bottom Region MFE` `RBS Linker MFE` `Net MFE` `Frequency of MFE structure` `Specific Heat at 37 deg C`
 - `Output`: Dynamic range of the given toehold switch construct
 -  Usage: `python predict.py InputFeatures`

(3) nn_model.ipynb:

This Jupyter notebook contains the code to validate our neural network model. To use it for predicting efficacies of new toehold switches, the path to a csv file with the instances/features may be specified in the final code block in the indicated place; the header line and first two fields are ignored. See here for an [`example`](https://raw.githubusercontent.com/SASTRA-iGEM2019/ToeholdSwitchDesign/master/data/miR_toeholds.csv). Then use the following code, where the path to the saved model (see section on **NN_models**) may also be provided:

```
import pandas as pd 
from keras.models import load_model
new_feats= pd.read_csv('/path/to/csv_file')
new_feats = new_feats.iloc[:,2:]
#normalize the features as in the original script; use the StandardScaler fit on the training data. Then:
model = load_model('/path/to/saved_model/',custom_objects={'r_square':r_square})
print(float(model.predict(new_feats)))
```
  
(4) toehold_efficacy_predict.sh:
 
    An integrated script written in bash that provides an end-to-end pipeline for the prediction of toehold efficacy for second-generation toehold switches.  

    The script does the following:
 
    (i) calls ViennaRNA RNAfold to parse the input sequence into its dot-bracket representation
 
    (ii) calls GrammarParser to then extract the segments of the toehold switch based on this dot-bracket representation
 
    (iii) calls more ViennaRNA RNAfold utilities to obtain engineered feature values for the given toehold switch sequence
 
    (iv) passes these feature values as input to 'predict_linear.py` and returns the dynamic range of the toehold switch sequence. Alternatively the user may use nn_model.py described above for making the predictions. 
 
 - `Input`: Toehold switch sequence(s) in .fasta or .txt format.
 - `Output`: Predicted dynamic range(s) of given toehold switch sequence(s), and engineered feature values.
 - Usage: `sh ./toehold_efficacy_predict.sh Input_Seq_File`
 
### Requirements:
 
(1) [`ViennaRNA`](https://www.tbi.univie.ac.at/RNA/) must be installed and available in the path. 
 
(2) Python 3.x with pandas, numpy,  matplotlib, sklearn, tensorflow and keras libraries. 
 
(3) bash shell
 

## Data

The **data** folder consists of the engineered features for the 228 toehold instances from the literature [1,2,3]: 

(1) *all_features.csv* : consisting of all the engineered sequence and structural features

(2) *selected_features.csv* : consisting features with the best predictive capabilities, post feature-selection (see our manuscript for details).

(3) *miR_toeholds.csv*: consisting features of the toehold switches designed for the two miRNA biomarkers of cervical cancer identified in our study, viz. mir-21-5p and miR-20a-5p. 

## NN_Models 

This folder contains the *saved_models* of the best-performing neural network models (adj. R2 > 0.5) for making batch-predictions on new toehold switches. The models are suffixed with a number, indicating their rank. To find the ON/OFF ratio of designed toehold switches using any of these models, load the model and predict. 

```
import pandas as pd 
from keras.models import load_model
new_feats= pd.read_csv('/path/to/csv_file')
new_feats = new_feats.iloc[:,2:]
#normalize the features as in the original script; use the StandardScaler fit on the training data. Then:
model = load_model('/path/to/saved_model/',custom_objects={'r_square':r_square})
print(float(model.predict(new_feats)))
```

## Video demo

Please find a short video tutorial [here](https://youtu.be/_HCex0ePSHI) explaining how to use our scripts, validated using Takahashi et al [^takahashi].

[![Toehold switch software](http://img.youtube.com/vi/_HCex0ePSHI/0.jpg)](http://www.youtube.com/watch?v=_HCex0ePSHI "Software Demo")

## Citation 

Please cite our work: 

Baabu PRS, Srinivasan S, Nagarajan S, Muthamilselvan S, Selvi T, Suresh RR, Palaniappan A. [End-to-end computational approach to the design of RNA biosensors for detecting miRNA biomarkers of cervical cancer](https://www.sciencedirect.com/science/article/pii/S2405805X22000321). Synth Syst Biotechnol. 2022 Apr 4;7(2):802-814. doi: 10.1016/j.synbio.2022.03.008. PMI D: 35475253; PMCID: PMC9014444.

[biorxiv preprint](https://doi.org/10.1101/2021.07.09.451282) (2021). 

## Contact

For comments, queries and more information, please contact [`Ashok Palaniappan`](mailto:apalaniaATscbtDOTsastraDOTacDOTin) 

### Primary sources for building our dataset:
1. Green AA, Silver PA, Collins JJ, Yin P. Toehold switches: De-novo-designed regulators of gene expression. Cell 2014. https://doi.org/10.1016/j.cell.2014.10.002. 
2.  Pardee K, Green AA, Takahashi MK, Braff D, Lambert G, Lee JW, et al. Rapid, LowCost Detection of Zika Virus Using Programmable Biomolecular Components. Cell
2016;165:1255–66. https://doi.org/10.1016/j.cell.2016.04.059.
3. Green AA, Kim J, Ma D, Silver PA, Collins JJ, Yin P. Complex cellular logic computation using ribocomputing devices. Nature 2017. https://doi.org/10.1038/nature23271.

[^takahashi]: Takahashi, M.K., Tan, X., Dy, A.J. et al. A low-cost paper-based synthetic biology platform for analyzing gut microbiota and host biomarkers. Nat Commun 9, 3347 (2018). https://doi.org/10.1038/s41467-018-05864-4
