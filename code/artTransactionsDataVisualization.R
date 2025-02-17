install.packages("tidyverse")
library("tidyverse")
library("tidyr")
library("dplyr")
library(ggplot2)
library(ggrepel)
library(maps)


options(scipen = 999)


df <- read.csv("~/Desktop/dataJourneyCapstone/processedData.csv")



# Table for Question 1 Answers
df_summarized_info1 <- df %>%
  group_by(event_year, genre) %>%
  drop_na(event_year) %>%
  summarize(total_revenue = sum(price_usd, na.rm = TRUE), .groups = "drop")


ggplot(df_summarized_info1, aes(x = event_year, y = total_revenue, color = genre)) +
  geom_line() +
  labs(title = "Revenue by Genre Over Time", x = "Year", y = "Total Revenue (USD)") +
  scale_x_continuous(breaks = c(1995:2022))


ggplot(df_summarized_info1, aes(x = event_year, y=total_revenue, fill = genre)) + 
  geom_bar(position = "stack", stat = "identity") +
  theme_minimal() +
  labs(title = "Sales Volume over Time", x="Year", y="Number of Sales")



# Table for Question 2 Answers
df_summarized_info2 <- df %>%
  group_by(country_or_city) %>%
  summarise(total_usd = sum(price_usd)) %>%
  top_n(10, total_usd)

ggplot(df_summarized_info2, aes(x=reorder(country_or_city, -total_usd), y=total_usd)) + 
  geom_bar(stat="identity") +
  labs(title = "Total Revenue by Location", x="Location", y="Total")



# Table for Question 3 Answers
df_summarized_info3 <- df %>%
  group_by(auction_house) %>%
  summarise(total_usd = sum(price_usd), count = n()) %>%
  top_n(30, total_usd)


# Find 4 Outliers for the Graph
outliers <- df_summarized_info3 %>%
  arrange(desc(total_usd)) %>%
  head(4)


ggplot(df_summarized_info3, aes(x = count, y=total_usd)) +
  geom_point(aes(color = auction_house), alpha = 0.5) + 
  geom_text_repel(data = outliers, aes(label = auction_house), size = 3, box.padding = 0.5) +  # Outlier labels
  labs(title = "Auction House Revenue by Number of Art Pieces", x="Number of Art Pieces", y="Price (USD)")


# Subanswer for Question 3, box plot for each of the top 5 auction houses.
df_summarized_info4 <- df %>%
  group_by(auction_house) %>%
  summarise(total_usd = sum(price_usd)) # %>%
  # top_n(10, total_usd)

auctionHouses_forScatter <- filter(df, auction_house == "Artcurial - Briest, Poulain, F. Tajan" |
                                 auction_house == "Bonhams" |
                                 auction_house == "Christie" |
                                 auction_house == "Cornette de Saint Cyr" |
                                 auction_house == "Dorotheum" |
                                 auction_house == "Kunsthaus Lempertz" |
                                 auction_house == "Phillips" |
                                 auction_house == "Villa Grisebach Auktionen" |
                                 auction_house == "Phillips de Pury" |
                                 auction_house == "Sotheby")

ggplot(auctionHouses_forScatter, aes(x = auction_house, y=price_usd)) + 
  geom_jitter(aes(color = price_usd)) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
  labs(title = "Distribution of Art Pieces by Prices", x = "Auction House", y="Prices")


# Extra: Which regions had the most growth? (Focus on top 4)
df_summarized_info5 <- df %>%
  group_by(country_or_city, event_year) %>%
  summarise(total_usd = sum(price_usd)) %>%  # Summarize per location-year
  arrange(country_or_city, event_year) %>%  # Ensure correct order before lag()
  group_by(country_or_city) %>%  # Group by location
  mutate(
    prev_year = lag(event_year),  # Get previous year within the same location
    prev_total_usd = lag(total_usd),  # Get previous total_usd within the same location
    diff_year = event_year - prev_year,  # Year difference only within the same location
    diff_growth = total_usd - prev_total_usd,  # Growth difference only within location
    diff_percent = ifelse(!is.na(diff_year) & diff_year != 0, (diff_growth / diff_year) / total_usd * 100, NA)
  ) %>%
  ungroup()


filter_eventyear_regionData <- df_summarized_info5 %>%
  group_by(country_or_city) %>%
  filter(max(event_year) - min(event_year) >= 10)

ggplot(filter_eventyear_regionData, aes(x = event_year, y = country_or_city, fill = diff_growth)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "red", mid = "gray", high = "darkgreen", midpoint = 0) +
  labs(title = "Revenue Growth Rate by Region and Year",
       x = "Year", y = "Region") +
  theme(axis.text.7 = element_text(angle = 45)) +
  scale_y_discrete(limits=rev)




