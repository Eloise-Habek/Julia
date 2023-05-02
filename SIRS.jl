#Svaki podlozno postaje zarazen i onda oporavljen
using DifferentialEquations
using Plots

function SIRS(du,u,p,t)
    beta,gamma,delta = p
    du[1] = -beta*u[1]*u[2] + delta*u[3]
    du[2] = beta*u[1]*u[2]-gamma*u[2]
    du[3] = gamma*u[2] - delta*u[3]
end

S = 4065253 #pronađena statistika o procjeni broja stanovnika u hrv 2019.
I = 1 #pretpostavimo da zaraza u hrv počinje od jedne osobe
R = 0
k = 10 #pretpostavka je da su ljudi u kontaktu s otp 10 osoba na dan
b = 0.6 #razni izvora govore da je gripa visoko zarazne u izravnom kontaktu
t_gubiimunitet = 90 #pojedinac gubi imunitet nakon 90 dana
t_oporavka = 7 #pojedinac se oporavi nakon otp 7 dana

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
