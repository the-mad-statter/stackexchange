library(XML)
library(rentrez)
library(dplyr) 

#get xml (currently, just two articles)
testa <- entrez_search(db="pubmed", term="38863400 OR 32029379", use_history=TRUE)
testa_rec <- entrez_fetch(db="pubmed", id=testa$ids, rettype="xml", parsed=TRUE)

# Function to extract the required information
extract_info <- function() { 
  indexing <- xpathApply(testa_rec, "//MedlineCitation", xmlGetAttr, "IndexingMethod")
  date <- xpathApply(testa_rec, "//DateRevised", xmlValue)
  pmid <- xpathApply(testa_rec, "//PMID", xmlValue)
  mesh <- xpathSApply(testa_rec, "//MeshHeading", xmlValue)
  
  #check for null (though this might be unnecessary)
  if (is.null(pmid)) pmid <- NA 
  if (is.null(indexing)) indexing <- NA 
  if (is.null(date)) date <- NA
  if (is.null(mesh)) mesh <- NA
  
  #add to tibble
  tibble(
    pmid = pmid, 
    indexing = indexing,
    date = date, 
    mesh = paste(mesh, collapse = ";")
  )
}

# Apply the extract_info function to each MedlineCitation node
results_list <- extract_info()

# Bind the results into a single tibble
bind_rows(results_list)
