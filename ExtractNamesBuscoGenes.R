#### Orginal version avaialble at https://github.com/cumtr/R_Recipes/edit/master/ExtractNamesBuscoGenes.R ####

# This script retrieve the BUSCO genes present in a given annotation made by the NCBI.
# The curent version retrieve the BUSCO genest for birds (aves_odb10) in the genome of the Barn Owl (GCF_018691265.1_T.alba_DEE_v4.0)

#### Set working directry to the location of this script ####

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

#### Load the libraries ####

library(jsonlite)

#### Prepare the data ####

## 1. download the data for the BUSCO genes for birds
# data for aves can be found here : https://busco-data.ezlab.org/v5/data/lineages/aves_odb10.2021-02-19.tar.gz
# a list of all possible DB can be found here : https://busco-data.ezlab.org/v5/data/lineages/

# to download, Run :
# wget https://busco-data.ezlab.org/v5/data/lineages/aves_odb10.2021-02-19.tar.gz
# Then extract the file of interest :
# tar zxvf aves_odb10.2021-02-19.tar.gz aves_odb10/links_to_ODB10.txt

## 2. download the annotation infromations from NCBI
# mkdir 0_DATA
# wget -P 0_DATA https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/018/691/265/GCF_018691265.1_T.alba_DEE_v4.0/GCF_018691265.1_T.alba_DEE_v4.0_feature_table.txt.gz
# gunzip 0_DATA/GCF_018691265.1_T.alba_DEE_v4.0_feature_table.txt.gz
# awk '$1=="gene"' 0_DATA/GCF_018691265.1_T.alba_DEE_v4.0_feature_table.txt > 0_DATA/GCF_018691265.1_T.alba_DEE_v4.0_feature_table_genes.txt

#### Run the R code to extract the name of the Busco Gene in the chicken "Gallus gallus"  ####

# Load the file
TableBusco = read.table("aves_odb10/links_to_ODB10.txt", sep = "\t", quote = "")
Busco_ids = TableBusco[,1]

# DO NOT USE /// Loop over Busco IDs to extract the matching ID's in the Gallus gallus assembly
# GenesNames = c()
# for(Busco_id in Busco_ids){
#   print(Busco_id)
#   tmp = read.table(paste0("https://v10.orthodb.org/tab?query=", Busco_id,"&level=&species=&universal=&singlecopy="), sep = "\t", header = TRUE, quote = "")
#   Gene = tmp$pub_gene_id[tmp$organism_name=="Gallus gallus"]
#   GenesNames = c(GenesNames, Gene)
# }

# Loop over Busco IDs to extract all possible names of this gene
GenesNamesAll = c()
for(Busco_id in Busco_ids){
  print(Busco_id)
  tmp = read.table(paste0("https://v10.orthodb.org/tab?query=", Busco_id,"&level=&species=&universal=&singlecopy="), sep = "\t", header = TRUE, quote = "")
  Gene = unique(tmp$pub_gene_id)
  GenesNamesAll = c(GenesNamesAll, Gene)
}

#### Identify the genes present in our assemby ####

# Load the file
GenesBarnOwl = read.table("0_DATA/GCF_018691265.1_T.alba_DEE_v4.0_feature_table_genes.txt", sep = "\t", quote = "")

# BUSCOgenesBarnOwl = GenesNames[GenesNames%in%GenesBarnOwl$V15]
BUSCOgenesBarnOwl = GenesNamesAll[GenesNamesAll%in%GenesBarnOwl$V15]

TabBUSCO_Owl = GenesBarnOwl[GenesBarnOwl$V15%in%BUSCOgenesBarnOwl,c(15, 7, 8, 9)]
colnames(TabBUSCO_Owl) = c("GeneID", "Chr", "Start", "Stop")

# Export a table with the gene ID and it's coordinates
write.table(TabBUSCO_Owl, "BUSCOgenesBarnOwl.txt", row.names = FALSE, quote = FALSE)

#### EOF ####
