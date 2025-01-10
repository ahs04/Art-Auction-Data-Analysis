# Art-Auction-Data-Analysis

Case Study from Google Data Analytics Capstone Project: [Google Data Analytics Capstone](https://www.coursera.org/learn/google-data-analytics-capstone)

## Introduction
In this case study, I will perform data analysis on the art auction dataset collected by *Kangsan Lee et al.*. This dataset was initally found on the [Data Is Plural](https://www.data-is-plural.com/archive/2024-08-07-edition/) website and also was published [here](https://www.nature.com/articles/s41598-024-60957-z). I will use this dataset to analyze trends and patterns for a fictional art magazine client and highlight the main pieces for consideration in future publications.

## Context
Working for a fictional art magazine client, the company wants to analyze trends and patterns found on art auctions to highlight insights in the art market. To do so, they want to see which styles, mediums, and artists are gaining in popularity. The editor wants to identify up and coming patterns that can resonate with art enthusiasts and readers to help drive which topics to highlight in future articles. For example, if the data shows a rise in demand for a specific style, the editorial team can focus on these areas to stay ahead of the industry. This not only extends to  magazine/print media but also for publishing web-based articles as well. 

## Step 1: Ask

**Business Task**: Analyze art auction data to identify trends and help guide editorial content for future publications.

**Analysis Questions**: The stakeholders and team brainstormed a few possible questions to help find trends within the data.
- What genres/mediums of art has been rising within the past few years?
- What regions have been identified as highest revenue for art auction transactions?
- Is there a correlation between different auction houses and revenue?

For this case study, we'll touch on each question to give an overall idea for further actions.

## Step 2: Prepare
### Data Source
As mentioned before, the data source is from the art auction dataset collected by *Kangsan Lee et al.*. The [paper](https://www.nature.com/articles/s41598-024-60957-z) includes a link to the [data source](https://springernature.figshare.com/articles/dataset/Buying_a_Work_of_Art_or_an_Artist_Exploring_the_Impact_of_Visual_and_Social_Features_on_Art_Prices/24746268) that contains 9 files. One of which includes the *transactions.csv* which will be the focus of this analysis.

This is a public data source that includes 34200 records of art auctions which contains market information about the artworks, artists, and regions of where the art originated. This includes around 590 artists and data about the pieces ranging from 1996-2012. There is also information about the ages of the artwork, prices, and art auction houses of where the pieces are sold.

### Considerations/Limitations
While the data is comprehensive in listing out key features of the art auction dataset, it should be noted that there are some considerations when interpreting the results:
- This dataset only considers artists that are currently alive and within the top 1000 according to [ArtFacts.net](https://artfacts.net/). As such, having a comprehensive table would only be limited to living artists and well-known to the general public.
- The data only ranges from 1996-2012 so the data may not be current and is only within this time range.
- When imported to a spreadsheet, some values are not necessarily numerical/or contains errors. One notable example includes how the table for the price_usd in USD also contains '.' values instead of N/A or 0.
- In addition to artists that are well known, this dataset also excludes information about artists without a biography or public information about their careers.
- One of the columns did contain links to images but since our analysis is mostly featured on identifying trends and patterns in numerical/categorical data, that column was deleted to be consistent.
- Column names did not initially follow the proper formatting guidelines so some time would be spent to ensure formatting issues will be taken care of.

## Step 3: Process

