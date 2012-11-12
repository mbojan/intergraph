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

