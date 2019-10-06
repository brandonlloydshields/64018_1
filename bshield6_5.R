library(lpSolveAPI)

######################### Solving the primal problem ###################

# create lp object

lpmodel2 <- make.lp(11,9)

#Create Columns

set.column(lpmodel2,1,c(1,20,1,900), indices = c(1,4,7,10))
set.column(lpmodel2,2,c(1,20,1,-750,1), indices =c(2,5,7,10,11))
set.column(lpmodel2,3,c(1,20,1,-2), indices =c(3,6,7,11))
set.column(lpmodel2,4,c(1,15,1,900), indices = c(1,4,8,10))
set.column(lpmodel2,5,c(1,15,1,-750,1), indices =c(2,5,8,10,11))
set.column(lpmodel2,6,c(1,15,1,-2), indices =c(3,6,8,11))
set.column(lpmodel2,7,c(1,12,1,900), indices = c(2,4,9,10))
set.column(lpmodel2,8,c(1,12,1,-750,1), indices = c(2,5,9,10,11))
set.column(lpmodel2,9,c(1,12,1,-2), indices = c(3,6,9,11))

set.constr.type(lpmodel2,c("<=","<=","<=","<=","<=","<=","<=","<=","<=","=","="))

#Create vectors for RHS and coeff. for objective function

rhs<- c(750,900,450,13000,12000,5000,900,1200,750,0,0)
objcoef <- c(420,420,420,360,360,360,300,300,300)

set.rhs(lpmodel2,rhs)
set.objfn(lpmodel2, objcoef)

#make maximazation problem

lp.control(lpmodel2, sense = "max")

#Set boundries

set.bounds(lpmodel2, lower = c(0,0,0,0,0,0,0,0,0), columns = c(1,2,3,4,5,6,7,8,9))

#Naming 

RowNames <- c("Plant 1 Prod.", "Plant 2 Prod.","Plant 3 Prod.","Plant 1 Space", "Plant 2 Space","Plant 3 Space", "Size L", "Size M", "Size S", "Plant 12 Labor", "Plant 23 Labor")

ColNames <- c("LPL1", "MPL1", "SPL1","LPL2", "MPL2", "SPL2","LPL3", "MPL3", "SPL3")

dimnames(lpmodel2) <- list(RowNames,ColNames)

lpmodel2

#Test if model worked: looking for 0
solve(lpmodel2)

#solve

#The optimal value of the primal will also be optimal value of the daul

get.objective(lpmodel2)

get.variables(lpmodel2)

#Postoptimality analysis / senesitivity analysis

get.constraints(lpmodel2)

get.sensitivity.rhs(lpmodel2)

#First 11 variabls in Duals represent the shadow prices for the resource constraints. The remaining nine variables represent the reduced cost of the nine variables in the objective function. Reduced cost is the amount the objective function coefficient would need to change by (increase for maximization or decrease for minimization) for variable to appear in the optimal solution. Because this is a maximization problem, values [12:20] would increases in coefficent forvariables to appear in optimal solution. A zero indicates  binding constraint.

# $Dualsfrom to $Dualstill give the ranges of the right hand of the resource constraint where the shadow price is not equal to zero.  

get.sensitivity.obj(lpmodel2)

# Values show the coefficnt range for each variable in the primal that would not change the optimal solution. These logically align with output from reduced costs. For example, variable 2 has a reduced cost of 40; in other words variable 2 would need to be increased by 40 to be included in the optimal solution. Since the coefficent is 420, this value would be 460. The coefficent range where the optimal solution is unchanged for variable 2 is negatve infiinty to 460, the point where variale 2 enters the optimal solution. 

######################### Solving the dual problem ###########################
 
# Create Lp object

dualz <- make.lp(9,11)

#change function from set.columns to set.rows for the dual transformation

set.row(dualz,1,c(1,20,1,900), indices = c(1,4,7,10))
set.row(dualz,2,c(1,20,1,-750,1), indices =c(2,5,7,10,11))
set.row(dualz,3,c(1,20,1,-2), indices =c(3,6,7,11))
set.row(dualz,4,c(1,15,1,900), indices = c(1,4,8,10))
set.row(dualz,5,c(1,15,1,-750,1), indices =c(2,5,8,10,11))
set.row(dualz,6,c(1,15,1,-2), indices =c(3,6,8,11))
set.row(dualz,7,c(1,12,1,900), indices = c(2,4,9,10))
set.row(dualz,8,c(1,12,1,-750,1), indices = c(2,5,9,10,11))
set.row(dualz,9,c(1,12,1,-2), indices = c(3,6,9,11))

#Convert constraints for the dual

set.constr.type(dualz,c(">=",">=",">=",">=",">=",">=",">=",">=",">="))

#look for set.bounds (review material about how to determine the the signs of the new constraints based on the bounds in class.)

#setboundries

set.bounds(dualz, lower = c(-Inf, -Inf), upper = c(Inf, Inf), columns = 10:11)

#Naming

ColNamesDual <- c("Plant 1 Prod.", "Plant 2 Prod.","Plant 3 Prod.","Plant 1 Space", "Plant 2 Space","Plant 3 Space", "Size L", "Size M", "Size S", "Plant 12 Labor", "Plant 23 Labor")

RowNamesDual <- c("LPL1", "MPL1", "SPL1","LPL2", "MPL2", "SPL2","LPL3", "MPL3", "SPL3")

dimnames(dualz) <- list(RowNamesDual,ColNamesDual)

#in the dual the objective function becomes the rhs and visa versa

dualrhs <- objcoef
dualobjcoef <- rhs

set.rhs(dualz,dualrhs)
set.objfn(dualz,dualobjcoef)

#Solve 

solve(dualz)

# get.objective if the dual should be equal to the primal. Variable coefficents should be equal to $duals from the primal equation. 

get.objective(dualz)
get.variables(dualz)

# Optimal for primal is 696,000 and Optimal for dual is 696,000



