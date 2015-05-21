# Q4
# Across the United States, how have emissions from coal
# combustion-related sources changed from 1999-2008?

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

# Search through merged data for "coal" related items
# Group by year and sum all emissions
coalData <- MERGED %>% 
    filter(grepl("coal", Short.Name, ignore.case=TRUE)) %>%
    group_by(year) %>%
    summarize(Emissions = sum(Emissions, na.rm=TRUE))

# Open PNG device
png(filename="plot4.png", 
    width = 480, 
    height = 480,
    units = "px")

# Make ggplot
# geom_bar makes it a bar plot
# the rest is just labels
g <- ggplot(coalData, aes(x=factor(year), y=Emissions/10^3)) +
    geom_bar(stat="identity") +
    ggtitle("Coal Emissions PM2.5 Emissions by Year") +
    xlab("Year") +
    ylab("Emissions (in thousands of tons) 10^3")

print(g)

# Save plot to PNG file and turn device off
dev.off()