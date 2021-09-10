setwd("/data02/Analysis/Projects/8_Aqueos_samples/13_BEAST/Plot_SubstitutionRates")

df <- read.table("rates.list",header = TRUE, sep = "\t")
df

ggplot(
  df,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
  )
) +
  geom_boxplot(stat = "identity")

# Let us add a blank and white theme now

ggplot(
  df,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
  )
) +
  geom_boxplot(stat = "identity") + ggthemes::theme_clean()

# I want the Y-axis in the exponential form

ggplot(
  df,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
  )
) +
  geom_boxplot(stat = "identity") + scale_y_continuous(
    labels = function(x)
      format(x, scientific = TRUE)
  ) + ggthemes::theme_clean()

# Let us now increase Yaxis breakpoints
library(scales)

max_val <- max(df$HPD_interval_Upperbound)

# Let pretty breaks decide the breaks for the Y-axis
ggplot(
  df,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
  )
) +
  geom_boxplot(stat = "identity") + scale_y_continuous(
    labels = function(x)
      format(x, scientific = TRUE), breaks=pretty_breaks(),
    limits = c(0, max_val)
  ) + ggthemes::theme_clean()

# but this is not what I want. Let's try something else!

# In this plot pretty breaks function automatically breaks the axis
# n means Desired number of breaks. You may get slightly more or fewer breaks that requested

ggplot(
  df,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
  )
) +
  geom_boxplot(stat = "identity") + scale_y_continuous(
    labels = function(x)
      format(x, scientific = TRUE), breaks=breaks_pretty(n=10),
    limits = c(0, max_val)
  ) + ggthemes::theme_clean()

# Hmm. The problem with one of the species having higher mutation rate is showing the rate of other species very small boxes.
# Lets see, if we can fix this.

ggplot(
  df,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
  )
) +
  geom_boxplot(stat = "identity") + scale_y_continuous(
    labels = function(x)
      format(x, scientific = TRUE),
    breaks = c(
      0,
      0.1,
      0.01,
      0.001,
      0.0001,
      0.00001,
      0.000001,
      0.0000001,
      0.00000001,
      0.000000001,
      0.0000000001
    ),
    limits = c(0, max_val)
  ) + ggthemes::theme_clean()

# Still cannot work

# The following works! But the Y-axis is deciomal format

ggplot(
  df,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
  )
) +
  geom_boxplot(stat = "identity") + scale_y_log10() + 
  ggthemes::theme_clean()

# let's use scales:: scientific in scale

ggplot(
  df,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
  )
) +
  geom_boxplot(stat = "identity") + scale_y_log10(labels = scales::scientific) + 
  ggthemes::theme_base()

# Now, final touch ups. I do not want the Species on the x-axis rather I want a label on the box itself
# Let's make a separate labels dataset for adding the labels.

Species_labels <- c("Unknown-ST marcescens","ST131 Ecoli","ST141 K.pneumoniae","ST235 E.cloacae")
df_labs <- data.frame(df,Species_labels )
df_labs

#df2 <- df_labs %>% gather(Col, Val, -Species)

ggplot(
  df_labs,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
  )
) +
  geom_boxplot(stat = "identity") + scale_y_log10(labels = scales::scientific) + 
  ggthemes::theme_base() +
  annotate("text", x=df_labs$Species, y=df_labs$Mean, label= df_labs$Species_labels, vjust=1.7) +
 theme(axis.title.x=element_blank(), axis.text.x=element_blank()) +
  labs(x="Species",
       y="Substitution Rate (SNPs/Sites/Year)",
       title = "Mutation rate across various Enterobacterales Species")
  



# Beautification - Let's embellish!

library(showtext)
# download "Lobster Two" and save it as "lobstertwo"
font_add_google("Lobster Two", "lobstertwo")
font_add_google("Roboto", "roboto")
font_add_google("Poppins", "poppins")
showtext_auto()
theme_set(theme_bw())
theme_update(
  legend.text = element_text(size=9, family = "roboto"),
  legend.title = element_text(face="bold", size=12, family = "roboto"),
  legend.position = c(1,0),
  legend.justification = c(1, 0),
  text = element_text(family = "lobstertwo", size = 8, color = "black"),
  plot.title = element_text(family = "lobstertwo", size = 20,
                            face = "bold", color="#2a475e"),
  plot.subtitle = element_text(family = "lobstertwo", size = 15, 
                               face = "bold", color="#1b2838"),
  plot.caption = element_text(size = 10),
  plot.title.position = "plot",
  #plot.caption.position = "plot",
  axis.text = element_text(size = 10, color = "black"),
  axis.title = element_text(size=12),
  axis.ticks = element_blank(),
  axis.line = element_line(colour = "grey50"),
  rect = element_blank(),
  panel.grid = element_line(color = "#b4aea9"),
  panel.grid.minor = element_blank(),
  panel.grid.major.x = element_blank(),
  #panel.grid.major.x = element_line(linetype="dashed"),
  #panel.grid.major.y = element_blank(),
  panel.grid.major.y = element_line(linetype="dashed"),
  plot.background = element_rect(fill = '#fbf9f4', color = '#fbf9f4')
)

