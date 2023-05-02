#Svaki podlozno postaje zarazen i onda oporavljen
using DifferentialEquations
using Plots

function SIR(du,u,p,t)
    beta,gamma = p
    du[1] = -beta*u[1]*u[2]
    du[2] = beta*u[1]*u[2]-gamma*u[2]
    du[3] = gamma*u[2]
end

S = 4065253 #pronađena statistika o procjeni broja stanovnika u hrv 2019.
I = 1 #pretpostavimo da zaraza u hrv počinje od jedne osobe
R = 0
k = 10 #pretpostavka je da su ljudi u kontaktu s otp 10 osoba na dan
b = 0.6 #razni izvora govore da je gripa visoko zarazne u izravnom kontaktu
t_oporavka = 7

N = I + S + R
beta = (k*b)/N
gamma = 1/t_oporavka

p = (beta,gamma)
u0 = [S;I;R]
tspan = (0.0,50.0)
problem = ODEProblem(SIR,u0,tspan,p);
sol = solve(problem)

plot(sol,vars = (0,1),title = "SIR",label = "S",legend = :topright )
plot!(sol,vars = (0,2),label = "I",legend = :topright)
plot!(sol,vars = (0,3),label = "R",legend = :topright)
