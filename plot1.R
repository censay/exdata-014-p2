# Q1
# Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? Using the base plotting system, make a plot
# showing the total PM2.5 emission from all sources for each of 
# the years 1999, 2002, 2005, and 2008.
# Upload a PNG file containing your plot addressing this question.

# Import data from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load dplyr package for faster number crunching (x20)
library(dplyr)

# Group by year and sum all emissions by year
sumNEI <- NEI %>% 
        group_by(year) %>%
        summarize(Emissions = sum(Emissions, na.rm=TRUE))

# Open PNG device
png(filename="plot1.png", 
    width = 480, 
    height = 480,
    units = "px")

# Plot divided by millions
barplot(sumNEI$Emissions/10^6, 
            xlab = "Year", 
            ylab = "Total Emissions (in millions of tons) 10^6",
            names.arg = sumNEI$year,
            main = "Total PM2.5 Emissions by Year (1999-2008)")

# Save plot to PNG file and turn device off
dev.off()