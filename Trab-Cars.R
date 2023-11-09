library(tidyverse)

dados <- read_csv("CarPrice_Assignment.csv")

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


# separando a marca do nome do carro
aux <- str_split(dados$CarName, " ", n = 2)
aux1 <- NULL
aux2 <- NULL
for(i in 1:205){
  aux1[i] <- aux[[i]][1]
  aux2[i] <- aux[[i]][2]
}

dados$marca <- aux1
dados$nome <- aux2

# Corrigindo corrigindo a marca de alguns carros

# maxda = mazda
aux <- dados |> dplyr::filter(marca=="maxda") |> mutate(marca="mazda")
dados <- dados |> dplyr::filter(marca!="maxda")
dados <- rbind(dados,aux)
# Nissan = nissan
aux <- dados |>  dplyr::filter(marca=="Nissan") |> mutate(marca="nissan")
dados <- dados |> dplyr::filter(marca!="Nissan")
dados <- rbind(dados,aux)
# porsche = porcshce
dados |> dplyr::filter(marca=="porcshce") |> mutate(marca="porsche")
dados <- dados |> dplyr::filter(marca!="porcshce")
dados <- rbind(dados,aux)
# toyota = toyouta
aux <- dados |> dplyr::filter(marca=="toyouta") |> mutate(marca="toyota")
dados <- dados |> dplyr::filter(marca!="toyouta")
dados <- rbind(dados,aux)
# vokswagen = volkswagen = vw
aux <- dados |> dplyr::filter(marca=="vokswagen") |> mutate(marca="vw")
dados <- dados |> dplyr::filter(marca!="vokswagen")
dados <- rbind(dados,aux)
aux <- dados |> dplyr::filter(marca=="volkswagen") |> mutate(marca="vw")
dados <- dados |> dplyr::filter(marca!="volkswagen")
dados <- rbind(dados,aux)


