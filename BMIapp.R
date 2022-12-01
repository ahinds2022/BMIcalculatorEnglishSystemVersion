

library(shiny)
library(shinythemes)

ui <- fluidPage(theme = shinytheme("cosmo"),
                navbarPage("BMI Calculator:",
                           
                           tabPanel("Home",
                                    # Input values
                                    sidebarPanel(
                                      HTML("<h3>Input parameters</h3>"),
                                      sliderInput("height", 
                                                  label = "Height in inches", 
                                                  value = 70, 
                                                  min = 60, 
                                                  max = 80, 
                                                  step =1),
                                      sliderInput("weight", 
                                                  label = "Weight in pounds", 
                                                  value = 200, 
                                                  min = 100, 
                                                  max = 300,
                                                  step = 5),
                                      
                                      actionButton("submitbutton", 
                                                   "Submit", 
                                                   class = "btn btn-primary")
                                    ),
                                    
                                    mainPanel(
                                      tags$label(h3('Status/Output')), # Status/Output Text Box
                                      verbatimTextOutput('contents'),
                                      tableOutput('tabledata') # Results table
                                    ) # mainPanel()
                                    
                           ), #tabPanel(), Home
                           
                           tabPanel("About", 
                                    titlePanel("About"), 
                                    div(includeMarkdown("about.md"), 
                                        align="justify")
                           ) #tabPanel(), About
                           
                ) # navbarPage()
) # fluidPage()


server <- function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    
    bmi <- input$weight*0.45455/( (input$height *.0254) ^2 )
    bmi <- data.frame(bmi)
    names(bmi) <- "BMI"
    print(bmi)
    
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Calculation complete.") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
}


shinyApp(ui = ui, server = server)
