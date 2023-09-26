# Business Intelligence Lab Submission Markdown

<korn> \<Tuesday 26 September 2023\>

-   [Student Details](#student-details)
-   [Lab 2: Exploratory Data Analysis ----](#lab-2-exploratory-data-analysis--)
-   [Setup Chunk](#setup-chunk)
-   [Loading the Student Performance Dataset](#loading-the-student-performance-dataset)
    -   [Description of the Dataset](#description-of-the-dataset)
-   [Calculate correlation](#calculate-correlation)

# Student Details {#student-details}

+---------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **Student ID Numbers and Names of Group Members** | *\<list one student name, class group (just the letter; A, B, or C), and ID per line, e.g., 123456 - A - John Leposo; you should be between 2 and 5 members per group\>* |
|                                                   |                                                                                                                                                                          |
|                                                   | 1.  136675 - C - Bernard Otieno                                                                                                                                          |
|                                                   |                                                                                                                                                                          |
|                                                   | 2.  134644 - C - Sebastian Mira                                                                                                                                          |
|                                                   |                                                                                                                                                                          |
|                                                   | 3.  136009 - C - Sera Ndabari                                                                                                                                            |
|                                                   |                                                                                                                                                                          |
|                                                   | 4.  131582 - C - Njeri Njuguna                                                                                                                                           |
|                                                   |                                                                                                                                                                          |
|                                                   | 5.  131589 - C - Agnes Anyango                                                                                                                                           |
+---------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **GitHub Classroom Group Name**                   | *\<Korn\>*                                                                                                                                                               |
+---------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **Course Code**                                   | BBT4206                                                                                                                                                                  |
+---------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **Course Name**                                   | Business Intelligence II                                                                                                                                                 |
+---------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **Program**                                       | Bachelor of Business Information Technology                                                                                                                              |
+---------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **Semester Duration**                             | 21^st^ August 2023 to 28^th^ November 2023                                                                                                                               |
+---------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

# Lab 2: Exploratory Data Analysis ---- {#lab-2-exploratory-data-analysis--}

Course Code: BBT4206 Course Name: Business Intelligence II Semester Duration: 21st August 2023 to 28th November 2023

Lecturer: Allan Omondi Contact: aomondi $$at$$ Strathmore.edu

Note: The lecture contains both theory and practice. This file forms part of the practice. It has required lab work submissions that are graded for coursework marks.

# Setup Chunk {#setup-chunk}

We start by installing all the required packages

``` r
## formatR - Required to format R code in the markdown ----
if (!is.element("formatR", installed.packages()[, 1])) {
  install.packages("formatR", dependencies = TRUE,
                   repos="https://cloud.r-project.org")
}
require("formatR")


## readr - Load datasets from CSV files ----
if (!is.element("readr", installed.packages()[, 1])) {
  install.packages("readr", dependencies = TRUE,
                   repos="https://cloud.r-project.org")
}
require("readr")
```

------------------------------------------------------------------------

**Note:** the following "*KnitR*" options have been set as the defaults in this markdown:\
`knitr::opts_chunk$set(echo = TRUE, warning = FALSE, eval = TRUE, collapse = FALSE, tidy.opts = list(width.cutoff = 80), tidy = TRUE)`.

More KnitR options are documented here <https://bookdown.org/yihui/rmarkdown-cookbook/chunk-options.html> and here <https://yihui.org/knitr/options/>.

``` r
knitr::opts_chunk$set(
    eval = TRUE,
    echo = TRUE,
    warning = FALSE,
    collapse = FALSE,
    tidy = TRUE
)
```

------------------------------------------------------------------------

**Note:** the following "*R Markdown*" options have been set as the defaults in this markdown:

> output:
>
> github_document:\
> toc: yes\
> toc_depth: 4\
> fig_width: 6\
> fig_height: 4\
> df_print: default
>
> editor_options:\
> chunk_output_type: console

# Loading the Student Performance Dataset {#loading-the-student-performance-dataset}

The 20230412-20230719-BI1-BBIT4-1-StudentPerformanceDataset is then loaded. The dataset and its metadata are available here: <https://drive.google.com/drive/folders/1-BGEhfOwquXF6KKXwcvrx7WuZXuqmW9q?usp=sharing>

``` r
require("readr")

X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset <-
  readr::read_csv(
                  here::here("data", "20230412-20230719-BI1-BBIT4-1-StudentPerformanceDataset.csv"), # nolint
                  col_types =
                  readr::cols(
                              class_group =
                              readr::col_factor(levels = c("A", "B", "C")),
                              gender = readr::col_factor(levels = c("1", "0")),
                              YOB = readr::col_date(format = "%Y"),
                              regret_choosing_bi =
                              readr::col_factor(levels = c("1", "0")),
                              drop_bi_now =
                              readr::col_factor(levels = c("1", "0")),
                              motivator =
                              readr::col_factor(levels = c("1", "0")),
                              read_content_before_lecture =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              anticipate_test_questions =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              answer_rhetorical_questions =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              find_terms_I_do_not_know =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              copy_new_terms_in_reading_notebook =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              take_quizzes_and_use_results =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              reorganise_course_outline =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              write_down_important_points =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              space_out_revision =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              studying_in_study_group =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              schedule_appointments =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              goal_oriented =
                              readr::col_factor(levels =
                                                c("1", "0")),
                              spaced_repetition =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4")),
                              testing_and_active_recall =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4")),
                              interleaving =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4")),
                              categorizing =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4")),
                              retrospective_timetable =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4")),
                              cornell_notes =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4")),
                              sq3r = readr::col_factor(levels =
                                                       c("1", "2", "3", "4")),
                              commute = readr::col_factor(levels =
                                                          c("1", "2",
                                                            "3", "4")),
                              study_time = readr::col_factor(levels =
                                                             c("1", "2",
                                                               "3", "4")),
                              repeats_since_Y1 = readr::col_integer(),
                              paid_tuition = readr::col_factor(levels =
                                                               c("0", "1")),
                              free_tuition = readr::col_factor(levels =
                                                               c("0", "1")),
                              extra_curricular = readr::col_factor(levels =
                                                                   c("0", "1")),
                              sports_extra_curricular =
                              readr::col_factor(levels = c("0", "1")),
                              exercise_per_week = readr::col_factor(levels =
                                                                    c("0", "1",
                                                                      "2",
                                                                      "3")),
                              meditate = readr::col_factor(levels =
                                                           c("0", "1",
                                                             "2", "3")),
                              pray = readr::col_factor(levels =
                                                       c("0", "1",
                                                         "2", "3")),
                              internet = readr::col_factor(levels =
                                                           c("0", "1")),
                              laptop = readr::col_factor(levels = c("0", "1")),
                              family_relationships =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              friendships = readr::col_factor(levels =
                                                              c("1", "2", "3",
                                                                "4", "5")),
                              romantic_relationships =
                              readr::col_factor(levels =
                                                c("0", "1", "2", "3", "4")),
                              spiritual_wellnes =
                              readr::col_factor(levels = c("1", "2", "3",
                                                           "4", "5")),
                              financial_wellness =
                              readr::col_factor(levels = c("1", "2", "3",
                                                           "4", "5")),
                              health = readr::col_factor(levels = c("1", "2",
                                                                    "3", "4",
                                                                    "5")),
                              day_out = readr::col_factor(levels = c("0", "1",
                                                                     "2", "3")),
                              night_out = readr::col_factor(levels = c("0",
                                                                       "1", "2",
                                                                       "3")),
                              alcohol_or_narcotics =
                              readr::col_factor(levels = c("0", "1", "2", "3")),
                              mentor = readr::col_factor(levels = c("0", "1")),
                              mentor_meetings = readr::col_factor(levels =
                                                                  c("0", "1",
                                                                    "2", "3")),
                              `Attendance Waiver Granted: 1 = Yes, 0 = No` =
                              readr::col_factor(levels = c("0", "1")),
                              GRADE = readr::col_factor(levels =
                                                        c("A", "B", "C", "D",
                                                          "E"))),
                  locale = readr::locale())
```

## Description of the Dataset {#description-of-the-dataset}

We then display the number of observations and number of variables. We have 101 observations and 100 variables to work with.

``` r
dim(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset)
```

```         
## [1] 101 100
```

Next, we display the quartiles for each numeric variable using the summary() function.

``` r
summary(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset)
```

```         
##  class_group gender      YOB             regret_choosing_bi drop_bi_now
##  A:23        1:58   Min.   :1998-01-01   1: 2               1: 2       
##  B:37        0:43   1st Qu.:2000-01-01   0:99               0:99       
##  C:41               Median :2001-01-01                                 
##                     Mean   :2000-11-25                                 
##                     3rd Qu.:2002-01-01                                 
##                     Max.   :2003-01-01                                 
##  motivator read_content_before_lecture anticipate_test_questions
##  1:76      1:11                        1: 5                     
##  0:25      2:25                        2: 6                     
##            3:47                        3:31                     
##            4:14                        4:43                     
##            5: 4                        5:16                     
##                                                                 
##  answer_rhetorical_questions find_terms_I_do_not_know
##  1: 3                        1: 6                    
##  2:15                        2: 2                    
##  3:32                        3:30                    
##  4:38                        4:37                    
##  5:13                        5:26                    
##                                                      
##  copy_new_terms_in_reading_notebook take_quizzes_and_use_results
##  1: 5                               1: 4                        
##  2:10                               2: 5                        
##  3:24                               3:22                        
##  4:37                               4:32                        
##  5:25                               5:38                        
##                                                                 
##  reorganise_course_outline write_down_important_points space_out_revision
##  1: 7                      1: 4                        1: 8              
##  2:16                      2: 8                        2:17              
##  3:28                      3:20                        3:34              
##  4:32                      4:38                        4:28              
##  5:18                      5:31                        5:14              
##                                                                          
##  studying_in_study_group schedule_appointments goal_oriented spaced_repetition
##  1:34                    1:42                  1:20          1:12             
##  2:21                    2:35                  0:81          2:31             
##  3:21                    3:16                                3:48             
##  4:16                    4: 5                                4:10             
##  5: 9                    5: 3                                                 
##                                                                               
##  testing_and_active_recall interleaving categorizing retrospective_timetable
##  1: 2                      1:14         1: 6         1:17                   
##  2:17                      2:51         2:28         2:36                   
##  3:55                      3:32         3:56         3:38                   
##  4:27                      4: 4         4:11         4:10                   
##                                                                             
##                                                                             
##  cornell_notes sq3r   commute   study_time repeats_since_Y1 paid_tuition
##  1:19          1:18   1   :16   1   :45    Min.   : 0.00    0:90        
##  2:26          2:28   2   :23   2   :39    1st Qu.: 0.00    1:11        
##  3:38          3:30   3   :33   3   :12    Median : 2.00                
##  4:18          4:25   4   :28   4   : 4    Mean   : 2.03                
##                       NA's: 1   NA's: 1    3rd Qu.: 3.00                
##                                            Max.   :10.00                
##  free_tuition extra_curricular sports_extra_curricular exercise_per_week
##  0:74         0:48             0:65                    0:24             
##  1:27         1:53             1:36                    1:49             
##                                                        2:23             
##                                                        3: 5             
##                                                                         
##                                                                         
##  meditate pray   internet laptop  family_relationships friendships
##  0:50     0: 9   0:14     0:  1   1   : 0              1   : 0    
##  1:35     1:24   1:87     1:100   2   : 2              2   : 3    
##  2: 7     2:19                    3   :18              3   :17    
##  3: 9     3:49                    4   :39              4   :56    
##                                   5   :41              5   :24    
##                                   NA's: 1              NA's: 1    
##  romantic_relationships spiritual_wellnes financial_wellness  health   day_out
##  0:57                   1   : 1           1   :10            1   : 2   0:28   
##  1: 0                   2   : 8           2   :18            2   : 3   1:67   
##  2: 6                   3   :37           3   :41            3   :22   2: 5   
##  3:27                   4   :33           4   :21            4   :35   3: 1   
##  4:11                   5   :21           5   :10            5   :38          
##                         NA's: 1           NA's: 1            NA's: 1          
##  night_out alcohol_or_narcotics mentor mentor_meetings
##  0:56      0:69                 0:60   0:54           
##  1:41      1:30                 1:41   1:29           
##  2: 2      2: 1                        2:15           
##  3: 2      3: 1                        3: 3           
##                                                       
##                                                       
##  A - 1. I am enjoying the subject A - 2. Classes start and end on time
##  Min.   :0.000                    Min.   :0.000                       
##  1st Qu.:4.000                    1st Qu.:4.000                       
##  Median :5.000                    Median :5.000                       
##  Mean   :4.446                    Mean   :4.634                       
##  3rd Qu.:5.000                    3rd Qu.:5.000                       
##  Max.   :5.000                    Max.   :5.000                       
##  A - 3. The learning environment is participative, involves learning by doing and is group-based
##  Min.   :0.000                                                                                  
##  1st Qu.:4.000                                                                                  
##  Median :4.000                                                                                  
##  Mean   :4.307                                                                                  
##  3rd Qu.:5.000                                                                                  
##  Max.   :5.000                                                                                  
##  A - 4. The subject content is delivered according to the course outline and meets my expectations
##  Min.   :0.000                                                                                    
##  1st Qu.:4.000                                                                                    
##  Median :5.000                                                                                    
##  Mean   :4.693                                                                                    
##  3rd Qu.:5.000                                                                                    
##  Max.   :5.000                                                                                    
##  A - 5. The topics are clear and logically developed
##  Min.   :0.000                                      
##  1st Qu.:4.000                                      
##  Median :5.000                                      
##  Mean   :4.604                                      
##  3rd Qu.:5.000                                      
##  Max.   :5.000                                      
##  A - 6. I am developing my oral and writing skills
##  Min.   :0.000                                    
##  1st Qu.:4.000                                    
##  Median :4.000                                    
##  Mean   :4.069                                    
##  3rd Qu.:5.000                                    
##  Max.   :5.000                                    
##  A - 7. I am developing my reflective and critical reasoning skills
##  Min.   :0.000                                                     
##  1st Qu.:4.000                                                     
##  Median :4.000                                                     
##  Mean   :4.337                                                     
##  3rd Qu.:5.000                                                     
##  Max.   :5.000                                                     
##  A - 8. The assessment methods are assisting me to learn
##  Min.   :0.000                                          
##  1st Qu.:4.000                                          
##  Median :5.000                                          
##  Mean   :4.564                                          
##  3rd Qu.:5.000                                          
##  Max.   :5.000                                          
##  A - 9. I receive relevant feedback
##  Min.   :0.000                     
##  1st Qu.:4.000                     
##  Median :5.000                     
##  Mean   :4.535                     
##  3rd Qu.:5.000                     
##  Max.   :5.000                     
##  A - 10. I read the recommended readings and notes
##  Min.   :0.000                                    
##  1st Qu.:4.000                                    
##  Median :5.000                                    
##  Mean   :4.505                                    
##  3rd Qu.:5.000                                    
##  Max.   :5.000                                    
##  A - 11. I use the eLearning material posted
##  Min.   :0.000                              
##  1st Qu.:4.000                              
##  Median :5.000                              
##  Mean   :4.653                              
##  3rd Qu.:5.000                              
##  Max.   :5.000                              
##  B - 1. Concept 1 of 6: Principles of Business Intelligence and the DataOps Philosophy
##  Min.   :0.000                                                                        
##  1st Qu.:4.000                                                                        
##  Median :4.000                                                                        
##  Mean   :4.208                                                                        
##  3rd Qu.:5.000                                                                        
##  Max.   :5.000                                                                        
##  B - 2. Concept 3 of 6: Linear Algorithms for Predictive Analytics
##  Min.   :0.000                                                    
##  1st Qu.:3.000                                                    
##  Median :4.000                                                    
##  Mean   :3.901                                                    
##  3rd Qu.:5.000                                                    
##  Max.   :5.000                                                    
##  C - 2. Quizzes at the end of each concept
##  Min.   :0.000                            
##  1st Qu.:4.000                            
##  Median :5.000                            
##  Mean   :4.545                            
##  3rd Qu.:5.000                            
##  Max.   :5.000                            
##  C - 3. Lab manuals that outline the steps to follow during the labs
##  Min.   :0.000                                                      
##  1st Qu.:4.000                                                      
##  Median :5.000                                                      
##  Mean   :4.564                                                      
##  3rd Qu.:5.000                                                      
##  Max.   :5.000                                                      
##  C - 4. Required lab work submissions at the end of each lab manual that outline the activity to be done on your own
##  Min.   :0.000                                                                                                      
##  1st Qu.:4.000                                                                                                      
##  Median :5.000                                                                                                      
##  Mean   :4.505                                                                                                      
##  3rd Qu.:5.000                                                                                                      
##  Max.   :5.000                                                                                                      
##  C - 5. Supplementary videos to watch
##  Min.   :0.000                       
##  1st Qu.:4.000                       
##  Median :4.000                       
##  Mean   :4.149                       
##  3rd Qu.:5.000                       
##  Max.   :5.000                       
##  C - 6. Supplementary podcasts to listen to
##  Min.   :0.00                              
##  1st Qu.:4.00                              
##  Median :4.00                              
##  Mean   :4.04                              
##  3rd Qu.:5.00                              
##  Max.   :5.00                              
##  C - 7. Supplementary content to read C - 8. Lectures slides
##  Min.   :0.000                        Min.   :0.000         
##  1st Qu.:4.000                        1st Qu.:4.000         
##  Median :4.000                        Median :5.000         
##  Mean   :4.129                        Mean   :4.554         
##  3rd Qu.:5.000                        3rd Qu.:5.000         
##  Max.   :5.000                        Max.   :5.000         
##  C - 9. Lecture notes on some of the lecture slides
##  Min.   :0.000                                     
##  1st Qu.:4.000                                     
##  Median :5.000                                     
##  Mean   :4.554                                     
##  3rd Qu.:5.000                                     
##  Max.   :5.000                                     
##  C - 10. The quality of the lectures given (quality measured by the breadth (the full span of knowledge of a subject) and depth (the extent to which specific topics are focused upon, amplified, and explored) of learning - NOT quality measured by how fun/comical/lively the lectures are)
##  Min.   :0.000                                                                                                                                                                                                                                                                                
##  1st Qu.:4.000                                                                                                                                                                                                                                                                                
##  Median :5.000                                                                                                                                                                                                                                                                                
##  Mean   :4.495                                                                                                                                                                                                                                                                                
##  3rd Qu.:5.000                                                                                                                                                                                                                                                                                
##  Max.   :5.000                                                                                                                                                                                                                                                                                
##  C - 11. The division of theory and practice such that most of the theory is done during the recorded online classes and most of the practice is done during the physical classes
##  Min.   :0.000                                                                                                                                                                   
##  1st Qu.:4.000                                                                                                                                                                   
##  Median :5.000                                                                                                                                                                   
##  Mean   :4.446                                                                                                                                                                   
##  3rd Qu.:5.000                                                                                                                                                                   
##  Max.   :5.000                                                                                                                                                                   
##  C - 12. The recordings of online classes
##  Min.   :0.000                           
##  1st Qu.:4.000                           
##  Median :5.000                           
##  Mean   :4.287                           
##  3rd Qu.:5.000                           
##  Max.   :5.000                           
##  D - 1. \r\nWrite two things you like about the teaching and learning in this unit so far.
##  Length:101                                                                               
##  Class :character                                                                         
##  Mode  :character                                                                         
##                                                                                           
##                                                                                           
##                                                                                           
##  D - 2. Write at least one recommendation to improve the teaching and learning in this unit (for the remaining weeks in the semester)
##  Length:101                                                                                                                          
##  Class :character                                                                                                                    
##  Mode  :character                                                                                                                    
##                                                                                                                                      
##                                                                                                                                      
##                                                                                                                                      
##  Average Course Evaluation Rating Average Level of Learning Attained Rating
##  Min.   :0.000                    Min.   :0.000                            
##  1st Qu.:4.273                    1st Qu.:3.500                            
##  Median :4.545                    Median :4.000                            
##  Mean   :4.486                    Mean   :4.054                            
##  3rd Qu.:4.909                    3rd Qu.:4.500                            
##  Max.   :5.000                    Max.   :5.000                            
##  Average Pedagogical Strategy Effectiveness Rating
##  Min.   :0.000                                    
##  1st Qu.:4.000                                    
##  Median :4.545                                    
##  Mean   :4.388                                    
##  3rd Qu.:4.909                                    
##  Max.   :5.000                                    
##  Project: Section 1-4: (20%) x/10 Project: Section 5-11: (50%) x/10
##  Min.   : 0.000                   Min.   : 0.000                   
##  1st Qu.: 7.400                   1st Qu.: 6.000                   
##  Median : 8.500                   Median : 7.800                   
##  Mean   : 8.011                   Mean   : 6.582                   
##  3rd Qu.: 9.000                   3rd Qu.: 8.300                   
##  Max.   :10.000                   Max.   :10.000                   
##  Project: Section 12: (30%) x/5 Project: (10%): x/30 x 100 TOTAL
##  Min.   :0.000                  Min.   :  0.00                  
##  1st Qu.:0.000                  1st Qu.: 56.00                  
##  Median :0.000                  Median : 66.40                  
##  Mean   :1.005                  Mean   : 62.39                  
##  3rd Qu.:1.000                  3rd Qu.: 71.60                  
##  Max.   :5.000                  Max.   :100.00                  
##  Quiz 1 on Concept 1 (Introduction) x/32 Quiz 3 on Concept 3 (Linear) x/15
##  Min.   : 4.75                           Min.   : 0.000                   
##  1st Qu.:11.53                           1st Qu.: 7.000                   
##  Median :15.33                           Median : 9.000                   
##  Mean   :16.36                           Mean   : 9.342                   
##  3rd Qu.:19.63                           3rd Qu.:12.000                   
##  Max.   :31.25                           Max.   :15.000                   
##  Quiz 4 on Concept 4 (Non-Linear) x/22 Quiz 5 on Concept 5 (Dashboarding) x/10
##  Min.   : 0.00                         Min.   : 0.000                         
##  1st Qu.:10.17                         1st Qu.: 4.330                         
##  Median :13.08                         Median : 6.000                         
##  Mean   :13.11                         Mean   : 5.611                         
##  3rd Qu.:17.50                         3rd Qu.: 7.670                         
##  Max.   :22.00                         Max.   :12.670                         
##  Quizzes and  Bonus Marks (7%): x/79 x 100 TOTAL
##  Min.   :26.26                                  
##  1st Qu.:43.82                                  
##  Median :55.31                                  
##  Mean   :56.22                                  
##  3rd Qu.:65.16                                  
##  Max.   :95.25                                  
##  Lab 1 - 2.c. - (Simple Linear Regression) x/5
##  Min.   :0.000                                
##  1st Qu.:5.000                                
##  Median :5.000                                
##  Mean   :4.752                                
##  3rd Qu.:5.000                                
##  Max.   :5.000                                
##  Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5
##  Min.   :0.000                                                 
##  1st Qu.:3.000                                                 
##  Median :4.850                                                 
##  Mean   :3.919                                                 
##  3rd Qu.:5.000                                                 
##  Max.   :5.000                                                 
##  Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5
##  Min.   :0.000                                                  
##  1st Qu.:4.850                                                  
##  Median :4.850                                                  
##  Mean   :4.218                                                  
##  3rd Qu.:4.850                                                  
##  Max.   :5.000                                                  
##  Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5
##  Min.   :0.000                                    
##  1st Qu.:2.850                                    
##  Median :4.850                                    
##  Mean   :3.636                                    
##  3rd Qu.:5.000                                    
##  Max.   :5.000                                    
##  Lab 5 - Chart JS Dashboard Setup x/5 Lab Work (7%) x/25 x 100
##  Min.   :0.000                        Min.   : 17.80          
##  1st Qu.:0.000                        1st Qu.: 70.80          
##  Median :5.000                        Median : 80.00          
##  Mean   :3.404                        Mean   : 79.72          
##  3rd Qu.:5.000                        3rd Qu.: 97.20          
##  Max.   :5.000                        Max.   :100.00          
##  CAT 1 (8%): x/38 x 100 CAT 2 (8%): x/100 x 100
##  Min.   : 0.00          Min.   :  0.00         
##  1st Qu.:57.89          1st Qu.:  0.00         
##  Median :68.42          Median : 52.00         
##  Mean   :66.65          Mean   : 43.06         
##  3rd Qu.:82.89          3rd Qu.: 68.00         
##  Max.   :97.36          Max.   :100.00         
##  Attendance Waiver Granted: 1 = Yes, 0 = No Absenteeism Percentage
##  0:96                                       Min.   : 0.00         
##  1: 5                                       1st Qu.: 7.41         
##                                             Median :14.81         
##                                             Mean   :15.42         
##                                             3rd Qu.:22.22         
##                                             Max.   :51.85         
##  Coursework TOTAL: x/40 (40%) EXAM: x/60 (60%)
##  Min.   : 7.47                Min.   : 0.00   
##  1st Qu.:20.44                1st Qu.:25.00   
##  Median :24.58                Median :33.00   
##  Mean   :24.53                Mean   :32.59   
##  3rd Qu.:29.31                3rd Qu.:42.00   
##  Max.   :35.08                Max.   :56.00   
##  TOTAL = Coursework TOTAL + EXAM (100%) GRADE 
##  Min.   : 7.47                          A:23  
##  1st Qu.:45.54                          B:25  
##  Median :58.69                          C:22  
##  Mean   :57.12                          D:25  
##  3rd Qu.:68.83                          E: 6  
##  Max.   :87.72
```

After that, we calculate the variance of TOTALS, which helps us understand how the data spreads out.

``` r
sapply(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[, 99], var)
```

```         
## TOTAL = Coursework TOTAL + EXAM (100%) 
##                                247.286
```

We then assess the kurtosis of the chosen variable using the `kurtosis` function from the "e1071" package to gain insights into the frequency of outliers in the data.

``` r
if (!is.element("e1071", installed.packages()[, 1])) {
    install.packages("e1071", dependencies = TRUE)
}
require("e1071")
```

```         
## Loading required package: e1071
```

``` r
sapply(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[, 99], kurtosis,
    type = 2)
```

```         
## TOTAL = Coursework TOTAL + EXAM (100%) 
##                              0.3814857
```

The skewness of the specific variable is then calculated to understand the asymmetry of its distribution.

``` r
sapply(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[, 99], skewness,
    type = 2)
```

```         
## TOTAL = Coursework TOTAL + EXAM (100%) 
##                             -0.4713841
```

We then proceed to measure the covariance between variables using the `cov()` function, this is computed for numeric values only, not categorical values.This is the absenteesim percentage to the Totals column.

``` r
X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset_cov <- cov(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[,
    96:99])
View(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset_cov)
```

Following that,we measure the correlation between variables using the `cor()` function.

\`\`\`{r Calculate Correlation} \# Select only numeric columns for correlation numeric_columns \<- X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset$$,
sapply(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset,
is.numeric)$$

# Calculate correlation {#calculate-correlation}

correlation_matrix \<- cor(numeric_columns, use = "complete.obs") View(correlation_matrix)
