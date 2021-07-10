#' @export
extract_speaker <- function(data, column = "Content") {
  speaker <- data[[column]] %>%
    str_extract_all("^.*:\\s*", simplify = TRUE) %>%
    as.vector()

  content <- map2_chr(speaker, data[[column]], function(x, y) {
    if(x != "") {
      str_replace(y, x, "")
    } else {
      y
    }
  })

  speaker[str_trim(speaker) == ""] <- NA

  data[[column]] <- NULL
  data[["Speaker"]] <- str_trim(speaker)
  data[[column]] <- str_trim(content)
  data
}
