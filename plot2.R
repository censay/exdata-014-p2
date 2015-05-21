# Q2
# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == 24510) from 1999 to 2008? Use the base plotting 
# system to make a plot answering this question.
# Upload a PNG file containing your plot addressing this question.


# Import data from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load dplyr package for faster number crunching (x20)
library(dplyr)

# Filter by fips=="24510" (Baltimore City)
# Group by year and sum all emissions by year
baltimoreEmissions <- NEI %>% 
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarize(Emissions = sum(Emissions, na.rm=TRUE))

# Open PNG device
png(filename="plot2.png", 
    width = 480, 
    height = 480,
    units = "px")

# Plot Baltimore City Total Emissions
barplot(baltimoreEmissions$Emissions, 
        xlab = "Year", 
        ylab = "Baltimore City Total Emissions (Tons)",
        names.arg = baltimoreEmissions$year,
        main = "Baltimore City Total PM2.5 Emissions by Year (1999-2008)")

# Save plot to PNG file and turn device off
dev.off()