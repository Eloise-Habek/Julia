#Svaki podlozno postaje zarazen i onda oporavljen
using DifferentialEquations
using Plots

function SIRdemo(du,u,p,t)
    beta,gamma,mi,ami,N = p
    du[1] = -beta*u[1]*u[2] + mi*N - ami*u[1]
    du[2] = beta*u[1]*u[2]-gamma*u[2]- ami*u[2]
    du[3] = gamma*u[2] - ami*u[3]
end

S = 4065253 #pronađena statistika o procjeni broja stanovnika u hrv 2019.
I = 1 #pretpostavimo da zaraza u hrv počinje od jedne osobe
R = 0
k = 10 #pretpostavka je da su ljudi u kontaktu s otp 10 osoba na dan
b = 0.6 #razni izvora govore da je gripa visoko zarazne u izravnom kontaktu
natalitet = 8.9/1000 #stopa nataliteta u 2019. /1000 jer je stopa na 1000 stanovnika
mortalitet = 12.7/1000 #stopa mortaliteta u 2019. /1000 jer je stopa na 1000 stanovnika
t_oporavka = 7

N = I + S + R
beta = (k*b)/N
gamma = 1/t_oporavka

p = (beta,gamma,natalitet,mortalitet,N)
u0 = [S;I;R]
tspan = (0.0,100)
problem = ODEProblem(SIRdemo,u0,tspan,p);
sol = solve(problem)

plot(sol,vars = (0,1),title = "SIR + demografija",label = "S")
plot!(sol,vars = (0,2),label = "I")
plot!(sol,vars = (0,3),label = "R")
