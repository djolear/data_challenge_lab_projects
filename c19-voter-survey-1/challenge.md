VOTER Survey - Part 1
================
Daniel
2018-02-15

-   [Derived variables](#derived-variables)
-   [Data](#data)
    -   [Recode variables](#recode-variables)
    -   [Calculate derived variables](#calculate-derived-variables)
    -   [Information about voter and how they voted](#information-about-voter-and-how-they-voted)

``` r
# Libraries
library(tidyverse)
library(compare)

# Parameters
  # File for answers
file_answers <- "../../data/voter-survey/answers_1.rds"
survey_csv <- "C:/Users/djole/Google Drive/classes/dcl/c18/VOTER_Survey_December16_Release1.csv"
survey_dta <- "C:/Users/djole/Google Drive/classes/dcl/c18/VOTER_Survey_December16_Release1.dta"
  # Variable recode functions

recode_rescale <- function(x, ...) {
  recode(x, ...) %>% 
    scales::rescale(to = c(-1, 1))
}

recode_01 <- function(x)
  recode_rescale(
    x,
    "Strongly agree"    = 1,
    "Agree"             = 2,
    "Disagree"          = 3,
    "Strongly disagree" = 4
  )

recode_02 <- function(x)
  recode_rescale(
    x,
    "Very important"     = 1,
    "Somewhat important" = 2,
    "Not very important" = 3,
    "Unimportant"        = 4
  )

recode_03 <- function(x)
  recode_rescale(
    x,
    "Decrease"  = 1,
    "No impact" = 2,
    "Increase"  = 3
  )

recode_04 <- function(x)
  recode_rescale(
    x,
    "Increase"  = 1,
    "No impact" = 2,
    "Decrease"  = 3
  )

recode_05 <- function(x)
  recode_rescale(
    x,
    "Strongly Disagree" = 1,
    "Somewhat Disagree" = 2,
    "Somewhat Agree"    = 3,
    "Strongly Agree"    = 4
  )

recode_06 <- function(x)
  recode_rescale(
    x,
    "Strongly Agree"    = 1,
    "Somewhat Agree"    = 2,
    "Somewhat Disagree" = 3,
    "Strongly Disagree" = 4
  )

recode_07 <- function(x)
  recode_rescale(
    x,
    "Disagree strongly" = 1,
    "Disagree"          = 2,
    "Agree"             = 3,
    "Agree strongly"    = 4,
    "Don't know"        = NULL
  )

recode_08 <- function(x)
  recode_rescale(
    x,
    "Not proud at all" = 1,
    "Not very proud"   = 2,
    "Somewhat proud"   = 3,
    "Very proud"       = 4,
    "Don't know"       = NULL
  )

recode_09 <- function(x)
  recode_rescale(
    x,
    "Better"         = 1,
    "About the same" = 2,
    "Worse"          = 3,
    "Don't know"     = NULL
  ) 

recode_10 <- function(x)
  recode_rescale(
    x,
    "Generally becoming more widespread and accepted" = 1,
    "Holding steady"                                  = 2,
    "Generally becoming rarer and less accepted"      = 3,
    "Don't know"                                      = NULL
  )

recode_11 <- function(x)
  recode_rescale(
    x,
    "Strongly Agree"    = 1,
    "Agree"             = 2,
    "Disagree"          = 3,
    "Strongly Disagree" = 4,
    "Don't Know"        = NULL
  )

recode_12 <- function(x)
  recode_rescale(
    x,
    "Strongly Disagree" = 1,
    "Disagree"          = 2,
    "Agree"             = 3,
    "Strongly Agree"    = 4,
    "Don't Know"        = NULL
  )

recode_13 <- function(x)
  recode_rescale(
    x,
    "Favor whites over blacks"   = 1,
    "Treat both groups the same" = 2,
    "Favor blacks over whites"   = 3,
    "Don't know"                 = NULL
  )

recode_14 <- function(x)
  recode_rescale(
    x,
    "Not important at all" = 1,
    "Not very important"   = 2,
    "Fairly important"     = 3,
    "Very important"       = 4,
    "Don't know"           = NULL
  )

recode_15 <- function(x)
  recode_rescale(
    x,
    "Strongly oppose" = 1,
    "Somewhat oppose" = 2,
    "Somewhat favor"  = 3,
    "Strongly favor"  = 4,
    "Don't know"      = NULL
  )

recode_16 <- function(x) {
  x %>% 
    str_extract("^\\d+") %>% 
    as.integer() %>% 
    ifelse(. > 100, NA, .) %>% 
    scales::rescale(to = c(1, -1))
}

recode_17 <- function(x)
  recode_rescale(
    x,
    "Mostly make a contribution" = 1,
    "Neither"                    = 2,
    "Mostly a drain"             = 3,
    "Don't know"                 = NULL
  )

recode_18 <- function(x)
  recode_rescale(
    x,
    "Favor"      = 1,
    "Oppose"     = 2,
    "Don't know" = NULL
  )

recode_19 <- function(x)
  recode_rescale(
    x,
    "Much easier"     = 1,
    "Slightly easier" = 2,
    "No change"       = 3,
    "Slightly harder" = 4,
    "Much harder"     = 5,
    "Don't know"      = NULL
  )

recode_20 <- function(x)
  recode_rescale(
    x,
    "Legal in all cases"          = 1,
    "Legal/Illegal in some cases" = 2,
    "Illegal in all cases"        = 3,
    "Don't know"                  = NULL
  )

recode_21 <- function(x)
  recode_rescale(
    x,
    "Should be allow to us the restrooms of the gender with which they currently identify" = 1,
    "Should be required to use the restrooms of the gender they were born into"            = 2,
    "Don't know"                                                                           = NULL
  )

recode_22 <- function(x)
  recode_rescale(
    x,
    "Should be more evenly distributed" = 1, 
    "Distribution is fair"              = 2,
    "Don't know"                        = NULL
  )

recode_23 <- function(x)
  recode_rescale(
    x,
    "Yes"        = 1,
    "No"         = 2,
    "Don't know" = NULL
  )

recode_24 <- function(x)
  recode_rescale(
    x,
    "We need a strong government to handle today's complex economic problems"                                      = 1,
    "People would be better able to handle today's problems within a free market with less government involvement" = 2,
    "Don't know"                                                                                                   = NULL
  )

recode_25 <- function(x)
  recode_rescale(
    x,
    "Too little"             = 1,
    "About the right amount" = 2,
    "Too much"               = 3,
    "Don't know"             = NULL
  )

# Mapping to recode variables
vars_recode <- list(
  rigged_1 = list(var = "RIGGED_SYSTEM_1_2016", fun = recode_01),
  rigged_2 = list(var = "RIGGED_SYSTEM_5_2016", fun = recode_01),
  rigged_3 = list(var = "RIGGED_SYSTEM_6_2016", fun = recode_01),
  safety_1 = list(var = "imiss_m_2016", fun = recode_02),
  safety_2 = list(var = "imiss_s_2016", fun = recode_02),
  trade_1 = list(var = "free_trade_1_2016", fun = recode_03),
  trade_2 = list(var = "free_trade_2_2016", fun = recode_03),
  trade_3 = list(var = "free_trade_3_2016", fun = recode_04),
  trade_4 = list(var = "free_trade_4_2016", fun = recode_03),
  trade_5 = list(var = "free_trade_5_2016", fun = recode_03),
  sexism_1 = list(var = "sexism2_2016", fun = recode_05),
  sexism_2 = list(var = "sexism3_2016", fun = recode_06),
  sexism_3 = list(var = "sexism4_2016", fun = recode_05),
  pride_1 = list(var = "amcitizen_2016", fun = recode_07),
  pride_2 = list(var = "proudhis_2016", fun = recode_08),
  decline_1 = list(var = "Americatrend_2016", fun = recode_09),
  decline_2 = list(var = "values_culture_2016", fun = recode_10),
  racism_1 = list(var = "race_deservemore_2016", fun = recode_11),
  racism_2 = list(var = "race_overcome_2016", fun = recode_12),
  racism_3 = list(var = "policies_favor_2016", fun = recode_13),
  racism_4 = list(var = "reverse_discrimination_2016", fun = recode_12),
  racism_5 = list(var = "race_tryharder_2016", fun = recode_12),
  racism_6 = list(var = "race_slave_2016", fun = recode_11),
  muslims_1 = list(var = "amchrstn_2016", fun = recode_14),
  muslims_2 = list(var = "immi_muslim_2016", fun = recode_15),
  muslims_3 = list(var = "ft_muslim_2016", fun = recode_16),
  immigration_1 = list(var = "immi_contribution_2016", fun = recode_17),
  immigration_2 = list(var = "immi_naturalize_2016", fun = recode_18),
  immigration_3 = list(var = "immi_makedifficult_2016", fun = recode_19),
  moral_1 = list(var = "abortview3_2016", fun = recode_20),
  moral_2 = list(var = "gaymar_2016", fun = recode_18),
  moral_3 = list(var = "view_transgender_2016", fun = recode_21),
  inequality_1 = list(var = "wealth_2016", fun = recode_22),
  inequality_2 = list(var = "taxdoug_2016", fun = recode_23),
  inequality_3 = list(var = "RIGGED_SYSTEM_3_2016", fun = recode_01),
  government_1 = list(var = "gvmt_involment_2016", fun = recode_24),
  government_2 = list(var = "govt_reg_2016", fun = recode_25)
)

recode_2012 <- function(x, ...) {
  recode( 
    x,
    "Barack Obama" = "Obama",
    "Mitt Romney" = "Romney",
    "Other candidate" = "Other",
    .default = NA_character_
  )
}

recode_2016 <- function(x, ...) {
  recode(
    x,
    "Hillary Clinton" = "Clinton",
    "Donald Trump" = "Trump",
    "Gary Johnson" = "Other", 
    "Evan McMullin" = "Other", 
    "Jill Stein" = "Other", 
    "Other" = "Other",
    .default = NA_character_
  )
}
#===============================================================================

# Read in answers
answers <- read_rds(file_answers)
```

The [Democracy Fund Voter Study Group](https://www.voterstudygroup.org) "is a research collaboration comprised of nearly two dozen analysts and scholars from across the political spectrum offering new data and analysis exploring American voter's beliefs and behaviors." They commissioned the Views of the Electorate Research Survey (VOTER Survey) after the 2016 US presidential election. This was a survey of 8000 voting-age adults on how they voted in both the 2012 and 2016 presidential elections together with the answers to over 600 other questions. Researchers are using the data from this survey to seek insights into the electorate and the 2016 election.

Derived variables
-----------------

A key skill in exploratory data analysis is to be able to derive new variables from the raw data that are suited to the goals of your study. Lee Drutman, a senior fellow in the program of political reform at New America, sought to study the relationship of how voters voted to their views on issues that were salient during the campaign [1]. For this, he derived 12 new variables from 37 variables in the survey. Below are the new variables, followed by the survey questions upon which they are based.

`rigged`: The view that politics is a rigged game

-   Elections today don't matter. Things stay the same no matter who we vote in.
-   People like me don't have any say in what the government does.
-   Elites in this country don't understand the problems I am facing.

`safety`: The importance of Social Security / Medicare

-   How important are the following issues to you?
    -   Social Security
    -   Medicare

`trade`: Attitudes on foreign trade

-   Do you think free trade agreements with other countries generally increase or decrease each of the following, or don't make much difference either way?
    -   The number of jobs available to American workers
    -   The wages of American workers
    -   The prices of products available for sale
    -   The quality of products
    -   The amount of products American business sell

`sexism`: Attitudes on gender roles

-   When women demand equality these days, they are actually seeking special favors.
-   Women often miss out on good jobs because of discrimination.
-   Women who complain about harassment often cause more problems than they solve.

`pride`: Pride in America

-   I would rather be a citizen of America than any other country in the world.
-   How proud are you of America in each of the following?
    -   Its history

`decline`: The perception that "people like me" are losing ground

-   In general, would you say life in America today is better, worse, or about the same as it was fifty years ago for people like you?
-   In America today, do you feel the values and culture of people like you are:

`racism`: Attitudes towards African-Americans

-   Here are a few statements about race in America. Please tell us whether you agree or disagree with each statement.
    -   Over the past few years, blacks have gotten less than they deserve.
    -   Irish, Italian, Jewish, and many other minorities overcame prejudice and worked their way up. Blacks should do the same without any special favors.
    -   It's really a matter of some people not trying hard enough. If blacks would only try harder, they could be just as well off as whites.
    -   Generations of slavery and discrimination have created conditions that make it difficult for blacks to work their way out of the lower class.
-   In general, do you think the policies of the Obama administration favor whites over blacks, favor blacks over whites, or do they treat both groups about the same?
-   Today discrimination against whites has become as big a problem as discrimination against blacks and other minorities.

`muslims`: Feelings towards Muslims

-   Some people say that the following things are important for being truly American. Others say they are not important. How important do you think each of the following is to being American?
    -   To be Christian
-   Do you favor or oppose temporarily banning Muslims from other countries from entering the United States?
-   We'd like to get your feelings toward some groups who are in the news these days. Ratings between 50 degrees and 100 degrees mean that you feel favorable and warm toward the group. Ratings between 0 degrees and 50 degrees mean that you don't feel favorable toward the group and that you don't care too much for that group. You would rate the group at the 50 degree mark if you don't feel particularly warm or cold toward the group. If we come to a group who you don't recognize, you don't need to rate that group. Click on the thermometer to give a rating.
    -   Muslims

`immigration`: Attitudes on immigration

-   Overall, do you think illegal immigrants make a contribution to American society or are a drain?
-   Do you favor or oppose providing a legal way for illegal immigrants already in the United States to become U.S. citizens?
-   Do you think it should be easier or harder for foreigners to immigrate to the US legally than it is currently?

`moral`: Attitudes on moral issues

-   Do you think abortion should be...
-   Do you favor or oppose allowing gays and lesbians to marry legally?
-   On public restroom usage of transgender people, which of the following comes closest to your view?

`inequality`: Attitudes on economic inequality

-   Do you feel that the distribution of money and wealth in this country is fair, or do you feel that the money and wealth in this country should be more evenly distributed among more people?
-   Do you favor raising taxes on families with incomes over $200,000 per year?
-   Our economic system is biased in favor of the wealthiest Americans.

`government`: Attitudes toward government intervention

-   On the role of government in the economy, which statement comes closer to your own view?
-   In general, do you think there is too much or too little regulation of business by the government?

Data
----

### Recode variables

**q1** The 2016 VOTER Survey dataset is available at [this site](https://www.voterstudygroup.org/reports/2016-elections/data). Download the documentation (.doc file) and the data in CSV format and save it in a directory other than a GitHub repo. Read the data into the tibble `voter_survey`.

``` r
factor_list <- map_chr(vars_recode, ~ .$var)

voter_survey <-
  survey_dta %>%
  haven::read_dta() %>%
  mutate_at(vars(factor_list), funs(as_factor))
```

The parameter section above contains the definitions of the derived variables Lee Drutman used for his analysis. Almost all of the questions he used from the VOTER Survey had categorical responses, such as "Strongly agree" or "Very important". In order to combine questions that had different answers, he assigned to each response a number between -1 and 1, where -1 corresponds to the most traditionally liberal response and 1 corresponds to the most traditionally conservative response. For example, the survey contains the variable `taxdoug_2016` with the responses to the question: "Do you favor raising taxes on families with incomes over $200,000 per year?". The new variable `inequality_2` was created from the existing variable `taxdoug_2016` using this recoding:

| taxdoug\_2016 |  inequality\_2|
|:--------------|--------------:|
| Yes           |             -1|
| No            |              1|
| Don't know    |             NA|

This recoding can be done using the function `recode_21()` above; that is, `inequality_2` is equal to `recode_21(voter_survey$taxdoug_2016)`.

`vars_recode` in the parameters contains the combinations of the VOTER Survey variables and recoding functions to create the new recoded variables. Use `vars_recode`, `voter_survey`, and purrr, to create a new tibble `q1` with the following variables:

-   `case_identifier`: Case identifier: `voter_survey$case_identifier`
-   `rigged_1`: First recoded variable
-   ...
-   `government_2`: Last recoded variable

(Hint: Almost all the work can be done with one purrr command.)

``` r
q1 <-
  vars_recode %>%
  map_dfc(~ (.$fun(pull(voter_survey, .$var)))) %>%
  mutate(case_identifier = as.integer(voter_survey$case_identifier)) %>%
  select(case_identifier, everything())

# Compare result with answer
if (exists("q1")) compare(answers$q1, q1)
```

    ## TRUE

### Calculate derived variables

**q2** Each of the derived variables is based upon the responses to more than one question. Now that the responses to the questions have been recoded so that they are all numbers between -1 and 1, the derived variables are calculated by taking the mean. For example, the `inequality` variable is the mean of `inequality_1`, `inequality_2`, and `inequality_3`. In this way, the 37 variables `rigged_1`, `rigged_2`, ..., `government_2` become the 12 variables `rigged`, `safety`, ..., `government`. Two additional composite variables were created as follows:

-   `economic`: Mean of `government`, `inequality`, `safety`, and `trade`
-   `social`: Mean of `immigration`, `moral`, `muslims`, and `racism`

Finally, the `group` variable is defined as follows:

-   `group`: Has the values:
    -   "Liberal": When `economic < 0` and `social < 0`
    -   "Populist": When `economic < 0` and `social >= 0`
    -   "Conservative": When `economic >= 0` and `social >= 0`
    -   "Libertarian": When `economic >= 0` and `social < 0`
    -   NA: When `economic` or `social` are NA

Use `q1`, `group_by()`, and `summarize()` to create the 12 derived variables, and then create `economic`, `social`, and `group`. The new tibble `q2` should have these variables:

-   `case_identifier`: Case identifier
-   `decline`: First derived variable in alphabetic order
-   ...
-   `trade`: Last derived variable in alphabetic order
-   `economic`: Economic composite variable
-   `social`: Social composite variable
-   `group`: Group variable

Note: Be sure to use `na.rm = TRUE`.

``` r
q2 <-
  q1 %>%
  gather(
    key = "variable", 
    value = "score", 
    2:ncol(q1)
  ) %>%
  separate(col = variable, into = c("new", "trash"), sep = "_") %>%
  group_by(case_identifier, new) %>%
  summarise(
    mean = mean(score, na.rm = TRUE)
  ) %>%
  spread(key = new, value = mean) %>%
  mutate(
    economic = mean(
      cbind(
        government, 
        inequality, 
        safety, 
        trade
      ), 
      na.rm = TRUE
    ),
    social = mean(
      cbind(
        immigration, 
        moral, 
        muslims, 
        racism
      ), na.rm = TRUE)
  ) %>%
  mutate(
    group = if_else(
      economic < 0 & social < 0, 
      "Liberal", 
      if_else(
        economic < 0 & social >= 0, 
        "Populist", 
        if_else(
          economic >= 0 & social >= 0, 
          "Conservative", 
          if_else(
            economic >= 0 & social < 0, 
            "Libertarian", 
            "NA")
          )
        )
      )
    )

# Compare result with answer
if (exists("q2")) compare(answers$q2, q2, ignoreAttrs = TRUE)
```

    ## TRUE 
    ##   dropped attributes

### Information about voter and how they voted

**q3** Finally, we need to combine the derived variables with information about the voter and how they voted. Using `voter_survey` and `q2`, create a new tibble `q3` with the following variables:

-   `case_identifier`: Case identifier
-   `weight`: Case weight: `voter_survey$weight`
-   `birth_year`: Birth year: `voter_survey$birthyr_baseline`
-   `gender`: Gender: `voter_survey$gender_baseline`
-   `race`: Race: `voter_survey$race_baseline`
-   `vote_2012`: 2012 presidential vote: `voter_survey$post_presvote12_2012` recoded as follows:
    -   "Obama" from "Barack Obama"
    -   "Romney" from "Mitt Romney"
    -   "Other" from "Other candidate"
    -   NA from "I did not vote", "I did not vote in this race", "Not sure", and NA
-   `vote_2016`: 2016 presidential vote: `voter_survey$presvote16post_2016` recoded as follows:
    -   "Clinton" from "Hillary Clinton"
    -   "Trump" from "Donald Trump"
    -   "Other" from "Gary Johnson", "Evan McMullin", "Jill Stein", and "Other"
    -   NA from "Did not vote for President" and NA
-   Derived variables from `q2`

``` r
q3 <-
  q2 %>%
  left_join(
    voter_survey %>%
      # I have to do this because I used the .dta file
      mutate(
        case_identifier = as.integer(case_identifier),
             post_presvote12_2012 = as_factor(post_presvote12_2012),
             presvote16post_2016 = as_factor(presvote16post_2016),
             gender = as_factor(gender_baseline),
             race = as_factor(race_baseline)
      ) %>%  
      select(
        case_identifier, 
        birth_year = birthyr_baseline, 
        weight = weight, 
        gender, 
        race, 
        post_presvote12_2012, 
        presvote16post_2016
      ), 
    by = "case_identifier"
  ) %>%
  mutate(
    vote_2012 = as.character(recode_2012(post_presvote12_2012)),
    vote_2016 = as.character(recode_2016(presvote16post_2016)),
    weight = as.double(weight),
    birth_year = as.integer(birth_year),
    gender = as.character(gender),
    race = as.character(race)
  ) %>%
  select(
    case_identifier,
    weight,
    birth_year,
    gender,
    race,
    vote_2012,
    vote_2016,
    decline:group
  ) 

# Compare result with answer
if (exists("q3")) compare(answers$q3, q3, ignoreAttrs = TRUE)
```

    ## TRUE 
    ##   dropped attributes

[1] Drutman L. [Political Divisions in 2016 and Beyond: Tensions Between and Within the Two Parties](https://www.voterstudygroup.org/reports/2016-elections/political-divisions-in-2016-and-beyond). 2017 Jun.
