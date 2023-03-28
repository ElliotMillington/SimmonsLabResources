#' GSQ Codebook
#'
#' A codebook to assist with the analysis of the Glasgow Sensory Questionnaire from Robertson and Simmons (2013)
#'
#' @format A data frame with 42 rows and 6 variables
#' \describe{
#'   \item{question_number}{The original question number in the original GSQ}
#'   \item{gsq_14_question_number}{The question number in the GSQ-14}
#'   \item{modality}{The sense that the question is referring to}
#'   \item{abbr_mod}{An abbreviated name for the modality}
#'   \item{direction}{Whether the item question is testing hyper- or hypo- reactivity}
#'   \item{question_text}{The full text of the item for string matching}
#' }
"gsq_codebook"
