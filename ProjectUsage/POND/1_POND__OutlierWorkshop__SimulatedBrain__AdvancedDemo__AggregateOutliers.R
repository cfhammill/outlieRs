require(outlieRs)

## These are comments
## Any lines preceded by a # will be ignored by R, so you can write whatever you'd like!

############################################################################
## Neuroimaging example ##
############################################################################

## We recommend for now that any preprocessing, scaling, and correction factors be done *before hand*. Read in a "cleaned" data file for outlier analyses
## The cleaning/correcting/scaling processes should be done in whatever software you are comfortable with.

# Read data in from .csv file
ni.demographics <- read.csv("demographics.csv",header=T,row.names = 1)
ni.data <- read.csv("simulated.brain_z.csv",header=T,row.names = 1)



##### Minimum covariance determinant (MCD) #####
# to see the help file (e.g., short description, inputs, outputs), type the following line (without the #) into the console:
# ?multiOut
mcdResult <- multiOut(ni.data,rmdo_alpha=0.9)

# looking at results
  ## this provides a full set of results
names(mcdResult)
  ## this is the binary decision: if a row is outlier or not
mcdOut <- mcdResult$outlier_decision
  ## look at the first few
head(mcdOut)

  ## diagnostic plots
printOuts(mcdResult)


##### MCD + Bootstrap PCA (for Mahalanobis and score distances; Boot-MCD) #####
# looking at results
  ## this provides a full set of results
bootResult <- mcd.boot_find.outliers(ni.data)
  ## this is the binary decision: if a row is outlier or not
bootOut <- bootResult$outlier_decision
  ## look at the first few
head(bootOut)


##### Candes' Robust PCA #####
  ## does not work for this particular example; ill suited for n >> p
# # looking at results
#   ## this provides a full set of results
# rpcaResult <- rpca_find.outliers(ni.data)
#   ## this is the binary decision: if a row is outlier or not
# rpcaOut <- rpcaResult$outlier_decision
#   ## look at the first few
# head(rpcaOut)


# combine results across all three methods
  ## Get the rownames of individuals.
these.rows <- rownames(mcdOut)
  ## Use cbind to column bind vectors. Index them by 'these.rows'
allOut <- cbind(
                mcdOut[these.rows,'mcd_outlier'],
                bootOut[these.rows,c('mah_outlier','chi_outlier')]
              )
head(allOut)
colnames(allOut) <- c("MCD","BootMCD - MD","BootMCD - ChiD")

# counting the number of thresholds that identified each observation an outlier
allOutSums <- rowSums(allOut)
head(allOutSums)
# frequency of the number of thresholds
table(allOutSums)
# frequency of observations that are outliers for each threshold
colSums(allOut)
# a comparison of the number of outliers both MCD and RPCA detected vs one or the other
crossprod(as.matrix(allOut))



