transcript_plot <- function(targetgene){
  target <- targetgene
  hgn <- plottingnames$external_gene_name[plottingnames$ensembl_gene_id == target]
  t <- plotCounts(plotting.dds, gene = target, intgroup = c("Timepoint", "AnimalIDs"), returnData = TRUE) #Generating an object from DESeq2 that we can feed into ggplot
  blt12p <- results(plotting.dds[target,], contrast = c("Timepoint", "BL", "T12"))$padj #Finding the padj value for each comparison for the gene specified at the start of the chunk
  blt24p <- results(plotting.dds[target,], contrast = c("Timepoint", "BL", "T24"))$padj
  t12t24p <- results(plotting.dds[target,], contrast = c("Timepoint", "T12", "T24"))$padj
  mycomparisons <- list() #re-initialize the list to clear it
  mycomparisons[[1]] <- c("BL", "T12") #Populate list with the statistical comparisons we'll want to annotate
  mycomparisons[[2]] <- c("BL", "T24")
  mycomparisons[[3]] <- c("T12", "T24")
  myannotations <- "dummy" #re-initialize the character vector to clear it
  myannotations[1] <- ifelse(blt12p < 0.00001, "*****",
                             ifelse(blt12p < 0.0001, "****",
                                    ifelse(blt12p < 0.001, "***",
                                           ifelse(blt12p < 0.01, "**",
                                                  ifelse(blt12p < 0.05, "*", "NS")))))#Assigning significance indicators to my list of annotations based on the padj values for each comparison
  myannotations[2] <- ifelse(blt24p < 0.00001, "*****",
                             ifelse(blt24p < 0.0001, "****",
                                    ifelse(blt24p < 0.001, "***",
                                           ifelse(blt24p < 0.01, "**",
                                                  ifelse(blt24p < 0.05, "*", "NS")))))
  myannotations[3] <- ifelse(t12t24p < 0.00001, "*****",
                             ifelse(t12t24p < 0.0001, "****",
                                    ifelse(t12t24p < 0.001, "***",
                                           ifelse(t12t24p < 0.01, "**",
                                                  ifelse(t12t24p < 0.05, "*", "NS")))))
  geneplot <- ggplot(t, aes(x=Timepoint, y=count))+ #Actually generating the plot. The color and group assignments have to be done with the aes() for the individual geoms to avoid geom_signif choosing random crazy colors
    theme_bw()+
    geom_line(aes(color=AnimalIDs, group=AnimalIDs), linewidth = 1)+
    geom_point(aes(color=AnimalIDs, group=AnimalIDs), size = 6)+
    geom_signif(comparisons = mycomparisons, annotations = myannotations,
                step_increase = 0.1)+
    scale_color_manual(limits = c("20240411sep5", "20240515sep6", "20240625sep7", "20240731sep8"),
                       values = c("coral", "chartreuse4", "blueviolet", "mediumvioletred"))+
    labs(title=paste(hgn, "Expression in Kidney Tissue"), y="Normalized Transcript Counts", x="Timepoint", caption = target)+
    theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 20),
          axis.title = element_text(face = "bold", size = 20),
          axis.text = element_text(size = 20),
          legend.text = element_text(size = 20),
          legend.title = element_text(size = 20),
          legend.key.size = unit(1, "cm"))
  print(geneplot)
}