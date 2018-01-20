library(shiny)
library(DT)

shinyUI(
    navbarPage(
        "Google Summer of Code Statistics",
        tabPanel("Statistics", {
            mainPanel(
                
                # ----------------- Title ------------------
                
                h2("GSoC Statistics 2017"),
                h5("by Thiloshon Nagarajah on Jan 20, 2018"),
                
                
                # ----------------- Introduction ------------------
                
                h3("Introduction"),
                p(
                    "GSoC is a highly competitive program with so many options and avenues to explore. Each year students spend huge amounts of time to find out
                    and filter the organizations they like. The purpose of this post is to quantify the program and dissect it statistically so that students can
                    use the knowledge of this year to be better prepared for next year. The data I use in this post was collected from GSoC website and it is used entirely for educational purposes."
                ),
                p(
                    "This blog works in conjunction with my blog post on GSoC, ", tags$a(href="https://thiloshon.wordpress.com/2017/12/30/gsoc-for-dummies/", "GSoC for Dummies!")
                ),
                
                
                
                
                # ----------------- Categories ------------------
                
                h3("Categories"),
                p(
                    "First, let’s see what are the different categories, organizations belong to, in GSoC."
                ),
                plotOutput("categoryBar"),
                p(
                    "As you can see in the figure above, a wide variety of domain is covered in GSoC. Most of the projects belong to Programming Languages and Dev Tools
                    while Medicine, Graphics and OSs take considerable part in the spectrum"
                ),
                
                
                # ----------------- Topics ------------------
                
                h3("Topics"),
                p(
                    "Now let’s see what different topics are covered in the program."
                ),
                plotOutput("topics"),
                p(
                    "The figure above shows the top 50 topics covered in the program. To check all 440 topics, tweak the number and offset values in the input below.
                    To view the complete list, click the 'Topics' tab in the top navigation panel"
                ),
                sliderInput(
                    "topicsNumber",
                    "Number of topics to show in graph:",
                    min = 1,
                    max = 440,
                    value = 50
                ),
                sliderInput(
                    "topicsoffset",
                    "Offset of topics to show in graph:",
                    min = 0,
                    max = 440,
                    value = 0
                ),
                p(
                    "From the figure, we can conclude Web and Machine Learning are the most used topics in GSoC. Closely behind, we have Graphics, Security,
                    Robotics, Cloud, Big Data and Data science. The fact there are 440 distinct topics used in GSoC projects shows how varied and wide the program is.
                    No matter what your interests are, you are likely to find projects with the field of your interest."
                ),
                
                
                # ----------------- Technologies ------------------
                
                h3("Technologies"),
                p(
                    "Now, let's get more deeper and see what kind of technologies are explored in the program."
                ),
                
                plotOutput("technologies"),
                
                p(
                    "The figure above shows the top 30 topics technologies in the program. To check all 271 topics, tweak the number and offset values in the input below.
                    To view the complete list, click the 'Technologies' tab in the top navigation panel"
                ),
                sliderInput(
                    "technologiesNumber",
                    "Number of topics to show in graph:",
                    min = 1,
                    max = 271,
                    value = 30
                ),
                sliderInput(
                    "technologiesoffset",
                    "Offset of topics to show in graph:",
                    min = 0,
                    max = 271,
                    value = 0
                ),
                p(
                    "As you can see in the figure above, Python, JavaScript, Java, C, and C++ are the most used languages in the program. Android, Qt, PHP,
                    MySQL, Ruby are also used a lot. Just like in Topics, in Technologies too, a wide spectrum is covered in the program, giving numerous options for students to choose from."
                ),
                
                
                # ----------------- Successful Projects ------------------
                
                h3("Successful Projects"),
                p(
                    "Now, let's see how many students were able to finish projects in each organization."
                ),
                plotOutput("projects"),
                sliderInput(
                    "projectsNumber",
                    "Number of organizations to show in graph:",
                    min = 1,
                    max = 201,
                    value = 30
                ),
                sliderInput(
                    "projectsoffset",
                    "Offset of organizations to show in graph:",
                    min = 0,
                    max = 201,
                    value = 0
                ),
                p(
                    "The figure above shows the first 30 organizations with highest number of success projects in the program. To check all 201 topics,
                    tweak the number and offset values in the input below. To view the complete list, click the 'Complete Data' tab in the top navigation panel"
                ),
                p(
                    "As you can see in the figure above, FOSSASIA had 51 successful projects last year. Closely behind there are R Project,
                    Python and KDE with more than 20 projects. It’s interesting to note there were 6 organizations with no successful projects as well."
                ),
                
                
                # ----------------- Summary ------------------
                
                h3("Summary"),
                tags$ul(
                    tags$li(
                        "Most of the organizations had projects in the fields of Web, Machine Learning, Education, Graphics and security."
                    ),
                    tags$li(
                        "Python, JavaScript, C++, Java, and C are the most used languages in GSoC organizations."
                    ),
                    tags$li(
                        "There were 6 organizations without any successful projects. This might mean no students applied to these projects,
                        or the proposals were not quality enough to be selected. This means there are projects which students totally miss when they explore and these can even be very simple projects."
                    ),
                    tags$li(
                        "There were 271 different ‘languages / frameworks / tools / technologies’ listed by the organizations.
                        Which means there are so many varied projects for students to explore covering huge spectrum of programming world."
                    )
                    
                    ),
                
                # ----------------- References ------------------
                
                h3("References"),
                tags$ul(
                    tags$li(
                        tags$a(href="https://thiloshon.wordpress.com/2017/12/30/gsoc-for-dummies/", "My supplementory blog, GSoC for Dummies!")
                    ),
                    tags$li(
                        tags$a(href="https://summerofcode.withgoogle.com", "GSoC Official Website")
                    ),
                    tags$li(
                        tags$a(href="https://thiloshon.wordpress.com/2018/01/07/screen-scraping-in-r/", "How I gathered these data?")
                    ),
                    tags$li(
                        tags$a(href="https://github.com/thiloshon/GSoC-Stats", "Project")
                    )
                )
                )
        }),
        tabPanel(
            "Topics",
            h3("Topics Data"),
            DT::dataTableOutput("topicsData")
        ),
        tabPanel(
            "Technologies",
            h3("Technologies Data"),
            DT::dataTableOutput("technologiesData")
        ),
        tabPanel(
            "Complete Data",
            h3("Complete Data"),
            DT::dataTableOutput("mytable")
        ),
        tabPanel(
            "Source Code",
            includeMarkdown("code.Rmd")
        )
            )
    )
