#' Get the minimum and maximum combinations from pmapply matrix
#'
#' @param combo_mat a matrix generated from `pmapply`
#'
#' @return a list object of class 'minmaxCombo'
#' @export
#'
#' @examples
#'\dontrun{
#' cormat <- pmapply(iris[,c(1:4)], function(x, y) cor(x, y))
#' get_minmax_combos(cormat)
#'}
get_minmax_combos <- function(combo_mat) {
  n <- dimnames(combo_mat)
  rn <- n[[1]]
  cn <- n[[2]]
  vout <- combo_mat
  for(i in 1:nrow(combo_mat)) {
    for(j in 1:ncol(combo_mat)) {
      if (rn[i] == cn[j]) {
        vout[i,j] <- NA
      }
    }
  }
  maxv <- max(vout, na.rm = TRUE)
  maxv <- which(combo_mat == maxv, arr.ind = TRUE)
  if (nrow(maxv) > 2) warning("Multiple combinations have max value. Returning first combination.")
  minv <- min(vout, na.rm = TRUE)
  minv <- which(combo_mat == minv, arr.ind = TRUE)
  if (nrow(minv) > 2) warning("Multiple combinations have min value. Returning first combination.")
  out <- list(max_combo = paste(rn[maxv[1,1]], cn[maxv[1,2]], sep = " - "),
              max_value = combo_mat[maxv[1,1], maxv[1,2]],
              min_combo = paste(rn[minv[1,1]], cn[minv[1,2]], sep = " - "),
              min_value = combo_mat[minv[1,1], minv[1,2]]
  )
  # class(out) <- c("minmaxCombo", class(out))
  out
}
