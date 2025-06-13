library(readr)
library(dplyr)
setwd("/home/dev-jack/Documents/Data-Science-with-Python/data_camp/nobel_prize")
#read data
nobel_data <- read_csv("nobel.csv")

#most commonly awarded gender and birth country
top_gender <- names(sort(table(nobel_data$sex), decreasing = TRUE))[1]
top_country <- names(sort(table(nobel_data$birth_country), decreasing = TRUE))[1]

#Which decade had the highest ratio of US-born Nobel Prize winners to total winners in all categories?
nobel <- nobel_data %>%
  mutate(
    usa_born_winner = birth_country == "United States of America",
    decade = floor(year / 10) * 10
  ) 

prop_usa_winners <- nobel %>%
  group_by(decade) %>%
  summarise(prop_usa = mean(usa_born_winner, na.rm = TRUE))

max_decade_usa <- prop_usa_winners %>%
  filter(prop_usa == max(prop_usa)) %>%
  pull(decade) %>%
  as.integer()


#####

# Step 2: Compute proportion of female laureates per decade and category
prop_female <- nobel %>%
  group_by(decade, category) %>%
  summarise(prop_female = mean(sex == "Female", na.rm = TRUE), .groups = "drop")

# Step 3: Get the combination with the highest proportion
max_row <- prop_female %>%
  filter(prop_female == max(prop_female)) %>%
  slice(1)  # just in case there's a tie, pick the first

# Step 4: Store as a "dictionary" (named list in R)
max_female_dict <- setNames(as.list(max_row$category), max_row$decade)

##########
# Filter for female laureates and sort by year
first_woman <- nobel %>%
  filter(sex == "Female") %>%
  arrange(year) %>%
  slice(1)  # get the earliest one

# Save the name and category as variables
first_woman_name <- first_woman$full_name
first_woman_category <- first_woman$category

######## Count how many times each name appears
repeat_winners <- nobel %>%
  group_by(full_name) %>%
  summarise(prize_count = n(), .groups = "drop") %>%
  filter(prize_count > 1)

# Store names as a list
repeat_list <- repeat_winners$full_name
  