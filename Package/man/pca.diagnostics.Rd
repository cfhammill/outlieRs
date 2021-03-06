% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pca.diagnostics.R
\name{pca.diagnostics}
\alias{pca.diagnostics}
\title{Quick PCA diagnostics for outlier detection.}
\usage{
pca.diagnostics(X, center = T, scale = T, ellipse.alpha = 0.95,
  quantile.alpha = 0.75, graphs = T)
}
\arguments{
\item{X}{Data matrix}

\item{center}{a boolean, vector, or string. See ?expo.scale for details.}

\item{scale}{a boolean, vector, or string. See ?expo.scale for details.}

\item{ellipse.alpha}{the alpha level for classic and robust ellipses (around MD and CD)}

\item{quantile.alpha}{the alpha level for quantile cutoffs (for MD an CD)}

\item{graphs}{a boolean. If TRUE, two graphs will be shown.}
}
\value{
A list with two lists: ellipse.outliers and quantile.outliers.
\item{ellipse.outers}{ a list with two boolean vectors: robust.outs and classic.outs. Outliers detected from the ellipse intervals around Mahalanonbis vs. Chi-squared distances. If an observation is an outlier, they are denoted as TRUE in either vector.}
\item{quantile.outliers}{ a list with two boolean vectors: robust.outs and classic.outs. Outliers detected from the quantile intervals of Mahalanonbis vs. Chi-squared distances. If an observation is an outlier, they are denoted as TRUE in either vector.}
}
\description{
Quick PCA diagnostics for outlier detection.
}
\examples{
 data(beer.tasting.notes)
 the.data <- expo.scale(beer.tasting.notes$data)
 the.data_corrected_for_ABV <- apply(the.data,2, function(x){ resid(lm(x~beer.tasting.notes$sup.data[,"ABV"])) } )
 beer.diagnostics.res <- pca.diagnostics(the.data,center = F,scale = F)
 beer.corrected.diagnostics.res <- pca.diagnostics(the.data_corrected_for_ABV,center = F,scale = F)

}

