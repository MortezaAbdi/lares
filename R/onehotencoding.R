####################################################################
#' One Hot Encoding (Dummy Variables)
#'
#' This function lets the user automatically transform a dataframe with
#' categorical columns into numerical by one hot encoding technic.
#'
#' @param df Dataframe
#' @param redundant Boolean. Should we keep redundat columns? i.e. It the
#' column only has two different values, should we keep both new columns?
#' @param summary Boolean. Print a summary of the operations?
#' @param limit Integer. Limit OHE to columns which have equal or less 
#' different values than this parameter's value. Default: 20
#' @param sep Character. Separator's string
#' @export
ohe <- function(df, redundant = FALSE, summary = TRUE, limit = 20, sep = "_") {
  
  types <- data.frame(name = colnames(df), 
                      type = unlist(lapply(lapply(df, class), `[[`, 1)))
  converted <- not_converted <- no_variance <- c()
  
  for (i in 1:ncol(df)) {
    vector_type <- types[i, "type"]
    if (!vector_type %in% c("integer","numeric","POSIXct","POSIXt","Date")) {
      vector_name <- as.character(types$name[i])
      vector_levels <- length(unique(df[,c(vector_name)]))
      vector_values <- df[toString(types[i, "name"])]
      vector_values <- vector_values %>% 
        mutate_all(as.character) %>%
        replace(., is.na(.), '.NA')
      
      # Columns with no variance
      if (vector_levels == 1) {
        no_variance <- rbind(no_variance, vector_name)
      }
      # Columns with 2 possible values
      if (vector_levels == 2) {
        df[,c(vector_name)] <- as.integer(as.factor(df[,c(vector_name)]))-1
        converted <- rbind(converted, vector_name)
      }
      # Columns with more than 2 possible values
      if (vector_levels >= 3 & vector_levels <= limit) {
        options(na.action = 'na.pass')
        #vector_values <- paste0(sep, vector_values[, 1])
        dummy_matx <- data.frame(model.matrix( ~ . -1, data = vector_values))
        if (redundant == FALSE) {
          dummy_matx <- dummy_matx[, 1:(ncol(dummy_matx)-1)]
        }
        df <- cbind(df, dummy_matx)
        converted <- rbind(converted, vector_name)
      } else {
        not_converted <- rbind(not_converted, vector_name)
      }
    }
  }
  if (summary == TRUE) {
    message(paste("One Hot Encoding applied to", length(converted), "variables:", vector2text(converted)))
    message(paste("Didn't process some variables because they had more than", limit, 
                  "unique different values:", vector2text(not_converted)))
    message(paste("Automatically dropped no variance columns:", vector2text(no_variance)))
  }
  df <- df[, c(!colnames(df) %in% c(no_variance))]
  return(df)
}