ggplot(
  df_labs,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
  )
) +
  geom_boxplot(stat = "identity") + scale_y_log10(labels = scales::scientific) + 
  #ggthemes::theme_base() +
  annotate("text", x=df_labs$Species, y=df_labs$Mean, label= df_labs$Species_labels, vjust=1.7) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank()) +
  labs(x="Species",
       y="Substitution Rate (SNPs/Sites/Year)",
       title = "Mutation rate across various Enterobacterales Species")

# Let's color the box for each of the species

ggplot(
  df_labs,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
    fill=Species)
) +
  geom_boxplot(stat = "identity") + scale_y_log10(labels = scales::scientific) + 
  annotate("text", x=df_labs$Species, y=df_labs$Mean, label= df_labs$Species_labels, vjust=1.7) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(),legend.position = "none") +
  labs(x="Species",
       y="Substitution Rate (SNPs/Sites/Year)",
       title = "Mutation rate across various Enterobacterales Species")

# Let us change colors by using different set of colors from the palette

ggplot(
  df_labs,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
    fill=Species)
) +
  geom_boxplot(stat = "identity") + scale_y_log10(labels = scales::scientific) + 
  annotate("text", x=df_labs$Species, y=df_labs$Mean, label= df_labs$Species_labels, vjust=1.7) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(),legend.position = "none") +
  labs(x="Species",
       y="Substitution Rate (SNPs/Sites/Year)",
       title = "Mutation rate across various Enterobacterales Species") + scale_fill_brewer(palette="Pastel2")

ggplot(
  df_labs,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
    fill=Species)
) +
  geom_boxplot(stat = "identity") + scale_y_log10(labels = scales::scientific) + 
  annotate("text", x=df_labs$Species, y=df_labs$Mean, label= df_labs$Species_labels, vjust=1.7) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(),legend.position = "none") +
  labs(x="Species",
       y="Substitution Rate (SNPs/Sites/Year)",
       title = "Mutation rate across various Enterobacterales Species") + scale_fill_brewer(palette="Accent")

ggplot(
  df_labs,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
    fill=Species)
) +
  geom_boxplot(stat = "identity") + scale_y_log10(labels = scales::scientific) + 
  annotate("text", x=df_labs$Species, y=df_labs$Mean, label= df_labs$Species_labels, vjust=1.7) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(),legend.position = "none") +
  labs(x="Species",
       y="Substitution Rate (SNPs/Sites/Year)",
       title = "Mutation rate across various Enterobacterales Species") + scale_fill_brewer(palette="Set2")

# Let's combine the plots with patchwork package

# Since , we are combining the plots, we can have combined title instead one for each. 
# See that I empty out the title in the labs

library(patchwork)

pastel2 <- ggplot(
  df_labs,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
    fill=Species)
) +
  geom_boxplot(stat = "identity") + scale_y_log10(labels = scales::scientific) + 
  annotate("text", x=df_labs$Species, y=df_labs$Mean, label= df_labs$Species_labels, vjust=1.7) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(),legend.position = "none") +
  labs(x="Species",
       y="Substitution Rate (SNPs/Sites/Year)",
       title = ""
       ) + scale_fill_brewer(palette="Pastel2")

accent <- ggplot(
  df_labs,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
    fill=Species)
) +
  geom_boxplot(stat = "identity") + scale_y_log10(labels = scales::scientific) + 
  annotate("text", x=df_labs$Species, y=df_labs$Mean, label= df_labs$Species_labels, vjust=1.7) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(),legend.position = "none") +
  labs(x="Species",
       y="Substitution Rate (SNPs/Sites/Year)",
       title = ""
       ) + scale_fill_brewer(palette="Accent")

set2 <- ggplot(
  df_labs,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
    fill=Species)
) +
  geom_boxplot(stat = "identity") + scale_y_log10(labels = scales::scientific) + 
  annotate("text", x=df_labs$Species, y=df_labs$Mean, label= df_labs$Species_labels, vjust=1.7) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(),legend.position = "none") +
  labs(x="Species",
       y="Substitution Rate (SNPs/Sites/Year)",
       title = ""
       ) + scale_fill_brewer(palette="Set2")

dark2 <- ggplot(
  df_labs,
  aes(
    x = Species,
    ymin = HPD_interval_Lowerbound,
    lower = HPD_interval_Lowerbound,
    middle = Mean,
    upper = HPD_interval_Upperbound,
    ymax = HPD_interval_Upperbound,
    fill=Species)
) +
  geom_boxplot(stat = "identity") + scale_y_log10(labels = scales::scientific) + 
  annotate("text", x=df_labs$Species, y=df_labs$Mean, label= df_labs$Species_labels, vjust=1.7) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(),legend.position = "none") +
  labs(x="Species",
       y="Substitution Rate (SNPs/Sites/Year)",
       title = ""
  ) + scale_fill_brewer(palette="Dark2")

(pastel2 + accent) / (set2 + dark2) +
  plot_layout(guides = "collect") +
  plot_annotation(
    title = "Mutation rate across various Enterobacterales Species",
    subtitle = "Box plots, top left: Pastel2 color palette; 
    top right: accent color palette;
    bottom left: Pastel2 color palette;
    bottom right: dark22 color palette") &
  theme(legend.position = "none",
        legend.justification = "center")