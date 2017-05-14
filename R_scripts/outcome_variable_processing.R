### Ramona Schufaisl thesis 
### Processing the Outcome variable in R
setwd("/Users/naveenoid/Documents/Ramona/thesis_kai_sux/R_scripts/")

## Loading the dta dataset
library(foreign)
original_df = read.dta("./../data/primary_dataset_stata12_11.dta")

## Data preprocessing
# converting DISTID to a factor variable
original_df$DISTID <- factor(original_df$DISTID)
# Adding a unqiue District ID to the dataset (interaction of STATE_ID and DIST_ID)
original_df$UNIQUEDISTID <- interaction(original_df$STATEID,  original_df$DISTID, drop = TRUE)
original_df$UNIQUEDISTID_FACTOR <- factor(original_df$UNIQUEDISTID)
# not really needed to bring back to unique
#original_dataset$UNIQUEDISTID <- factor(as.numeric(original_dataset$UNIQUEDISTID) - 1)

summary(orig)

casteassociation = data.frame(original_df$UNIQUEDISTID, original_df$ME8)
table(casteassociation)
#prop.table(table(casteassociation),1)
