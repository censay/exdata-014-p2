# Q5
# How have emissions from motor vehicle sources changed from 
# 1999-2008 in Baltimore City?
# Upload a PNG file containing your plot addressing this question.

# Import data from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load dplyr package for faster number crunching (x20)
# Load ggplot2 for plotting
library(dplyr)
library(ggplot2)

# Merge NEI and SCC
# WARNING - THIS WILL TAKE A MINUTE OR TWO
MERGED <- inner_join(NEI, SCC, by="SCC")

# Search through merged data for "vehicle" related items
# Filter by Baltimore City (fips=="24510")
# Group by year and sum all emissions
vehicleData <- MERGED %>% 
    filter(grepl("vehicle", SCC.Level.Two, ignore.case=TRUE)) %>%
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarize(Emissions = sum(Emissions, na.rm=TRUE))

# Open PNG device
png(filename="plot5.png", 
    width = 480, 
    height = 480,
    units = "px")

# Make ggplot
# geom_bar makes it a bar plot
# the rest is just labels
g <- ggplot(vehicleData, aes(x=factor(year), y=Emissions)) +
    geom_bar(stat="identity") +
    ggtitle("Vehicle PM2.5 Emissions in Baltimore City by Year") +
    xlab("Year") +
    ylab("Emissions (tons)")

print(g)

# Save plot to PNG file and turn device off
dev.off()