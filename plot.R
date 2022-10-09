library(readr)
hek293_wt <- read_csv("hek293_wt.csv")
v1 <- c(1: nrow(hek293_wt))
differr <- hek293_wt$differr
differr <- differr * v1
differr <- differr[-which(differr == 0)]
DRUMMER <- hek293_wt$DRUMMER * v1
DRUMMER <- DRUMMER[-which(DRUMMER == 0)]
ELIGOS <- hek293_wt$ELIGOS * v1
ELIGOS <- ELIGOS[-which(ELIGOS == 0)]
m6Anet <- hek293_wt$m6Anet * v1
m6Anet <- m6Anet[-which(m6Anet == 0)]
MINES <- hek293_wt$MINES * v1
MINES <- MINES[-which(MINES == 0)]
nanom6A <- hek293_wt$nanom6A *v1
nanom6A <- nanom6A[-which(nanom6A == 0)]

#install.packages("VennDiagram")
library(VennDiagram)
#install.packages("UpSetR")
library(UpSetR)
library(ggplot2)
png("upset_plot.png",width = 1640, height = 613)
input <- hek293_wt[,6:11]
input = as.data.frame(input)
upset_plot = upset(input, 
                   sets = c("differr",
                            "DRUMMER",
                            "ELIGOS",
                            "m6Anet",
                            "MINES",
                            "nanom6A"),
                   number.angles = 20,
                   point.size = 3.0,
                   line.size = 1,
                   mb.ratio = c(0.5, 0.5),
                   order.by = "freq",
                   text.scale = c(3.5,3.5,3,3,3,2.6),
                   mainbar.y.label = "Position Intersections", 
                   sets.x.label = "",
                   queries = list(
                     list(
                       query = intersects,
                       params = list("nanom6A", "m6Anet"),
                       color = "blue",
                       active = T),
                     list(
                       query = intersects,
                       params = list("nanom6A", "m6Anet","MINES"),
                       color = "blue",
                       active = T),
                     list(
                       query = intersects,
                       params = list("MINES", "m6Anet"),
                       color = "blue",
                       active = T)
                   )
)
print(upset_plot)
dev.off()
venn.plot <- venn.diagram(
  list(nanom6A = nanom6A, MINES = MINES, m6Anet = m6Anet),
  filename = "venn_plot.png",
  col = "black", 
  cex = 1.5,
  fontface = "bold",
  fill = c("dodgerblue", "goldenrod1", "darkorange1"), 
  alpha = 0.50, 
  cat.col = c("darkblue", "darkgreen", "orange"), 
  cat.cex = 1.5, 
  cat.fontface = "bold", 
  cat.dist = c(0.085, 0.085, 0.055),
  margin = 0.05
)
