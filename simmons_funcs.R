#Load the AQ Codebook
get_aq_codes = function(path="AQ_Codebook.csv") {
  if (!exists("aq_codebook")) {
    aq_codebook = readr::read_csv(path)
    .GlobalEnv$aq_codebook = aq_codebook
  }
  return(aq_codebook)
}

#Load the GSQ Codebook
get_gsq_codes = function(path="GSQ_Codebook.csv") {
  if (!exists("gsq_codebook")) {
    gsq_codebook = readr::read_csv(path)
    .GlobalEnv$gsq_codebook = gsq_codebook
  }
  return(gsq_codebook)
}

#Simulate an example data frame for the AQ
sim_aq_dataset = function(n, wideOrLong="long") {
  aq_codes = get_aq_codes() |> 
    dplyr::select(Question_Number, Subscale, Reversed)
  
  aq_codes = aq_codes[rep(seq_len(nrow(aq_codes)), times = n), ]
  aq_codes$id = rep(1:n, each = 50)
  aq_codes$dv = sample(c(0:3), nrow(aq_codes), replace = TRUE)
  
  if (wideOrLong == "wide") {
    aq_codes = tidyr::unite(aq_codes, "Question",
                            Subscale, Question_Number, sep = "_") |> 
      tidyr::pivot_wider(id_cols = id, names_from = Question, values_from = dv)
  }
  
  return(aq_codes)
}

#Simulate an example data frame for the GSQ
sim_gsq_dataset = function(n, wideOrLong="long") {
  gsq_codes = get_gsq_codes() |> 
    dplyr::select(Question_Number, Modality, Direction)
  
  gsq_codes = gsq_codes[rep(seq_len(nrow(gsq_codes)), times = n), ]
  gsq_codes$id = rep(1:n, each = 42)
  gsq_codes$dv = sample(c(0:4), nrow(gsq_codes), replace = TRUE)
  
  if (wideOrLong == "wide") {
    gsq_codes = tidyr::unite(gsq_codes, "Question",
                            Modality, Direction, Question_Number, sep = "_") |> 
      tidyr::pivot_wider(id_cols = id, names_from = Question, values_from = dv)
  }
  
  return(gsq_codes)
}

#Reverse codes AQ responses using long data
reverse_code_aq = function(data) {
  reverse_code = 3:0
  coded_data = data |> 
    dplyr::mutate(dv = ifelse(Reversed, reverse_code[dv+1], dv))
  return(coded_data)
}

score_total = function(data) {
  scored_data = data |> 
    dplyr::group_by(id) |> 
    dplyr::summarise(Score = sum(dv))
  return(scored_data)
}

#Scores long format AQ data into subscales
score_aq_subscales = function(data) {
  scored_data = data |> 
    dplyr::group_by(id, Subscale) |> 
    dplyr::summarise(Score = sum(dv))
  return(scored_data)
}

#Scores long format GSQ data into subscales
score_gsq_subscales = function(data) {
  scored_data = data |> 
    dplyr::group_by(id, Modality, Direction) |> 
    dplyr::summarise(Score = sum(dv)) |> 
    tidyr::unite("Subscale", Modality, Direction)
  return(scored_data)
}

#Scores long format AQ data
score_aq = function(data) {
  total_dat = score_total(data)
  total_dat$Subscale = "Total"
  subscale_dat = score_aq_subscales(data)
  scored_dat = rbind(total_dat, subscale_dat) |> 
    dplyr::arrange(id)
  return(scored_dat)
}

#Scores long format GSQ data
score_gsq = function(data) {
  total_dat = score_total(data)
  total_dat$Subscale = "Total"
  subscale_dat = score_gsq_subscales(data)
  scored_dat = rbind(total_dat, subscale_dat) |> 
    dplyr::arrange(id)
  return(scored_dat)
}
