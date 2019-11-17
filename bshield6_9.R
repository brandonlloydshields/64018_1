library(lpSolveAPI)

x <- read.lp("bshield6_9.lp")

solve(x)

get.objective(x)

get.variables(x)
