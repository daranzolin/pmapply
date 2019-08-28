#' Apply a function between pairs of vectors
#'
#' @param FUN the function to be applied between all possible pairs of vectors passed to ...
#' @param show Whether to display upper or lower triangle of values--either 'all', 'upper', or 'lower'
#' @param ... named or unnamed vectors
#'
#' @return a matrix
#' @export
#'
#' @examples
#' samples <- replicate(3, sample(LETTERS, 20, replace = TRUE))
#' sui <- function(x, y) sum(unique(x) %in% unique(y))
#' sm <- cmapply(s1 = samples[,1], s2 = samples[,2], s3 = samples[,3], FUN = sui)
cmapply <- function(FUN = function(x, y) sum(x %in% y), show = "all", ...) {
  stopifnot(show %in% c("all", "lower", "upper"))
  x <- list(...)
  m <- matrix(NA, nrow = length(x), ncol = length(x))
  if (!is.null(names(x))) {
    n <- names(x)
    colnames(m) <- n
    rownames(m) <- n
  }
  for(i in 1:nrow(m)) {
    for(j in 1:ncol(m)) {
      m[i, j] <- FUN(x[[i]], x[[j]])
    }
  }
  out <- m
  if (show %in% c("lower", "upper")) {
    show_func <- switch(show,
                        "upper" = lower.tri,
                        "lower" = upper.tri
    )
    out[show_func(m)] <- 0
  }
  out
}
