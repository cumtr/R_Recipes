
# Function to Simulate diploid F1 offsprings from dosage data from dosage data of diploid parents

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

##### test Section #####

Ind1 = sample(x = c(0,1,2), 10000, replace = TRUE)
Ind2 = sample(x = c(0,1,2), 10000, replace = TRUE)

MakeOfspring(Ind1, Ind2)
MakeManyOfsrprings(Ind1, Ind2, 20)




