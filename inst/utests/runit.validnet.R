# unit test of validating functions

# Validating edge lists
test.validateEL <- function()
{
  df1 <- data.frame( ego = 1:5, alter = c(2,3,2,5,4))
  r1 <- intergraph:::validateEL(df1)
  checkEquals(df1, r1)

  checkException( intergraph:::validateEL( data.frame(ego=1:5)))

  op <- options(warn=2)
  df2 <- data.frame( ego = 1:5, alter = c(2,NA,2,5,4))
  checkException( intergraph:::validateEL(df2) )
  options(op)
}





# Validating vertex DBs
runit.validateVDB <- function()
{
  # Corrected data frame
  df1 <- data.frame(id=1:5, x=c(1,2,3,2,1), y=c(3,2,1,2,3))
  checkEquals(df1, validateVDB(df1))

  # empty dataframe
  df2 <- data.frame(id=numeric(0), x=character(0))
  checkException( validateVDB(df2) )

  # duplicated ids
  df3 <- df1
  df3$id[3] <- 1
  checkException( validateVDB(df3))

  # NAs
  df4 <- df1
  df4$id[2] <- NA
  op <- options(warn=2)
  checkException( validateVDB(df4))
  options(op)
}





# Validating EDB vs VDB
runit.validNetDB <- function()
{
  # Correct
  edb <- data.frame( ego = 1:5, alter = c(2,3,2,5,4))
  vdb <- data.frame(id=1:5, x=c(1,2,3,2,1), y=c(3,2,1,2,3))
  checkTrue( validNetDB(edb, vdb))

  
  # some ids EL are not found in VDB
  elist <- data.frame( ego = 1:5, alter = c(2,3,2,5,4))
  vdb <- data.frame(id=1:4, x=c(1,2,3,4), y=c(3,2,1,2))
  checkException( validNetDB(elist, vdb))
}

