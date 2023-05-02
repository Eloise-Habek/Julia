using DifferentialEquations

function R_A(du,u,p,t)
    alpha,beta,gamma,delta,kappa,b = p
    du[1] = u[1]*(alpha*(1-u[1]/kappa)-beta*(u[2]/(b + u[1])))
    du[2] = -u[2]*(gamma-delta*(u[1]/(b+u[1])))
end
##
alpha = 0.9
beta = 1
gamma = 0.2
delta = 0.3
kappa = 100
b = 10
p = (alpha,beta,gamma,delta,kappa,b)
u0 = [2.0;1.0]
tspan =(0.0,200.0)
problem = ODEProblem(R_A,u0,tspan,p)
sol = solve(problem)
using Plots
plot(sol,vars = (0,1),title = "Grabežljivac - plijen_ AR model"
,label = "Plijen",legend = :topright)
plot!(sol,vars=(0,2),label = "Grabežljivac",legend = :topright)
plot(sol,vars = (1,2),title = "Grabežljivac - plijen_ AR model"
,label = "(u2,u1)",legend = :topright,
xlabel = "Plijen",ylabel = "Grabežljivac")



