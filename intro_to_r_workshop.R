# Introduction to R

####################################################################################
## Creating objects in R                                                          ##
####################################################################################

# You can get output from R simply by typing math in the console.
# 
# However, to do useful and interesting things, we need to assign values to
# objects. To create an object, we need to give it a name followed by the
# assignment operator `<-`, and the value we want to give it:
# 
# When assigning a value to an object, R does not print anything. 
# You can print the value by typing the object name:

area_hectares <- 1.0    # doesn't print anything
area_hectares # printing it

# Now that R has `area_hectares` in memory, we can do arithmetic with it. For
# instance, we may want to convert this area into acres (area in acres is 2.47 times the area in hectares):

2.47 * area_hectares

# We can also change an object's value by assigning it a new one:
area_hectares <- 2.5
2.47 * area_hectares

########## Small Exercise ########## 
# Create two variables `length` and `width` and assign them values of your choice.
# Create a third variable `area` and give it a value based on 
# the current values of `length` and `width` (`length * width`).
####################################


####################################################################################
## Functions and their arguments                                                  ##
####################################################################################

## Functions:
# - Functions are "canned scripts"
# - Predefined, or can be made available by importing R *packages*
# - A function usually gets one or more inputs called *arguments*
# - Can return a single value, and also a set of things, or even a dataset 

# Example:
b <- sqrt(100)

## Arguments:
# - can be anything (numbers, filenames, objects etc)
# - must be looked up in the documentation
# - Some functions take on a *default* value

# Let's try a function that can take multiple arguments: `round()`.
round(3.14159)

# Here, we've called `round()` with just one argument, `3.14159`, and it has
# returned the value `3`.  That's because the default is to round to the nearest
# whole number. If we want more digits we can see how to do that by getting
# information about the `round` function.  We look at the help for this function using `?round`.

?round

# We see that if we want a different number of digits, we can
# type `digits=2` or however many we want.

round(3.14159, digits = 2)

# If you provide the arguments in the exact same order as they are defined you
# don't have to name them:

round(3.14159, 2)

# It's good practice to put the non-optional arguments (like the number you're
# rounding) first in your function call, and to specify the names of all optional
# arguments.  If you don't, someone reading your code might have to look up the
# definition of a function with unfamiliar arguments to understand what you're
# doing.


####################################################################################
## Vectors and dataframes                                                         ##
####################################################################################

## Vector
# - composed by a series of values, can be either numbers or characters. 
# - can be assigned using the `c()` function.

# A vector can contain characters. For example, we can create a vector of name of fruits:

fruit <- c("apple", "orange", "banana")
fruit

# A vector can also contain numbers. For example, we can create a vector of price:

price <- c(3, 7, 10)
price

# You could use the slicing operater to get a part of a vector:

fruit[1] # Get the first element
fruit[1:2] # From the first to the second
fruit[-1] # everything except the first

## Dataframes
# Dataframes are representations of data in table format
# We could combine multiple vectors into a dataframe like this:

df <- data.frame(fruit, price)

## Inspecting data frames
# There are functions to extract this information from data frames.
# Here is a non-exhaustive list of some of these functions:
# 
# Size:
dim(df) # returns number of rows, number of columns
nrow(df) # returns the number of rows
ncol(df) # returns the number of columns

# Summary:
str(df) # structure of the object and information about the class, length and content of each column
summary(df) # summary statistics for each column

# Same as vector, you could use the slicing operater to get a part of a dataframe
# However, this time we have to specify both the row and columes:

df[1,1] # First row, first column
df[1,2] # First row, second column
df[1,] # Frist row, all columns (leaving it empty means getting everything)
df[2,] # Second row, all columns (leaving it empty means getting everything)
df[,1] # Frist column, all row (leaving it empty means getting everything)

# Alternatively, you could extract the whole column using '$':
df$fruit
df$price

## Loading dataframe from a file
# Instead of typing your whole dataset, 
# you could load the data in R's memory using the function `read.csv()`

snp <- read.csv("snp.csv") # Load the file 'snp.csv', put it as an object called 'snp'
str(snp)
summary(snp)


####################################################################################
## Data visualisation with ggplot2                                                ##
####################################################################################
# We start by loading the required package.
# install.packages("ggplot2") # You only have to run it once
library(ggplot2)

# To build a ggplot, we will use the following basic template:
# ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  <GEOM_FUNCTION>()
#
# Building plots with **`ggplot2`** is typically an iterative process. 
# We start by defining the dataset we'll use:
ggplot(data = snp)

# lay out the axis(es), for example we can plot the Comments count ('comments_count_fb'):
ggplot(data = snp, aes(x = comments_count_fb))

# and finally choose a geom
ggplot(data = snp, aes(x = comments_count_fb)) +
  geom_histogram()

# to use another geom, just change geom_histogram() to any geom_*
ggplot(data = snp, aes(x = comments_count_fb)) +
  geom_density()

# We could change color by adding arguments (fill means color of the filling in ggplot2)
ggplot(data = snp, aes(x = comments_count_fb, fill = "red")) +
  geom_density()

