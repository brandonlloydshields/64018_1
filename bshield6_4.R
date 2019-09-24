# create lp object

lprec <- make.lp(0,9)

#set objective function

set.objfn(lprec, c(420,420,420,360,360,360,300,300,300))

#make maximazation problem

lp.control(lprec, sense = "max")

#add constraints 

add.constraint(lprec, c(1,0,0,1,0,0,1,0,0), "<=",750)
add.constraint(lprec, c(0,1,0,0,1,0,0,1,0), "<=",900)
add.constraint(lprec, c(0,0,1,0,0,1,0,0,1), "<=",450)
add.constraint(lprec, c(20,0,0,15,0,0,12,0,0), "<=",13000)
add.constraint(lprec, c(0,20,0,0,15,0,0,12,0), "<=",12000)
add.constraint(lprec, c(0,0,20,0,0,15,0,0,12), "<=",5000)
add.constraint(lprec, c(1,1,1,0,0,0,0,0,0), "<=",900)
add.constraint(lprec, c(0,0,0,1,1,1,0,0,0), "<=",1200)
add.constraint(lprec, c(0,0,0,0,0,0,1,1,1), "<=",750)
add.constraint(lprec, c((1/750),(-1/900),0,(1/750),(-1/900),0,(1/750),(-1/900),0), "=",0)
add.constraint(lprec, c(0,(1/900),(-1/450),0,(1/900),(-1/450),0,(1/900),(-1/450)), "=",0)

#nonnegativity

set.bounds(lprec, lower = c(0,0,0,0,0,0,0,0,0), columns = c(1:9))

#Naming 

RowNames <- c("Plant 1 Prod.", "Plant 2 Prod.","Plant 3 Prod.","Plant 1 Space", "Plant 2 Space","Plant 3 Space", "Size L", "Size M", "Size S", "Plant 12 Labor", "Plant 23 Labor")

ColNames <- c("LPL1", "MPL1", "SPL1","LPL2", "MPL2", "SPL2","LPL3", "MPL3", "SPL3")

dimnames(lprec) <- list(RowNames,ColNames)

lprec

#looking for zero for model to have worked
solve(lprec)

#solve

get.objective(lprec)
get.variables(lprec)

#reading text file 

x<- read.lp("bshield6_4.lp")

solve(x)
get.objective(x)
get.variables(x)

