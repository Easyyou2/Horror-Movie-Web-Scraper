library(rvest)
library(dplyr)

# The URL of the webpage to scrape
url <- "http://www.sfu.ca/~haoluns/forecast.html"

# Read the webpage content
page <- read_html(url)

# Use the CSS selectors to extract period, descriptions, and temperatures
periods <- page %>% html_nodes('.period-name') %>% html_text(trim = TRUE)
descriptions <- page %>% html_nodes('.short-desc') %>% html_text(trim = TRUE)
temps <- page %>% html_nodes('.temp') %>% html_text(trim = TRUE)

# Combine the data into a data frame
weather_data <- data.frame(period = periods, short_desc = descriptions, temp = temps)


# Save the data frame to a CSV file
write.csv(weather_data, '301548882.csv',sep = ",", row.names = FALSE, quote = FALSE)


