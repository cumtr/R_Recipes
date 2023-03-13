
#' Create an F1 offspring based on the genotype of the parents.
#'
#' Given the genotype of a dam and a sire, this function simulates the production of one F1 offspring
#' based on the principles of Mendelian genetics. The genotype of the offspring is determined by randomly
#' selecting alleles from each parent, and follows the rules of dominance and recessiveness.
#'
#' @param dam A numeric vector of length n, containing the genotype of the dam in terms of dosage values (0, 1 or 2) without missing data.
#' @param sir A numeric vector of length n, containing the genotype of the sire in terms of dosage values (0, 1 or 2) without missing data.
#' @return A numeric vector of length n, containing the genotype of the F1 offspring in terms of dosage values (0, 1 or 2).
#' @examples
#' MakeOfspring(c(1,2,0), c(0,1,1))
#' @export

MakeOfspring = function(dam=c(0,1,2), sir=c(2,1,0)){
  ## Input : 
  ## dam / sir : vectors of dosage values (0, 1 or 2) wuthout missing data
  
  # initiate 
  Child = rep(NA, length(dam))
  # parents 0/0 & 0/0
  Child[dam==sir & (dam+sir)==0] = 0
  # parents 1/1 & 1/1
  Child[dam==sir & (dam+sir)==4] = 2
  # parents 1/1 & 0/0
  Child[((dam==0 & sir==2) | (dam==2 & sir==0))] = 1
  # parents 1/1 & 1/0
  Child[((dam==1 & sir==2) | (dam==2 & sir==1))] = sample(x = c(1,2), length(Child[((dam==1 & sir==2) | (dam==2 & sir==1))]), replace = TRUE)
  # parents 1/0 & 0/0
  Child[((dam==1 & sir==0) | (dam==0 & sir==1))] = sample(x = c(0,1), length(Child[((dam==1 & sir==0) | (dam==0 & sir==1))]), replace = TRUE)
  # parents 1/0 & 1/0
  Child[(dam==1 & sir==1)] = sample(x = c(0,1,1,2), length(Child[(dam==1 & sir==1)]), replace = TRUE)
  
  # return value
  return(Child)
}

#########################################################################################################3

#' Create multiple F1 offspring based on the genotype of the parents.
#'
#' Given the genotype of a dam and a sire, this function simulates the production of multiple F1 offspring
#' based on the principles of Mendelian genetics. The genotype of each offspring is determined by randomly
#' selecting alleles from each parent, and follows the rules of dominance and recessiveness.
#'
#' @param dam A numeric vector of length n, containing the genotype of the dam in terms of dosage values (0, 1 or 2) without missing data.
#' @param sir A numeric vector of length n, containing the genotype of the sire in terms of dosage values (0, 1 or 2) without missing data.
#' @param nbOfsprings An integer specifying the number of F1 offspring to produce.
#' @return A matrix of size n x nbOfsprings, containing the genotype of the F1 offspring in terms of dosage values (0, 1 or 2).
#' @examples
#' MakeManyOfsprings(c(1,2,0), c(0,1,1), nbOfsprings = 3)
#' @export
MakeManyOfsrprings = function(dam=c(0,1,2), sir=c(2,1,0), nbOfsprings = 2){
  ## Input : 
  ## dam / sir : vectors of dosage values (0, 1 or 2) wuthout missing data
  ## nbOfsprings : Nomber of F1 ofsprings to produce
  
  Childs = c()
  for (i in 1:nbOfsprings){
    Childs = rbind(Childs, MakeOfspring(dam, sir))
  }
  return(Childs)
}



