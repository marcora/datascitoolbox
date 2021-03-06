best <- function(state, outcome) {
  
  ## Read outcome data
  data = read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## column 2 = hospital name
  ## column 7 = state
  ## column 11 = 30-day death rate for 'heart attack' outcome
  ## column 17 = 30-day death rate for 'heart failure' outcome
  ## column 23 = 30-day death rate for 'pneumonia' outcome
  
  ## Check that state and outcome are valid
  states = unique(data[, 7])

  if(! state %in% states) {
    stop("invalid state")    
  } 
  
  outcomes = c('heart attack', 'heart failure', 'pneumonia')

  if(! outcome %in% outcomes) {
    stop("invalid outcome")    
  } 
  
  ## Return hospital name in that state with lowest 30-day death rate for that outcome
  cols = c(11, 17, 23)
  names(cols) = outcomes
  col = cols[outcome] # col for that outcome
  data = data[data[, 7] == state, ] # filter by that state
  data[, col] <- as.numeric(data[, col]) # convert death rate to numeric for proper sorting
  data = data[order(data[, col], data[, 2]), ] # sort by death rate and hospital name
  data[1, 2] # return name of first hospital
}
