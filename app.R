#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#

library(shiny)
library(bslib)
library(DT)
library(ggplot2)
library(ggpubr)
library(ggsignif)
library(DESeq2)
plotting.dds <- readRDS(gzcon(url("https://github.com/UMichNMR-Metabolomics/OVPRKidneyTranscriptomics/raw/refs/heads/main/plotting_dds.RDS")))
plottingnames <- readRDS(gzcon(url("https://github.com/UMichNMR-Metabolomics/OVPRKidneyTranscriptomics/raw/refs/heads/main/plottingnames.RDS")))
detectedgenes <- readRDS(gzcon(url("https://github.com/UMichNMR-Metabolomics/OVPRKidneyTranscriptomics/raw/refs/heads/main/detectedgenes.RDS")))
source("https://github.com/UMichNMR-Metabolomics/OVPRKidneyTranscriptomics/raw/refs/heads/main/plottingfunction.R")


# Define UI ----
ui <- page_fluid(
  title = "OVPR Kidney Transcriptomics Data Plotting Tool",
  layout_columns(
    card(
      card_header("Gene Table"),
      "Because of how the plotting function is structured, the Ensembl ID must be used when generating plots.",
      "Use this table to search by gene name or function in order to find the Ensembl ID of your target gene.",
      dataTableOutput("table",)
      ),
    card(
      card_header("Longitudinal Gene Expression Plot"),
      textInput("gene",
                "Target Gene ID",
                placeholder = "Copy & Paste Ensembl ID..."),
      textOutput("missing"),
      plotOutput("plot", height = "750px", width = "800px")
      )
    )
)

# Define server logic ----
server <- function(input, output) {
  output$table <- renderDataTable({datatable(detectedgenes)})
  output$plot <- renderPlot({
    gene <- input$gene
    transcript_plot(gene)
  })
  output$missing <- renderText({
    ifelse(any(detectedgenes == input$gene) == TRUE, 
           ifelse(any(plottingnames == input$gene) == TRUE, "", "The gene you have selected was reported in the sequencing results from the Advanced Genomics Core but was excluded from statistical analysis due to insufficient data and cannot be plotted."), 
           "The gene you have selected was not reported in the sequencing results from the Advanced Genomics Core")
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)
