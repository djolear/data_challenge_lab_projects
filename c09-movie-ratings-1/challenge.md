Movie ratings - Part 1
================
Your Name
2018-

-   [Data](#data)
    -   [Movies](#movies)
    -   [Ratings](#ratings)
    -   [Reviewers](#reviewers)
-   [Directions](#directions)
-   [Questions](#questions)

``` r
# Libraries
library(tidyverse)
library(compare)
library(knitr)

# Parameters
  # Data files for movies, ratings, and reviewers
file_movie <- "../../data/movie-ratings/data/movie.rds"
file_rating <- "../../data/movie-ratings/data/rating.rds"
file_reviewer <- "../../data/movie-ratings/data/reviewer.rds"
  # File for answers
file_answers <- "../../data/movie-ratings/answers_1.rds"

#===============================================================================

# Read in data
movie <- read_rds(file_movie)
rating <- read_rds(file_rating)
reviewer <- read_rds(file_reviewer)

# Read in answers
answers <- read_rds(file_answers)
```

For this challenge you will wrangle data from three toy datasets about movies, movie ratings, and reviewers. The data and the questions were adapted from the [SQL Movie-Rating Query Exercises](https://lagunita.stanford.edu/courses/DB/SQL/SelfPaced/courseware/ch-sql/seq-exercise-sql_movie_query_core/), which are a part of the Stanford Online course Databases: DB5 SQL.

Data
----

### Movies

``` r
movie %>% kable()
```

|  movie\_id| title                   |  year| director         |
|----------:|:------------------------|-----:|:-----------------|
|        101| Gone with the Wind      |  1939| Victor Fleming   |
|        102| Star Wars               |  1977| George Lucas     |
|        103| The Sound of Music      |  1965| Robert Wise      |
|        104| E.T.                    |  1982| Steven Spielberg |
|        105| Titanic                 |  1997| James Cameron    |
|        106| Snow White              |  1937| NA               |
|        107| Avatar                  |  2009| James Cameron    |
|        108| Raiders of the Lost Ark |  1981| Steven Spielberg |

### Ratings

``` r
rating %>% kable()
```

|  reviewer\_id|  movie\_id|  stars| rating\_date |
|-------------:|----------:|------:|:-------------|
|           201|        101|      2| 2011-01-22   |
|           201|        101|      4| 2011-01-27   |
|           202|        106|      4| NA           |
|           203|        103|      2| 2011-01-20   |
|           203|        108|      4| 2011-01-12   |
|           203|        108|      2| 2011-01-30   |
|           204|        101|      3| 2011-01-09   |
|           205|        103|      3| 2011-01-27   |
|           205|        104|      2| 2011-01-22   |
|           205|        108|      4| NA           |
|           206|        107|      3| 2011-01-15   |
|           206|        106|      5| 2011-01-19   |
|           207|        107|      5| 2011-01-20   |
|           208|        104|      3| 2011-01-02   |

### Reviewers

``` r
reviewer %>% kable()
```

|  reviewer\_id| name             |
|-------------:|:-----------------|
|           201| Sarah Martinez   |
|           202| Daniel Lewis     |
|           203| Brittany Harris  |
|           204| Mike Anderson    |
|           205| Chris Jackson    |
|           206| Elizabeth Thomas |
|           207| James Cameron    |
|           208| Ashley White     |

Directions
----------

For each question below, store your result in a variable with the same name as the question. For example, for question q1 store your result in the variable `q1`. This challenge comes with answers. Each chunk has code to compare your result with the answer. If your result matches the answer, it will return `TRUE`.

Questions
---------

q1 Find the titles of all movies directed by Steven Spielberg.

``` r
q1 <-
  movie %>%
  filter(director == "Steven Spielberg") %>%
  select(title)

# Print results
if (exists("q1")) q1 %>% kable()
```

| title                   |
|:------------------------|
| E.T.                    |
| Raiders of the Lost Ark |

``` r
# Compare result with answer
if (exists("q1")) compare(answers$q1, q1)
```

    ## TRUE

q2 Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.

``` r
q2 <-
  movie %>%
  left_join(rating, by = "movie_id") %>%
  filter(stars > 3) %>%
  arrange(stars) %>%
  distinct(year) %>%
  select(year) %>%
  arrange(year)

# Print results
if (exists("q2")) q2 %>% kable()
```

|  year|
|-----:|
|  1937|
|  1939|
|  1981|
|  2009|

``` r
# Compare result with answer
if (exists("q2")) compare(answers$q2, q2)
```

    ## TRUE

q3 Find the titles of all movies that have no ratings.

``` r
q3 <-
  movie %>%
  left_join(rating, by = "movie_id") %>%
  filter(is.na(stars)) %>%
  select(title) %>%
  arrange(title)


# Print results
if (exists("q3")) q3 %>% kable()
```

| title     |
|:----------|
| Star Wars |
| Titanic   |

``` r
# Compare result with answer
if (exists("q3")) compare(answers$q3, q3)
```

    ## TRUE

q4 Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NA value for the date.

``` r
q4 <-
  rating %>%
  left_join(reviewer, by = "reviewer_id") %>% 
  filter(is.na(rating_date)) %>%
  select(name) %>%
  arrange(name)

# Print results
if (exists("q4")) q4 %>% kable()
```

| name          |
|:--------------|
| Chris Jackson |
| Daniel Lewis  |

``` r
# Compare result with answer
if (exists("q4")) compare(answers$q4, q4)
```

    ## TRUE

q5 Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and rating\_date. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.

``` r
q5 <- 
  movie %>% 
  full_join(rating, by = "movie_id") %>%
  full_join(reviewer, by = "reviewer_id") %>%
  select(name, title, stars, rating_date) %>%
  arrange(name, title, stars)

# Print results
if (exists("q5")) q5 %>% kable()
```

| name             | title                   |  stars| rating\_date |
|:-----------------|:------------------------|------:|:-------------|
| Ashley White     | E.T.                    |      3| 2011-01-02   |
| Brittany Harris  | Raiders of the Lost Ark |      2| 2011-01-30   |
| Brittany Harris  | Raiders of the Lost Ark |      4| 2011-01-12   |
| Brittany Harris  | The Sound of Music      |      2| 2011-01-20   |
| Chris Jackson    | E.T.                    |      2| 2011-01-22   |
| Chris Jackson    | Raiders of the Lost Ark |      4| NA           |
| Chris Jackson    | The Sound of Music      |      3| 2011-01-27   |
| Daniel Lewis     | Snow White              |      4| NA           |
| Elizabeth Thomas | Avatar                  |      3| 2011-01-15   |
| Elizabeth Thomas | Snow White              |      5| 2011-01-19   |
| James Cameron    | Avatar                  |      5| 2011-01-20   |
| Mike Anderson    | Gone with the Wind      |      3| 2011-01-09   |
| Sarah Martinez   | Gone with the Wind      |      2| 2011-01-22   |
| Sarah Martinez   | Gone with the Wind      |      4| 2011-01-27   |
| NA               | Star Wars               |     NA| NA           |
| NA               | Titanic                 |     NA| NA           |

``` r
# Compare result with answer
if (exists("q5")) identical(answers$q5, q5)
```

    ## [1] TRUE

q6 For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.

``` r
q6 <-
  rating %>%
  left_join(reviewer, by = "reviewer_id") %>%
  group_by(reviewer_id, movie_id) %>%
  count() %>%
  filter(n > 1) %>%
  left_join(movie, by = "movie_id") %>%
  left_join(rating, by = c("movie_id", "reviewer_id")) %>%
  ungroup() %>%
  select(reviewer_id, title, rating_date, stars) %>%
  group_by(reviewer_id) %>%
  mutate(rating_date = if_else(rating_date == min(rating_date), "rating_1", "rating_2")) %>%
  spread(rating_date, stars) %>%
  mutate(criteria = if_else(rating_2 > rating_1, 1, 0)) %>%
  filter(criteria == 1) %>%
  select(reviewer_id, title) %>%
  left_join(reviewer, by = "reviewer_id") %>%
  ungroup() %>%
  select(name, title)

# Print results
if (exists("q6")) q6 %>% kable()
```

| name           | title              |
|:---------------|:-------------------|
| Sarah Martinez | Gone with the Wind |

``` r
# Compare result with answer
if (exists("q6")) identical(answers$q6, q6)
```

    ## [1] TRUE

q7 For each movie that has at least one rating, return the movie title and the highest number of stars that movie received. Sort by movie title.

``` r
q7 <- 
  movie %>%
  left_join(rating, by = "movie_id") %>%
  filter(!is.na(stars)) %>%
  group_by(title) %>%
  top_n(1, stars) %>%
  select(title, stars) %>%
  distinct(title, stars) %>%
  arrange(title) %>%
  mutate(stars = as.double(stars)) %>%
  ungroup()

# Print results
if (exists("q7")) q7 %>% kable()
```

| title                   |  stars|
|:------------------------|------:|
| Avatar                  |      5|
| E.T.                    |      3|
| Gone with the Wind      |      4|
| Raiders of the Lost Ark |      4|
| Snow White              |      5|
| The Sound of Music      |      3|

``` r
# Compare result with answer
if (exists("q7")) identical(answers$q7, q7)
```

    ## [1] TRUE

q8 For each movie, return the title and the "rating spread", that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title.

``` r
q8 <-
  movie %>%
  left_join(rating, by = "movie_id") %>%
  group_by(title) %>%
  mutate(rating_spread = max(stars) - min(stars)) %>%
  select(title, rating_spread) %>%
  distinct(title, rating_spread) %>%
  filter(!is.na(rating_spread)) %>%
  arrange(desc(rating_spread), title) %>%
  ungroup()

# Print results
if (exists("q8")) q8 %>% kable()
```

| title                   |  rating\_spread|
|:------------------------|---------------:|
| Avatar                  |               2|
| Gone with the Wind      |               2|
| Raiders of the Lost Ark |               2|
| E.T.                    |               1|
| Snow White              |               1|
| The Sound of Music      |               1|

``` r
# Compare result with answer
if (exists("q8")) identical(answers$q8, q8)
```

    ## [1] TRUE

q9 Find the difference between the average rating of movies released before 1980 and the average rating of movies released in 1980 and later. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)

``` r
q9 <-
  movie %>%
  left_join(rating, by = "movie_id") %>%
  group_by(title) %>%
  mutate(mov_avg = mean(stars, na.rm = T)) %>%
  filter(!is.na(mov_avg)) %>%
  distinct(title, year, mov_avg) %>%
  ungroup() %>%
  group_by(year > 1980) %>%
  mutate(year_avg = mean(mov_avg)) %>%
  select(bef_1980 = "year > 1980", year_avg) %>%
  distinct(year_avg) %>%
  spread(bef_1980, year_avg) %>%
  select(a = "FALSE", b = "TRUE") %>%
  transmute(mean_rating_difference = a - b)
  

# Print results
if (exists("q9")) q9 %>% kable()
```

|  mean\_rating\_difference|
|-------------------------:|
|                 0.0555556|

``` r
# Compare result with answer
if (exists("q9")) compare(answers$q9, q9)
```

    ## TRUE