# How about making it transparent?
ggplot(data = snp, aes(x = comments_count_fb, fill = "red")) +
  geom_density(alpha = 0.5)

# We can easily coloring them by group by changing "red" to type 
# (the column that contain information about post type in the snp dataframe)
ggplot(data = snp, aes(x = comments_count_fb, fill = type)) +
  geom_density(alpha = 0.5)

########## Exercise ########## 
# Using the codes above, try to create a density plot for Likes count ('likes_count_fb')
##############################

# We could also create a plot for two variables:
# This time have to specify both 'x = ...' and 'y = ...' in aes().
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb))

# We could use geom_point() for scatter plot
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb)) +
  geom_point()

# Use the argument 'color = "red"' for red dots
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = "red")) +
  geom_point()

# Or coloring them by post type
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) 

# There are many things you can do by adding layers into the ggplot
# You could log them
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10()

# Or fit a line
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm", se = FALSE, size = 2)

# And add labels
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm", se = FALSE, size = 2) +
  labs(x = "Comments Count", y = "Likes Count",
     title = "Comments and Likes",
     subtitle = "One post per dot",
     caption = "Source: Justin Ho")

# Change the theme by adding theme_bw()
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm", se = FALSE, size = 2) +
  labs(x = "Comments Count", y = "Likes Count",
       title = "Comments and Likes",
       subtitle = "One post per dot",
       caption = "Source: Justin Ho") + 
  theme_bw()

# To save your graph, you could first define the graph as an object then use ggsave:
myplot <- ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm", se = FALSE, size = 2) +
  labs(x = "Comments Count", y = "Likes Count",
       title = "Comments and Likes",
       subtitle = "One post per dot",
       caption = "Source: Justin Ho")
ggsave(myplot, filename = "my_plot.png")

# Facet to make small multiples
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm", se = FALSE, size = 2) +
  facet_wrap(~ type)

########## Exercise ########## 
# Make a scatter plot of shares by comments, log both axes,
# color by post type, shape by post type (adding 'shape = type' in aes())
##############################

ggplot(data = snp, aes(x = shares_count_fb, y = comments_count_fb, color = type, shape = type)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Comments Count", y = "Likes Count",
       title = "Comments and Likes",
       subtitle = "One post per dot",
       caption = "Source: Justin Ho")

##############################

####################################################################################
## It's about time                                                                ##
####################################################################################
# We need this package
# install.packages("scales")
# install.packages("lubridate")
library(scales)
library(lubridate)


# To plot a time series, the first thing you have to do is to transform your data in to time
# There are many formats for time, but the simpliest way would probably be:

snp$date <- as.Date(snp$post_published) # Defining a new column called 'date'

# Simply plot the same scatter point, using 'date' as the x axis
ggplot(data = snp, aes(x = date, y = likes_count_fb)) +
  geom_point()

# Changing the x scale using scale_x_date()
ggplot(data = snp, aes(x = date, y = likes_count_fb)) +
  geom_point() +
  scale_x_date(labels = date_format("%m/%y"), date_breaks = "1 month")

# We could use line
ggplot(data = snp, aes(x = date, y = likes_count_fb, color = type)) +
  geom_line() +
  scale_x_date(labels = date_format("%m/%y"), date_breaks = "1 month")

# Or use geom_smooth to fit a local regression line
ggplot(data = snp, aes(x = date, y = likes_count_fb, color = type)) +
  geom_smooth(method = 'loess') +
  scale_x_date(labels = date_format("%m/%y"), date_breaks = "1 month")

# You could add two geoms on top of each other
ggplot(data = snp, aes(x = date, y = likes_count_fb, color = type)) +
  geom_smooth(method = 'loess') +
  geom_point(alpha = 0.3) +
  scale_x_date(labels = date_format("%m/%y"), date_breaks = "1 month")

# You could also truncate the y axis (use with caution!)
ggplot(data = snp, aes(x = date, y = likes_count_fb, color = type)) +
  geom_smooth(method = 'loess') +
  geom_point(alpha = 0.3) +
  scale_x_date(labels = date_format("%m/%y"), date_breaks = "1 month") +
  ylim(c(0, 3000))

####################################################################################
## Data Wrangling with ggplot2                                                    ##
####################################################################################
# We need this package
# install.packages("dplyr")
library(dplyr)

# For some plots, it might be easier if you transform the data in advance

plot_data <- snp %>% 
  group_by(type, date=floor_date(date, "month")) %>% 
  summarise(total_likes = sum(likes_count_fb))
  


ggplot(data = plot_data, aes(x = date, y = total_likes, color = type)) +
  geom_line()

ggplot(data = plot_data, aes(x = date, y = total_likes, fill = type)) +
  geom_area(position = "stack")

ggplot(data = plot_data, aes(x = date, y = total_likes, fill = type)) +
  geom_area(position = "identity", alpha = 0.8)

ggplot(data = plot_data, aes(x = date, y = total_likes, fill = type)) +
  geom_area(position = "fill", alpha = 0.8)
