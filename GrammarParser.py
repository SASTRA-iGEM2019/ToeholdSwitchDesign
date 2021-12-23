import sys
import re

bs_seq = sys.argv[1]
db_seq = sys.argv[2]

#------EXAMPLE------
# bs_seq = "GGGACTGATTAAAGATTGCTATGTGAGATTAAAGTTAACGGACTTTAGAACAGAGGAGATAAAGATGGTTAACTTTAACAACCTGGCGGCAGCGCAAAAG"
# db_seq = "(.(.(((........((((((.((..(.(((((((((((.(.(((((............))))).).)))))))))))).)).)))))))))).)....."

db_seq = db_seq.strip()

dom = re.match('^([\.\(\)?]*)(\({9,})([\.\.?\(?\.?]{3})(\({5,6}\.?)(\.*)(\){5,6})([\.\.?\)?\.?]{3})(\){9,})([\.\(\)?]*)$', db_seq) #regular expression match for domains based on grammar of toehold switch

toehold_domain_db = dom.group(1) #TOEHOLD DOMAIN
stemb_asc_db = dom.group(2) #BOTTOM STEM ASCENDING SEQUENCE
loop2_asc_db = dom.group(3) #SECONDARY LOOP ASCENDING: OPPOSITE TO AUG
stemt_asc_db = dom.group(4) #TOP STEM ASCENDING SEQUENCE
loop1_db = dom.group(5) #PRIMARY LOOP SEQUENCE: PRERBS + RBS
stemt_desc_db = dom.group(6) #TOP STEM DESCENDING SEQUENCE
start_db = dom.group(7) #AUG
stemb_desc_db = dom.group(8) #BOTTOM STEM DESCENDING SEQUENCE
horizontal_linker_domain_db = dom.group(9) #HORIZONTAL PORTION OF LINKER SEQUENCE
  
toehold_domain_seq = bs_seq[dom.start(1):dom.end(1)]
stemb_asc_seq = bs_seq[dom.start(2):dom.end(2)]
loop2_asc_seq = bs_seq[dom.start(3):dom.end(3)]
stemt_asc_seq = bs_seq[dom.start(4):dom.end(4)]
loop1_seq = bs_seq[dom.start(5):dom.end(5)]
stemt_desc_seq = bs_seq[dom.start(6):dom.end(6)]
start_seq = bs_seq[dom.start(7):dom.end(7)]
stemb_desc_seq = bs_seq[dom.start(8):dom.end(8)]
horizontal_linker_domain_seq = bs_seq[dom.start(9):dom.end(9)]

rbs_linker_seq = loop1_seq + stemt_desc_seq + start_seq + stemb_desc_seq + horizontal_linker_domain_seq  #RBS linker sequence
file = open("rbs_linker", "w")
file.write(rbs_linker_seq)
file.close

bottom_region_seq = toehold_domain_seq + stemb_asc_seq + "&" + stemb_desc_seq + horizontal_linker_domain_seq #Bottom region complex
file = open("bottom_region", "w")
file.write(bottom_region_seq)
file.close


#-----------ADDITIONAL SEQUENCE BASED FEATURES--------------#

# toehold_len = len(dom.group(1)) #toehold domain length
# stemb_len = len(dom.group(2)) #bottom stem length
# stemt_len = len(dom.group(4)) #top stem length
# preRBS_len = len(dom.group(5)) # preRBS length

# def GC_pair_count(seq): #Function that matches G or C: to find all GC base pairs
#     GC_pairs = re.findall("[GC]",seq)
#     return len(GC_pairs)

# def AU_count(seq): #Function that matches G or C: to find all GC base pairs
#     GC_pairs = re.findall("[AU]",seq)
#     return len(GC_pairs)
 

# print(db_seq, "\n")
# print(bs_seq,"\n")

# for i in range(1,10):
#     print("Domain",i,"\n",dom.group(i),"\n",bs_seq[dom.start(i):dom.end(i)],"\n")
    
# print("1. Toehold Domain Length: ", len(toehold_domain_seq))
# print("2. Bottom Stem Length: ", len(stemb_asc_seq))
# print("3. Top Stem Length: ", len(stemt_asc_seq))
# print("4. Primary Loop Sequence Length: ", len(loop1_seq)) 
# print("5. GC base pairs in Bottom Stem: ", GC_pair_count(stemb_asc_seq)) 
# print("6. GC base pairs in Top Stem: ", GC_pair_count(stemt_asc_seq))

