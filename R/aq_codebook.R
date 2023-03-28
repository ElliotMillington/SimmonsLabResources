#' AQ Codebook
#'
#' A codebook to assist with the analysis of the Autism Spectrum Quotient from Baron-Cohen et al (2001)
#'
#' @format A data frame with 50 rows and 6 variables
#' \describe{
#'   \item{question_number}{The question number in the original AQ questionnaire}
#'   \item{aq_10_question_number}{The question number in the AQ-10. NA if not in the AQ-10}
#'   \item{subscale}{The subscale that the question measures}
#'   \item{abbr_subscale}{An abbreviated name of the subscale}
#'   \item{reversed}{Whether or not the item should be reversed when scoring}
#'   \item{question_text}{The full text of the item for string matching}
#' }
"aq_codebook"
