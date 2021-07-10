#' @importFrom stringr str_trim
#' @importFrom purrr map2 map_dfr
#' @export
read_vtt <- function(path) {
  transcript <- str_trim(readLines(path))[-1]

  if(transcript[length(transcript)] != "") {
    transcript <- c(transcript, "")
  }

  blank_lines <- which(transcript == "")
  extra_blank_lines <- NULL

  for (i in seq_along(blank_lines)) {
    if(i > 1 && blank_lines[i - 1] == blank_lines[i] - 1) {
      extra_blank_lines <- c(extra_blank_lines, blank_lines[i])
    }
  }

  if(!is.null(extra_blank_lines)) {
    transcript <- transcript[-extra_blank_lines]
  }

  blank_lines <- which(transcript == "")
  first_lines <- blank_lines[-length(blank_lines)] + 1
  last_lines <- blank_lines[-1] - 1

  map2(first_lines, last_lines, ~ transcript[.x:.y]) %>%
    map_dfr(function(x) {
      time_line <- grep("-->", x)

      if(time_line > 1) {
        header <- paste(x[1:(time_line - 1)], collapse = " ")
      } else {
        header <- NA
      }

      time_vec <- strsplit(x[time_line], "\\s+")[[1]]

      start_content <- time_line + 1
      end_content <- length(x)
      content <- paste(x[start_content:end_content], collapse = " ")

      data.frame(Header = header, Start = time_vec[1],
                 End = time_vec[3], Content = content)
    })
}
