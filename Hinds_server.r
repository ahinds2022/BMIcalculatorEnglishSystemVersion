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
