## Outcome variable processing 
## Ramona Schufaisl Thesis
##
## Processing of % Married under 18.

## Setup working directory and load libs needed
setwd("/Users/naveenoid/Documents/Ramona/thesis/R_scripts/")

## Load and preprocess
library("xlsx")
library("dplyr")

# read xlsx file into R
df = read.xlsx2("./../data/age_at_marriage/DDW-0100C-06_kashmir.xlsx", 1, header=TRUE,
                 colClasses=c("character",rep("numeric",2),rep("character",4), rep("numeric", 18)))
# rename columns into something easier to interpret
colnames(df) <- c("table_name", "state_code","distt_code","area_name","total_rural_urban","education_level",
                  "age_at_marriage","number_ever_married_male","number_ever_married_female",
                  sprintf("extra[%s]",seq(10:ncol(df))))
# Remove all rows and columns where certain conditions arent met.
simpler_df <-  df[df$education_level=="Total" & df$total_rural_urban=="Total" & 
                    df$age_at_marriage!="All ages" & df$age_at_marriage!="Age Not stated" & df$distt_code != 0,
                  c("area_name", "total_rural_urban", "education_level", "age_at_marriage", 
                    "number_ever_married_female") ]
# Create a categorical variable for distinguishing under18 married women
simpler_df$under18 <- as.numeric(simpler_df$age_at_marriage == "Less than 10" |
                                   simpler_df$age_at_marriage == "10-11" |
                                   simpler_df$age_at_marriage == "12-13" |
                                   simpler_df$age_at_marriage == "14-15" |
                                   simpler_df$age_at_marriage == "16-17")
aggregate_under18 <- simpler_df %>%
            filter(under18 == 1) %>%
            group_by(area_name) %>% 
            summarise(under18 = sum(number_ever_married_female))
aggregate_over18 <- simpler_df %>%
            filter(under18 == 0) %>%
            group_by(area_name) %>% 
            summarise(over18 = sum(number_ever_married_female))

colnames(aggregate_under18) <- c("area_name","married_women_under18")
colnames(aggregate_over18) <- c("area_name","married_women_over18")
simpler_df_aggregate <- merge(aggregate_under18, aggregate_over18)
levels(simpler_df_aggregate$area_name) <- sub("District -", "", levels(simpler_df_aggregate$area_name))
