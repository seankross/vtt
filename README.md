
# vtt

<!-- badges: start -->
<!-- badges: end -->

Read `.vtt` files into a data frame.

## Installation

``` r
remotes::install_github("seankross/vtt")
```

## Example


``` r
library(tidyverse)
library(vtt)

setwd("OneDrive_2_6-16-2021")

transcripts <- data.frame(File = list.files(pattern = ".vtt")) %>% 
  mutate(DF = map(File, read_vtt)) %>% 
  unnest(cols = "DF") %>% 
  extract_speaker()
  
write_csv(transcripts, "transcription_vttfiles.csv")
```

