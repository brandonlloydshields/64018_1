#Install packages 

#If packages below have already been installed, running the script yields a circular error from R about updating loaded packages. 
#Responding with Yes or No has led to aborted sessions in R. Hitting cancel will not run script. 
#If already installed, only run script after "Load Packages". 
#This will provide summary output in console and geenrate a plot via ggplot2. 

install.packages("ggplot2")
install.packages("dplyr")
install.packages("tidyr")
install.packages("httr")
install.packages("RCurl")

#Load Packages
library(ggplot2)
library(dplyr)
library(tidyr)
library(httr)
library(RCurl)


#Read files

gdppc <- read.csv(text = getURL("https://raw.githubusercontent.com/brandonlloydshields/64018_1/master/WB_GDP_PC.csv"))
co2pc <- read.csv(text = getURL("https://raw.githubusercontent.com/brandonlloydshields/64018_1/master/WB_CO2_Emissions.csv"))
region <- read.csv(text = getURL("https://raw.githubusercontent.com/brandonlloydshields/64018_1/master/Region_Code.csv"))

#Making data sets tidy

co2pc.edit <- select(co2pc, -X2015:-X2018)
co2pc.edit2 <- gather(co2pc.edit,Year, CO2_per_capita,X1960:X2014)
co2pc.edit3 <- separate(co2pc.edit2,Year,c("X","Year"), sep = 1)
co2pc.edit3 <- select(co2pc.edit3, -c("X","Indicator.Name", "Country.Name", "Indicator.Code"))

gdppc.edit <- gather(gdppc, Year, GDP_Per_Capita,X1960:X2018)
gdppc.edit2 <- separate(gdppc.edit,Year, c("X", "Year"), sep = 1)
gdppc.edit2 <- select(gdppc.edit2, -c("X", "Indicator.Name", "Indicator.Code"))

region <- rename(region, Country.Code = wdi_code, Region = region)
region.edit <- select(region, -c("X":"X.6"))

#Merge data sets
                        
gdpppc_co2pc <- left_join(gdppc.edit2,co2pc.edit3,by =c("Country.Code","Year"))
final <- inner_join(gdpppc_co2pc, region.edit, by = c("Country.Code"))

final.2014 <- subset(final, Year == 2014)

#Print(summary)

print(summary(final.2014))

#Graphing 

plot1 <- ggplot(final.2014, aes(GDP_Per_Capita, CO2_per_capita))
plot2 <- plot1 + geom_point(aes(color = Region), shape = 16, size = 3)
plot3 <- plot2 + labs(title = "Relationship between GDP per capita and CO2 emissions per capita in 2014", x = "GDP per capita ( in U.S. dollars)", y = "Metric tons of CO2 emissions per capita") + theme_bw()
print(plot3)


