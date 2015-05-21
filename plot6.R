# Q6
# Compare emissions from motor vehicle sources in Baltimore City
# (fips == "24510") with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == 06037). Which city has 
# seen greater changes over time in motor vehicle emissions?

Upload a PNG file containing your plot addressing this question.

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
# Filter by Baltimore City (fips == "24510")
# Group by year and sum all emissions
baData <- MERGED %>% 
    filter(grepl("vehicle", SCC.Level.Two, ignore.case=TRUE)) %>%
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarize(Emissions = sum(Emissions, na.rm=TRUE))

# Search through merged data for "vehicle" related items
# Filter by LA County (fips == "06037")
# Group by year and sum all emissions
laData <- MERGED %>% 
    filter(grepl("vehicle", SCC.Level.Two, ignore.case=TRUE)) %>%
    filter(fips == "06037") %>%
    group_by(year) %>%
    summarize(Emissions = sum(Emissions, na.rm=TRUE))

# Add city labels to each dataset
baData$city <- "Baltimore City"
laData$city <- "Los Angeles County"

# Combine the tail of two cities
twocityData <- rbind(baData,laData)

# Open PNG device
png(filename="plot6.png", 
    width = 680, 
    height = 480,
    units = "px")

# Make ggplot
# "Fill=" gives seperate colors to each facet based on city
# geom_bar makes it a bar plot
# facet_grid seperates in to four plots based off city
# the rest is just labels
g <- ggplot(twocityData, aes(x=factor(year), y=Emissions, fill=city)) +
    geom_bar(stat="identity") +
    facet_grid(.~city) +
    ggtitle("PM2.5 Emissions by Year (Baltimore vs. LA)") +
    xlab("Year") +
    ylab("Emissions (by Tons)")

print(g)

# Save plot to PNG file and turn device off
dev.off()