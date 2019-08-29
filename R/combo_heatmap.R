#' Plot heatmap result of pmapply
#'
#' @param combo_mat a matrix generated from `pmapply`
#' @param gradient_low color for low values
#' @param gradient_high color for high values
#'
#' @return
#' @export
#'
#' @examples
#'\dontrun{
#' samples <- replicate(3, sample(LETTERS, 20, replace = TRUE))
#' sm <- pmapply(s1 = samples[,1], s2 = samples[,2], s3 = samples[,3])
#' combo_heatmap(sm)
#'}
combo_heatmap <- function(combo_mat, gradient_low = "lightgrey", gradient_high = "red") {
  mm <- get_minmax_combos(combo_mat)
  pd <- reshape2::melt(combo_mat)
  p <- ggplot2::ggplot(pd, ggplot2::aes(x = Var2, y = Var1)) +
    ggplot2::geom_raster(ggplot2::aes(fill = value)) +
    ggplot2::scale_fill_gradient(low = gradient_low,
                                 high = gradient_high,
                                 limits = c(mm$min_value, mm$max_value)
                                 )
  print(p)
  invisible(p)
}
