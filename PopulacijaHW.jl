using DataFrames
using CSV
using DifferentialEquations
using Plots


#Napraviti model projekcije stanovništva do 2100. koristeći diferencijalne jednadžbe za
#eksponencijalni, linearni i logistički rast. 
populacija = CSV.read("Populacija_zemlja.csv", DataFrame) # učitamo podatke koje imamo u datoteci
show(populacija)
godina=populacija[:,1] 
broj=populacija[:,2]./1e9
pop_zadnja_god=populacija[nrow(populacija),2]
ukupni_rast=pop_zadnja_god-pop_prva_god
vrijeme_poc=populacija[1,1]
vrijeme_kon=populacija[nrow(populacija),1]
vrijeme=vrijeme_kon-vrijeme_poc
godisnji=ukupni_rast/vrijeme
stopa_rođenja, stopa_smrti=0.03, 0.011
godina=populacija[:,1] 
broj=populacija[:,2]./1e9 

function modelLog(du,u,p,t)
    r, K=p
    du[1] = u[1]*(r*(1-u[1]/K))
end
function modelLin(du,u,p,t)
    c = p
    du[1]= c
end

function modelEks(du,u,p,t) 
    alpha = p
    du[1] = u[1]*alpha
end
function parametri_populacije(alpha, beta)
    K=-(alpha/beta)
    r=alpha
    return r,K
end


tspan = (1950.0,2100.0)
pop_prva_god=populacija[1,2]
u0 = [pop_prva_god./1e9] # 
r, Kap=parametri_populacije(0.025,-0.0018)
plog = (r,Kap)
plin = godisnji
peks = stopa_rođenja-stopa_smrti

problem = ODEProblem(modelLin,u0,tspan,plin)
sollin = solve(problem)

problem = ODEProblem(modelEks,u0,tspan,peks)
soleks = solve(problem)

problem = ODEProblem(modelLog,u0,tspan,plog)
sollog = solve(problem)

plot(godina, broj, label="Stanovništvo svijeta", legend = :bottomright) # osnovna naredba za plot
plot!(xlab="vrijeme [god]", ylab="broj stanovnika [milijarde]")
plot!(sollin,label="Stanovništvo svijeta_model_lin_derivacija", legend = :topright)
plot!(soleks,label="Stanovništvo svijeta_model_eks_derivacija", legend = :topright)
plot!(sollog,label="Stanovništvo svijeta_model_log_derivacija", legend = :topright)