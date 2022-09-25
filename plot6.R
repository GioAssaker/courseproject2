dir.create("./air_pollution")
urlzip <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(urlzip, destfile = "./air_pollution.zip" )
unzip("./air_pollution.zip", exdir = "./air_pollution" )
NEI <- readRDS("./air_pollution/summarySCC_PM25.rds")
SCC <- readRDS("./air_pollution/Source_Classification_Code.rds")
str(NEI)
str(SCC)
baltLosAngelesMotors <- subset(NEI, NEI$fips %in% c("24510","06037") & NEI$type == "ON-ROAD")
baltLosAngelesMotorsAGG <- aggregate(Emissions ~ year + fips, baltLosAngelesMotors, sum)
ggplot(baltLosAngelesMotorsAGG, aes(year, Emissions, col = fips)) +
      geom_line() +
      geom_point() +
      ggtitle(expression("Baltimore and Los Angeles" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
      labs(x = "Year", y = expression(~PM[2.5]~ "Motor Vehicle Emissions") ) +
      scale_colour_discrete(name = "City", labels = c("Los Angeles", "Baltimore")) +
      theme(legend.title = element_text(face = "bold"))
