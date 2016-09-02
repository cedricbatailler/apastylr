#' Create a data frame with APA rules formated coefficient informations 
#' of a linear model
#' 
#' @param model A linear model created using lm().
#' @param statistics Reports student's t ("T") or Fisher's F ("F").
#'
#' @export

#' @importFrom broom tidy

apastylr <- function(model, statistics = "T") {
  if (!requireNamespace("broom", quietly = TRUE)) {
    stop("broom needed for this function to work. Please install it.",
         call. = FALSE)
  }
  
  if(!class(model) == "lm") {
    stop("model must be a linear model created with lm",
         call. = FALSE)
  }
  
  # Cleaning model
  
  summary <- broom::tidy(model)
  
  # Creating temprary table for treatment
  
  table <- data.frame(term = summary$term)
  
  # Get F and T statistics and degree of freedom
  
  table$t <- format(abs(round(summary$statistic, 2)), nsmall = 2)
  table$f <- format(abs(round(summary$statistic^2, 2)), nsmall = 2)
  table$df <- model$df.residual
  
  # Get pvalue as APA formatted text and as number
  
  table$pvalue_nb <- summary$p.value
  table$pvalue_txt <- sub(".", "", format(round(summary$p.value, 3), nsmall = 3))
  
  # Creating text for each coefficient according to statistic
  # parameter, either t or F
  
  if(statistics == "T") {
    table$stattext <- paste0("t(", table$df, ") = ", table$t)
  } else if(statistics == "F") {
    table$stattext <- paste0("F(1, ", table$df, ") = ", table$f)
  } else {
    stop("statistics parameter must be either \"T\" or \"F\".",
         call. = FALSE);
  }
  
  # Creating p-value text for each coefficient
  
  table$pvaluetext <- ifelse(table$pvalue_nb < .001,
                   "p < .001",
                   table$pvalue_txt)

  table$APA <- paste0(table$stattext, ", ", table$pvaluetext)

  # Creating APA formatted summary
  
  summary <- data.frame(Term = table$term,
                        APA  = table$APA)
  
  # Returning APA formated summary
  
  return(summary)
}
