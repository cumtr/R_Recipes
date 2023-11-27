
# Set working directry to the location of this script
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

#### Load the libraries ####

library(jsonlite)

#### Prepare the data ####

## 1. download the data
# data for aves can be found here : https://busco-data.ezlab.org/v5/data/lineages/aves_odb10.2021-02-19.tar.gz
# a list of all possible DB can be found here : https://busco-data.ezlab.org/v5/data/lineages/

# to download, Run :
# wget https://busco-data.ezlab.org/v5/data/lineages/aves_odb10.2021-02-19.tar.gz
# Then extract the file of interest :
# tar zxvf aves_odb10.2021-02-19.tar.gz aves_odb10/links_to_ODB10.txt

#### Run the R code to extract the name of the Busco Gene in the chicken "Gallus gallus"  ####

# Load the file
TableBusco = read.table("aves_odb10/links_to_ODB10.txt", sep = "\t", quote = "")
Busco_ids = TableBusco[,1]

# Loop over Busco IDs to extract the matching ID's in the Gallus gallus assembly
GenesNames = c()
for(Busco_id in Busco_ids){
  print(Busco_id)
  tmp <- read.table(paste0("https://v10.orthodb.org/tab?query=", Busco_id,"&level=&species=&universal=&singlecopy="), sep = "\t", header = TRUE, quote = "")
  Gene = tmp$pub_gene_id[tmp$organism_name=="Gallus gallus"]
  GenesNames = c(GenesNames, Gene)
}

GenesNames



