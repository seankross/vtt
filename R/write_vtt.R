#' @importFrom purrr pmap
#' @export
write_vtt <- function(data, file = "output.vtt", header = "Header", start = "Start", end = "End",
                      content = "Content") {
  result <- pmap(list(data[[header]], data[[start]], data[[end]], data[[content]]),
                 function(header, start, end, content){
                   c("", header, paste(start, "-->", end), content)
                 }) %>% unlist()
  writeLines(c("WEBVTT", result, ""), file)
}
