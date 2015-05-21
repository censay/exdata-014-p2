# Q3
# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which 
# of these four sources have seen decreases in emissions 
# from 1999-2008 for Baltimore City? Which have seen increases
# in emissions from 1999-2008? Use the ggplot2 plotting system 
# to make a plot answer this question.
# Upload a PNG file containing your plot addressing this question.

# Import data from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load dplyr package for faster number crunching (x20)
# Load ggplot2 for plotting
library(dplyr)
library(ggplot2)

# Filter by fips=="24510" (Baltimore City)
# Group by type and year and sum all emissions
baltimoreByType <- NEI %>% 
    filter(fips == "24510") %>%
    group_by(type,year) %>%
    summarize(Emissions = sum(Emissions, na.rm=TRUE))

# Open PNG device
png(filename="plot3.png", 
    width = 680, 
    height = 480,
    units = "px")

# Make ggplot
# "Fill=" gives seperate colors to each facet based on type
# geom_bar makes it a bar plot
# facet_grid seperates in to four plots based off type
# the rest is just labels
g <- ggplot(baltimoreByType, aes(x=factor(year), y=Emissions, fill=type)) +
        geom_bar(stat="identity") +
        facet_grid(.~type) +
        ggtitle("Baltimore City PM2.5 Emissions by Type") +
        xlab("Year") +
        ylab("Emissions (by Tons)")

print(g)

# Save plot to PNG file and turn device off
dev.off()