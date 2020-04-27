# Librerias ----
library(tidyverse)

# Lectura de datos ----
office_ratings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-17/office_ratings.csv')
office_ratings

# Repaso practica 1 ----
# Rating prom por temporada
summarise(group_by(office_ratings, season),promedio_rating = mean(imdb_rating))
# Rating prom por temporada, opening date, closing date y duracion de temporada 
mutate(summarise(group_by(office_ratings, season),
          promedio_rating = mean(imdb_rating),
          opening_date = min(air_date),
          closing_date = max(air_date)),
       dias_duracion = closing_date-opening_date)

# ggplot() ----
frame <- (mutate(summarise(group_by(office_ratings, season),
                       promedio_rating = mean(imdb_rating),
                       opening_date = min(air_date),
                       closing_date = max(air_date)),
             dias_duracion = closing_date-opening_date))
ggplot(frame, aes(x=season,y=dias_duracion)) + geom_col()

# The pipe %>%----
office_ratings%>% 
  group_by(season) %>% 
  summarise(promedio_rating = mean(imdb_rating),
            opening_date = min(air_date),
            closing_date = max(air_date)) %>% 
  mutate(dias_duracion = closing_date-opening_date) %>% 
  filter(dias_duracion > mean(dias_duracion)) %>% 
  ggplot(aes(x=season,y=dias_duracion)) + geom_col()

# arrange() ----
# Ordenamos por una variable
office_ratings %>% 
  arrange(imdb_rating)

office_ratings %>% 
  arrange(desc(imdb_rating)) %>% 
  view()


# NUEVOS DATOS ----
# Carga y lectura 
install.packages('schrute')
library(schrute)

schrute::theoffice %>% view()

# Hipotesis: hay relacion entre una broma y la popularidad del episodio
theoffice %>% 
  mutate(text = str_to_lower(text)) %>% 
  filter(str_detect(text,"that's what she said")|str_detect(text,"that's what he said")) %>% 
  group_by(season,character) %>% 
  summarise(n=n())
