#' Create a data frame with APA rules formated coefficient informations 
#' of a linear model
#' 
#' @param model A linear model created using lm().
#'
#' @export

#' @importFrom broom tidy

apastylr <- function(model, statistics = "t") {
  if (!requireNamespace("broom", quietly = TRUE)) {
    stop("broom needed for this function to work. Please install it.",
         call. = FALSE)
  } 
  
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("dplyr needed for this function to work. Please install it.",
         call. = FALSE)
  }
  
  if(!class(model) == "lm") {
    stop("model must be a linear model created with lm",
         call. = FALSE)
  }
  
  summary <- broom::tidy(model)
  
  summary$APA <- paste0("t(",
                        model$df.residual,
                        ") = ",
                        format(abs(round(summary$statistic, 2)), nsmall = 2),
                        ", p ",
                        ifelse(summary$p.value < .001,
                               "< .001",
                               paste0("= ",
                                      sub(".", "",
                                          format(round(summary$p.value, 3), nsmall = 3)))))

  summary <- data.frame(Term = summary$term,
                        APA  = summary$APA)
  
  return(summary)
}
