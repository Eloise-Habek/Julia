#Svaki podlozno postaje zarazen i onda oporavljen
using DifferentialEquations
using Plots

function SIRS(du,u,p,t)
    beta,gamma,delta = p
    du[1] = -beta*u[1]*u[2] + delta*u[3]
    du[2] = beta*u[1]*u[2]-gamma*u[2]
    du[3] = gamma*u[2] - delta*u[3]
end

S = 4065253 #prema popisu stanovništva hrv u 2019.
I = 1
R = 0
k = 12
b = 0.05
t_gubiimunitet = 90 #pojedinac gubi imunitet nakon 90 dana
t_oporavka = 10 #pojedina se oporavi nakon 10 dana

N = I + S + R
delta = 1/t_gubiimunitet
beta = (k*b)/N
gamma = 1/t_oporavka

p = (beta,gamma,delta)
u0 = [S;I;R]
tspan = (0.0,100.0)
problem = ODEProblem(SIRS,u0,tspan,p);
sol = solve(problem)

plot(sol,vars = (0,1),title = "SIRS",label = "S")
plot!(sol,vars = (0,2),label = "I")
plot!(sol,vars = (0,3),label = "R")