% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clusters.R
\name{clusterKmeans}
\alias{clusterKmeans}
\title{Automated K-Means Clustering + PCA}
\usage{
clusterKmeans(
  df,
  k = NA,
  limit = 20,
  drop_na = TRUE,
  ignore = NA,
  ohse = TRUE,
  norm = TRUE,
  comb = c(1, 2),
  seed = 123
)
}
\arguments{
\item{df}{Dataframe}

\item{k}{Integer. Number of clusters}

\item{limit}{Integer. How many clusters should be considered?}

\item{drop_na}{Boolean. Should NA rows be removed?}

\item{ignore}{Character vector. Which columns should be excluded
when calculating kmeans?}

\item{ohse}{Boolean. Do you wish to automatically run one hot
encoding to non-numerical columns?}

\item{norm}{Boolean. Should the data be normalized?}

\item{comb}{Vector. Which columns do you wish to plot? Select which
two variables by name or column position.}

\item{seed}{Numeric. Seed for reproducibility}
}
\description{
This function lets the user cluster a whole data.frame automatically.
As you might know, the goal of kmeans is to group data points into 
distinct non-overlapping subgroups. If needed, one hot encoding will 
be applied to categorical values automatically with this function. 
For consideration: Scale/standardize the data when applying kmeans.
Also, kmeans assumes spherical shapes of clusters and doesn’t work well 
when clusters are in different shapes such as elliptical clusters.
}
\examples{
options("lares.font" = NA) # Temporal
data(dft) # Titanic dataset
df <- subset(dft, select = -c(Ticket, PassengerId))

# Find optimal k
check_k <- clusterKmeans(df)
check_k$nclusters_plot

# Run with selected k
clusters <- clusterKmeans(df, k = 3)
names(clusters)

# Cross-Correlations for each cluster
plot(clusters$correlations)

# PCA Results
plot(clusters$PCA$plotVarExp)
plot(clusters$PCA$plot_1_2)

\dontrun{
# 3D interactive plot
clusters$PCA$plot_1_2_3
}
}
\seealso{
Other Machine Learning: 
\code{\link{ROC}()},
\code{\link{conf_mat}()},
\code{\link{export_results}()},
\code{\link{gain_lift}()},
\code{\link{h2o_automl}()},
\code{\link{h2o_predict_API}()},
\code{\link{h2o_predict_MOJO}()},
\code{\link{h2o_predict_binary}()},
\code{\link{h2o_predict_model}()},
\code{\link{h2o_selectmodel}()},
\code{\link{impute}()},
\code{\link{iter_seeds}()},
\code{\link{lasso_vars}()},
\code{\link{model_metrics}()},
\code{\link{msplit}()}
}
\concept{Clusters}
\concept{Machine Learning}
\concept{PCA}
