library('tidyverse')

# kobs {{{ #

# read in data
time_course_data <- read_tsv("/path/to/time_course_data.tsv")
# time_course_data would be a data frame with columns "t" for time point and "ft" for cleaved fraction at time point t.

# fit to formula
fit_k <- nls(
    ft ~ f0 + f1 * (1 - exp(-kobs * t)),
    data = kinetics_109_df,
    start = list(kobs = 0.009, f0 = 0.0, f1 = 1.00)
)

# kobs value
coef(fit_k)

# }}} kobs #

# pKa {{{ #

# read in data
pH_profile_data <- read_tsv("/path/to/pH_profile_data.tsv")
# pH_profile_data would be a data frame with columns "pH" for pH values and "kobs" for kobs values under corresponding pH.

# fit to formula
fit_pKa <- nls(
    kobs ~ k_cleave / (1 + 10**(pKa - pH)),
    data = pH_profile_data,
    start = list(pKa = 10.0, k_cleave = 1)
)

# pKa value
coef(fit_pKa)

# }}} pKa #

# vim:fdm=marker
