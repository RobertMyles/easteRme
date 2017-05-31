#' @export
easteR_me <- function(year = NULL, range = c(1951, 2078),
                      Corpus_Christi = FALSE, Carnaval = FALSE){

  url <- "http://www.inf.ufrgs.br/~cabral/tabela_pascoa.html"

  res <- xml2::read_html(url) %>%
    rvest::html_nodes("table") %>%
    rvest::html_table() %>%
    .[[1]] %>%
    dplyr::as_tibble() %>%
    magrittr::set_colnames(value = c("Year", "a", "b", "c", "d", "e", "d_e",
                                     "Day", "Month", "Easter",
                                     "Carnaval", "Corpus_Christi")) %>%
    dplyr::select(-a:-Month) %>%
    dplyr::slice(-1) %>%
    dplyr::mutate(Easter = gsub("/", "-", Easter),
                  Easter = gsub("mar", "03", Easter),
                  Easter = gsub("abr", "04", Easter),
                  Easter = lubridate::parse_date_time(Easter, "dmY"),
                  Carnaval = gsub("/", "-", Carnaval),
                  Carnaval = gsub("mar", "03", Carnaval),
                  Carnaval = gsub("fev", "02", Carnaval),
                  Carnaval = lubridate::parse_date_time(Carnaval, "dmY"),
                  Corpus_Christi = gsub("/", "-", Corpus_Christi),
                  Corpus_Christi = gsub("mai", "05", Corpus_Christi),
                  Corpus_Christi = gsub("jun", "06", Corpus_Christi),
                  Corpus_Christi = lubridate::parse_date_time(Corpus_Christi, "dmY"))

  # select year:

  if(!is.null(year)){
   res <- res %>% dplyr::filter(Year == year)
   if(Corpus_Christi == TRUE & Carnaval == FALSE){
     res <- res %>% dplyr::select(-Carnaval)
     return(res)
   } else if(Corpus_Christi == TRUE & Carnaval == TRUE){
     return(res)
   } else if(Corpus_Christi == FALSE & Carnaval == TRUE){
     res <- res %>% dplyr::select(-Corpus_Christi)
     return(res)
   } else{
     res <- res %>% dplyr::select(-Carnaval, -Corpus_Christi)
     return(res)
   }
  }

  # select range:

  res <- res %>% dplyr::filter(Year >= range[1], Year <= range[2])

  if(Corpus_Christi == TRUE & Carnaval == FALSE){
    res <- res %>% dplyr::select(-Carnaval)
    return(res)
    } else if(Corpus_Christi == TRUE & Carnaval == TRUE){
    return(res)
    } else if(Corpus_Christi == FALSE & Carnaval == TRUE){
      res <- res %>% dplyr::select(-Corpus_Christi)
      return(res)
    } else{
    res <- res %>% dplyr::select(-Carnaval, -Corpus_Christi)
    return(res)
    }

  return(res)
}
