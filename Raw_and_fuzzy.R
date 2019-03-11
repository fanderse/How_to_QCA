library(shiny)
library(httr)
library(xlsx)
library(QCApro)

data_x <- c(50.91, 52.71, 52.71, 52.71, 52.71, 19.76, 19.76, 26.14, 31.95,          
            40.63, 48.65, 27.59, 0.00, 0.00, 0.00, 25.75, 25.75, 25.75,
            25.84, 27.54, 61.78, 67.66, 63.00, 78.74, 100.00, 6.00, 2.09,
            0.00, 0.00, 0.00, 49.59, 40.76, 0.00, 0.00, 0.00, 0.00,
            0.00, 0.00, 19.21, 77.90, 100.00, 100.00, 100.00, 96.44, 0.00,
            16.67,   7.03,   0.00,  0.00,   0.00,  11.90,  11.90,  11.90,  33.31,
            52.38,   0.00,   0.00,   0.00,   0.00,  62.84, 100.00, 100.00,  37.81,
            0.00,   0.00,   0.00,  20.27, 100.00,  94.98,  36.73,  96.76, 100.00,
            40.55,   0.00,   0.00,   6.95,   6.96,   7.11,  27.16,  32.75,  33.88,
            0.00,   0.00,   0.00,   0.00 , 62.95,   0.00,   0.00,   0.00,   4.24,
            36.81,  36.81,  35.29,  33.38,  33.38,  33.38,   0.00,   0.00,   0.00,
            0.00,   0.00,   0.00,   0.00,   0.00,   0.00,   0.00,  41.28,  41.28,
            5.65,   0.00,   7.49,  87.38,  87.35,  87.23,  87.23,  87.23,  12.86,
            12.86,  12.86,  12.75,  11.94, 100.00, 100.00, 100.00,  46.85,   0.00,
            1.34,  36.56,   3.07 ,  9.34 , 43.19,  58.82 , 58.82 , 30.46,   0.00,
            74.32,  80.53,  71.94,  71.94,  79.46,  77.35,   0.00,   0.00,   0.00,
            0.00,   0.00)

# Define UI for app that draws the plot  ----
ui <- fluidPage(

        # App title ----
        titlePanel("QCA Automatic Transformation"),

        # Sidebar layout with input and output definitions ----
        sidebarLayout(

                # Sidebar panel for inputs ----
                sidebarPanel(

                        # Input: Buttons ----
                        numericInput(inputId = "logistic",
                                     label = "Logistisch? (1 oder 0)",
                                     value = "0"),

                        numericInput(inputId = "lower_th",
                                     label = "fuzzyscore = 0",
                                     value = "14.765"),
                        numericInput(inputId = "middle_th",
                                     label = "fuzzyscore = 0.5",
                                     value = "39.180"),
                        numericInput(inputId = "upper_th",
                                     label = "fuzzyscore = 1",
                                     value = "75.835")

                ),

                # Main panel for displaying outputs ----
                mainPanel(

                        # Output: Scatterplot ----
                        plotOutput(outputId = "relPlot")

                )
        )
)



# Define server logic required to the plot ----
server <- function(input, output) {

        output$relPlot <- renderPlot({

                y   <- calibrate(data_x,
                                 type = "fuzzy",
                                 thresholds = c(input$lower_th, input$middle_th, input$upper_th),
                                 logistic = input$logistic)

                x    <- data_x

                plot(x, y, col = "#75AADB",
                     xlab = "Rohwerte",
                     ylab = "fuzzy-scores")

        })

}


# Run the application
shinyApp(ui = ui, server = server)

