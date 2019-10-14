library(lpSolveAPI)

x <- read.lp("bshield6_6.lp")

solve(x)
get.objective(x)
get.variables(x)

#The output suggests that Plant A should produce 100 AEDs and ship 0 to warehouse 1, 60 to warehouse 2 and 40 to warehouse 3. Plant B will produce 110 AEDs and send 80 to warehouse 1, 0 to warehouse 2 and 30 to warehouse 3. 