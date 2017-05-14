## Outcome variable processing 
## Ramona Schufaisl Thesis
##
## Processing of Population, female population, and literacy rate 

## Setup working directory and install stuff
setwd("/Users/naveenoid/Documents/Ramona/thesis/R_scripts/")

library("xlsx")
library("dplyr")

# read xlsx file into R
df = read.xlsx2("./../data/population_literacy/population_literacy_districwise.xlsx", 1, header = TRUE, 
                colClasses = c(rep("numeric",2), rep("character",2),rep("numeric",9)))
# renaming columns
colnames(df) <- c("state_code",	"district_code", "area_name", "tru", "population_person", "population_male", 
                  "population_female", "population_0_6_persons", "population_0_6_males","population_0_6_females",	
                  "literates_persons",	"literate_males",	"literate_females")

# Remove all rows and columns where certain conditions arent met.
simpler_df <-  df[df$tru=="Total" & df$district_code != 0,
                  c("state_code", "district_code", "area_name", "population_person", "population_female", 
                    "literates_persons", "literate_females") ]

simpler_df$sex_ratio <- 100 * (simpler_df$population_female / simpler_df$population_person)
simpler_df$female_literacy_rate <- 100 * (simpler_df$literate_females / simpler_df$population_female)
