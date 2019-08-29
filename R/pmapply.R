#' Apply a function between pairs of vectors
#'
#' @param x a list or data frame
#' @param FUN the function to be applied between all possible pairs of vectors passed to ...
#' @param show Whether to display upper or lower triangle of values--either 'all', 'upper', or 'lower'
#'
#' @return a matrix
#' @export
#'
#' @examples
#' samples <- replicate(3, sample(LETTERS, 20, replace = TRUE))
#' l <- list(samples[,1], samples[,2], samples[,3])
#' pmapply(l)
#' pmapply(iris[,c(1:4)], function(x, y) cor(x, y))
#' pmapply(iris[,c(1:4)], function(x, y) sum(x < y))
pmapply <- function(x, FUN = function(x, y) sum(x %in% y), show = "all") {
  stopifnot(show %in% c("all", "lower", "upper"))
  if (!is.list(x)) x <- as.list(x)
  ll <- length(x)
  m <- matrix(NA, nrow = ll, ncol = ll)
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
