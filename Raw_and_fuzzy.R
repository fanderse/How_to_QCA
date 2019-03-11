library(shiny)

data <- 


# Define UI for app that draws a histogram ----
ui <- fluidPage(

        # App title ----
        titlePanel("How to QCA"),

        # Sidebar layout with input and output definitions ----
        sidebarLayout(

                # Sidebar panel for inputs ----
                sidebarPanel(

                        # Input: Action button ----
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

                        # Output: Histogram ----
                        plotOutput(outputId = "relPlot")

                )
        )
)



# Define server logic required to draw a histogram ----
server <- function(input, output) {

        # Histogram of the Old Faithful Geyser Data ----
        # with requested number of bins
        # This expression that generates a histogram is wrapped in a call
        # to renderPlot to indicate that:
        #
        # 1. It is "reactive" and therefore should be automatically
        #    re-executed when inputs (input$bins) change
        # 2. Its output type is a plot
        output$relPlot <- renderPlot({

                y   <- calibrate(data$GOV_LEFT2,
                                 type = "fuzzy",
                                 thresholds = c(input$lower_th, input$middle_th, input$upper_th),
                                 logistic = input$logistic)

                x    <- data$GOV_LEFT2

                plot(x, y, col = "#75AADB",
                     xlab = "Rohwerte",
                     ylab = "fuzzy-scores")

        })

}


# Run the application
shinyApp(ui = ui, server = server)

