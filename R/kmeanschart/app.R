library(shiny)
library(shinydashboard)




ui <- fluidPage(
  titlePanel("K-means Image Compression"),
  ## Sidebar content
  # sidebarPanel(),
  ## Body content
  mainPanel(
    fluidRow(
      column(6,
             h4("Compressed"),
             imageOutput("myImage",width="100%",height="100%",inline=TRUE),
             h5(textOutput("size",inline=TRUE), "bytes")),
      column(6,
             h4("Original (16,777,216 colors)"),
             imageOutput("origImage",width="100%",height="100%",inline=TRUE),
             h5(textOutput("sizeorig",inline=TRUE),"bytes"))),
    
    
    fluidRow(
      
      box(
        
        sliderInput(animate = animationOptions(interval=200),"slider", "Number of colors:", 1, 256, 1)) 
      
    )
  )
)




server <- function(input, output) {
  output$myImage <- renderImage({
    # A temp file to save the output.
    # This file will be removed later by renderImage
    filename <- normalizePath(file.path('./images',
                                        paste('img', input$slider, '.png', sep='')))
    
    
    # Return a list containing the filename
    list(src = filename,width=256,height=256,
         alt = paste("Image number", input$slider))
  }, deleteFile = FALSE)
  
  output$origImage <- renderImage({
    # A temp file to save the output.
    # This file will be removed later by renderImage
    filename2 <- normalizePath(file.path('./images',
                                         'bird_small.png'))
    
    
    # Return a list containing the filename
    list(src = filename2,width=256,height=256,
         alt = "Original Image")
  }, deleteFile = FALSE)
  
  output$size <- reactive(as.character(file.size(normalizePath(file.path('./images',
                                                                         paste('img', input$slider, '.png', sep=''))))))
  
  output$sizeorig <- reactive(as.character(file.size(normalizePath(file.path('./images',
                                                                             "bird_small.png")))))
  
  
  normalizePath(file.path('./images',"bird_small.png"))
}







shinyApp(ui, server)