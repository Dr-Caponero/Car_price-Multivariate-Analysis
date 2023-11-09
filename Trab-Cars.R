library(ggplot2)
library(dplyr)
library(tidyverse)

dados = CarPrice_Assignment

head(dados)

dados$aspiration[dados$aspiration == "std"] = "padrão"

dados$carbody[dados$carbody == "sedan"] = "sedã"
dados$carbody[dados$carbody == "convertible"] = "convercível"
dados$carbody[dados$carbody == "wagon"] = "perua"

dados$cylindernumber[dados$cylindernumber == "two"] = "2"
dados$cylindernumber[dados$cylindernumber == "three"] = "3"
dados$cylindernumber[dados$cylindernumber == "four"] = "4"
dados$cylindernumber[dados$cylindernumber == "five"] = "5"
dados$cylindernumber[dados$cylindernumber == "six"] = "6"
dados$cylindernumber[dados$cylindernumber == "eight"] = "8"
dados$cylindernumber[dados$cylindernumber == "twelve"] = "12"

dados$doornumber[dados$doornumber == "two"] = "2"
dados$doornumber[dados$doornumber == "four"] = "4"

dados$enginelocation[dados$enginelocation == "front"] = "frente"
dados$enginelocation[dados$enginelocation == "rear"] = "traseira"

dados$fuelsystem[dados$fuelsystem == "gas"] = "gás"

dados %>% pivot_longer(cols = colnames(dados)[c(4,5,6,7,8,9,15,16,18)],
                       names_to = "Var",
                       values_to = "medida")|>
  dplyr::select(Var, medida) |>
  group_by(Var,medida)%>%
  summarise(quantidade = n()) |>
  ggplot(aes(x = medida, y = quantidade )) +
  geom_col(fill = "#3680b6")+
  geom_text(aes(label = quantidade), vjust = 0)+
  facet_wrap(vars(Var), ncol = 3, scales = "free")+
  labs(x = " ", y = " ")+
  #geom_text(position = position_stack(vjust = .5), color = "#FFFFFF")+
  theme_light()+
  theme(strip.text.x = element_text(colour = "black"))