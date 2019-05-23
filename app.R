library(shiny)
library(tidyverse)
library(DT)
library(extrafont)

# Pre-processing ----------------------------

# Read in csv file of resources compiled by me
reading_list <- read_csv("r_reading_list.csv")

# Create string for hyperlinks
reading_table <- reading_list %>%
  mutate(title_link =  paste0("<a href='",link,"' target='_blank'>",title,"</a>")) %>%
  select(title_link, everything(), -title, -link)

# UI -------------------------------

ui <- fluidPage(
  # formatting with css
  includeCSS("styles.css"),
  
  # Application title
  
  h2(toupper("Free R Reading Material")),
  
  # Intro text
  p("A collection of books about the R programming language and Data Science, that you can read for free!"),
  
  p("If there is a book that you think I should add to the list, then please let me know",
    a("@committedtotape", href = "https://twitter.com/committedtotape")),
  
  # DT table
  DTOutput("tbl"),
  
  br(),
  
  # credits
  div(p("Compiled by", a("@committedtotape", href = "https://twitter.com/committedtotape"), "using the shiny and DT packages"), 
      p("Blog:", a("davidsmale.netlify.com", href = "https://davidsmale.netlify.com/portfolio/")),
      p("GitHub:", a("freeR", href = "https://github.com/committedtotape/freeR")),
      style="text-align: right;")
  
  
  
)



# Server -------------------------------

server <- function(input, output) {
  
  # render DT table
  output$tbl <- renderDT({
    
    datatable(reading_table,
              colnames = c('Title', 'Author(s)', 'Description', 'Keywords/Packages'),
              rownames = FALSE,
              escape = FALSE,
              class = 'display',
              options = list(pageLength = 20,
                             lengthMenu = c(10, 20, 50))
              
    )
  })
  
}

# Run the application

shinyApp(ui = ui, server = server)

