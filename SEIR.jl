#Svaki podlozno postaje zarazen i onda oporavljen
using DifferentialEquations
using Plots

function SIR(du,u,p,t)
    beta,gamma,mi,ami,N,kappa,v = p
    du[1] = -beta*u[1]*u[2] + (mi-kappa)*N - ami*u[1]
    du[2] = v*u[4]-gamma*u[2]- ami*u[2]
    du[3] = gamma*u[2] - ami*u[3]
    du[4] = beta*u[1]*u[2] - v*u[4]-ami*u[4]
end

S = 4065253 #pronađena statistika o procjeni broja stanovnika u hrv 2019.
I = 1 #pretpostavimo da zaraza u hrv počinje od jedne osobe
R = 0
E = 0
k = 10 #pretpostavka je da su ljudi u kontaktu s otp 10 osoba na dan
b = 0.6 #razni izvora govore da je gripa visoko zarazne u izravnom kontaktu
t_oporavka = 7
natalitet = 8.9/1000
mortalitet = 12.7/1000
kappa = natalitet/10 #stopa cijepljenja rođenih u Hrvatskoj je jako mala time sam podijelila s 10
N = I + S + R + E
beta = (k*b)/N
gamma = 1/t_oporavka
v = 1/2 #stopa prijelaza iz E u I, ovaj period mozemo interpretirati
# kao inkubacijski period, prosjek je 2 dana


p = (beta,gamma,natalitet,mortalitet,N,kappa,v)
u0 = [S;I;R;E]
tspan = (0.0,100)
problem = ODEProblem(SIR,u0,tspan,p);
sol = solve(problem)

plot(sol,vars = (0,1),title = "SIR",label = "S")
plot!(sol,vars = (0,2),label = "I")
plot!(sol,vars = (0,3),label = "R")
plot!(sol,vars = (0,4),label = "E")