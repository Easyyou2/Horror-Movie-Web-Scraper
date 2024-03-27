
library(rvest)
library(dplyr)

# The URL of the webpage to scrape
url <- "https://editorial.rottentomatoes.com/guide/best-horror-movies-of-all-time/"

# Read the webpage content
page <- read_html(url)

# Use the CSS selectors to extract titles, ratings, and years
Titles <- page %>% html_nodes('.article_movie_title a') %>% html_text(trim = TRUE)
Rating <- page %>% html_nodes('.tMeterScore') %>% html_text(trim = TRUE)
Year <- page %>% html_nodes('.start-year') %>% html_text(trim = TRUE)

# For directors, since there might be multiple directors for a single movie,
# you'll concatenate them into a single string for each movie.
movies <- page %>% html_nodes('.article_movie_title')  # Assuming each movie is contained within this node
Directors <- sapply(movies, function(movie) {
  # Find director nodes relative to the movie node
  director_nodes <- html_nodes(movie, xpath = ".//following-sibling::div[contains(@class, 'info director')]//a")
  directors_list <- html_text(director_nodes)
  
  # Concatenate all directors into a single string with comma separation
  paste(directors_list, collapse = ", ")
})

# Combine the data into a data frame
movie_data <- data.frame(Title = Titles, Year = Year, Rating = Rating, Director = Directors, stringsAsFactors = FALSE)