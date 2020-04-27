# Libraries ---- 
library(readr)
library(dplyr)
library(tibble)


# Import Data ----
office_ratings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-17/office_ratings.csv')
office_ratings
glimpse(office_ratings)

# Interfaz de manejo de datos para ver estadísticas ----

# ############ Trabajo sobre columnas ----
# Provenientes de dplyr ----
# select() ----
select(office_ratings, season, episode, total_votes)
select(office_ratings, contains('e'))
select(office_ratings, starts_with('t'))

# guardar ----
write_csv(office_ratings,'Desktop/nuevaBD.csv')

# rename() ----
rename(office_ratings, 'Temporada' = season)
rename(office_ratings,
       'Temporada' = season,
       'titulo' = title)

# mutate() ----
mutate(office_ratings, 
       temporada_mas_uno = season+1,
       imdb_nuevo = imdb_rating*10,
       prom = mean(imdb_rating),
       minimo = min(imdb_rating))


# ############ Trabajo sobre filas ----
# filter() ----
filter(office_ratings,season == 1,imdb_rating > 8)
filter(office_ratings,season == 1|imdb_rating > 8)
filter(office_ratings,season != 1 & imdb_rating > 8 | imdb_rating < 7.5)

# summarise() ----
summarise(office_ratings, 
          prom=mean(imdb_rating),
          sd = sd(imdb_rating),
          max = max(imdb_rating),
          min = min(imdb_rating),
          q25 = quantile(imdb_rating, probs=0.25))

# group_by() ----
# Agrupacion a una columna
group_by(office_ratings, season)
summarise(group_by(office_ratings,season),prom=mean(imdb_rating))
# Agrupacion a multiples columnas
office_ratings %>%
  mutate(meses = lubridate::month(air_date))%>%
  group_by(season, meses)%>%
  summarise(prom = mean(imdb_rating),
            n)

# Countdown ----
```{r}
countdown::countdown(minutes = 1, seconds = 42)
```
