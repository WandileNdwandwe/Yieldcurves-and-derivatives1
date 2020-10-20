library(tidyverse)
library(readr)

Yieldcurves <- read.csv("~/R/SeptQB.csv", header=T)
View(Yieldcurves) 

#changing the column names
names (Yieldcurves) <- c("Period","YC", "bps", "23-03-2020", "08-07-2020", "11-09-2020", "03-06-2020")

#combining columns
Yieldcurves <- gather(Yieldcurves, "23-03-2020", "08-07-2020", "11-09-2020", "03-06-2020",
                      key = "YC",
                      value = "bps")

summary(Yieldcurves)

#creating yield curve plots
ggplot(data=Yieldcurves, aes(x = Period, y = bps, color=YC)) +
  geom_line(size=1.2) +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 0, hjust = 1),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        plot.caption = element_text(hjust=0)) +
  ggtitle("Yield curves",subtitle = "Per cent: Unexpired maturity in years") +
  labs(caption = "Sources: IRESS and JSE") +
ggsave("Yieldcurves_sept.png")

library(readr)
Derivatives <- read_csv("~/R/Derivatives.csv")

#creating derivative plots
ggplot(data=Derivatives) +
  geom_line(aes(x = Date, y = Rand_per_ton, color = Commodity), size=1.2) +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 0, hjust = 1),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        plot.caption = element_text(hjust=0)) +
  ggtitle("Monthly derivatives",subtitle = "Rand per ton") +
  labs(caption = "Source: JSE")

#separate commodities into columns to be able to run means and standard deviations  
Deriv2 <- separate(Derivatives, c("White_Maize", "Yellow_Maize", "Wheat", "Sunflower_seed")) 
