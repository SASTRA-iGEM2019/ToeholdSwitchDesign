# Prediction of the ON/OFF ratio of toehold switches and subsequent domain-wise design.
---
This repository provides insight into [iGEM SASTRA 2019](https://2019.igem.org/Team:SASTRA_Thanjavur)'s software effort to predict the ON/OFF ratio of toehold switches. The ON/OFF ratio represents the dynamic range of the toehold switch, an important *in vitro* metric to determine the efficacy and performance of a toehold switch.

## Data
---
The **/data** folder consists of two *.csv* files: *all_features.csv* and *selected_features.csv*.  The former consists of all the engineered sequence and structural features and the latter consists of features with the best predictive capabilities.

The toehold switch sequences described in this work are of three types:
1. First generation switches - Switches numbered from 1 - 168 (inclusive) are first generation toehold switches with lesser dynamic range.  These were obtained from Green et al. (2014) [^1].
2. Forward engineered switches - Switches numbered from 169 - 181 (inclusive) are forward engineered switches, with significantly higher dynamic range (high ON/OFF) ratios, also obtained from Green et al. (2014)[^1].
3. Toehold switches engineered for detecting Zika virus - Switches numbered from 182 - 228 (inclusive) are obtained from Pardee et al. (2016) [^2].  These switches have been used in the context of Zika virus detection.

The goal of this work is to design *second generation toehold switches*, those that would bind to a trigger complex between an miRNA and and anti-miR sequence instead of just a single molecular species.  The design of the second generation toehold switch is described in Green et al. (2017). [^3]

### References
---
1. Green AA, Silver PA, Collins JJ, Yin P. Toehold switches: De-novo-designed regulators of gene expression. Cell 2014. https://doi.org/10.1016/j.cell.2014.10.002. 
2.  Pardee K, Green AA, Takahashi MK, Braff D, Lambert G, Lee JW, et al. Rapid, LowCost Detection of Zika Virus Using Programmable Biomolecular Components. Cell
2016;165:1255–66. https://doi.org/10.1016/j.cell.2016.04.059.
3. Green AA, Kim J, Ma D, Silver PA, Collins JJ, Yin P. Complex cellular logic computation using ribocomputing devices. Nature 2017. https://doi.org/10.1038/nature23271.


## Citation 
---
More information about the toehold switch prediction software can be found in the preprint titled: [End-to-end computational approach to the design of RNA biosensors for miRNA biomarkers of cervical cancer](https://doi.org/10.1101/2021.07.09.451282). [Manuscript submitted]
