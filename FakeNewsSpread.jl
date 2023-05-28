#= Modeliranje širenja lažnih vijesti: modelirati širenje lažnih vijesti u društvenoj mreži koristeći
modele epidemije i analizirati utjecaj različitih intervencija, kao što su provjera činjenica i
moderiranje društvenih medija =#
#Modeliranje širenje COVID lažnih vijesti na Twitteru uoči pandemija, specifično širenje teorije zavjere "5GCoronavirus"
using DifferentialEquations
using Plots

#korištenje SIR modela i već postojeće diferencijalne jednadžbe
function SIR(du,u,p,t)
    beta,gamma = p
    N = u[1]+u[2]+u[3]
    du[1] = -beta*u[1]*u[2]/N
    du[2] = beta*u[1]*u[2]/N-gamma*u[2]
    du[3] = gamma*u[2]
end

S = 7060#pocetni broj podložnih lažnim vijestima
I = 1.1#pocetni broj onih koji šire vijesti
R = 2937#pocetni broj onih koji više ne šire lažne vijesti
#metoda pokusaj pogreska (beta, gamma)
#oni su ograniceni na (0,1)
#tražimo da je maksimalno (oko 680) zaraženih u 8.4.2020. (t ~ 70)
#trazimo preciznost na 2 decimale

found_solution = false
beta = 0
gamma = 0
for i = 0.1:0.01:1
    beta = i
    for j = 0.1:0.01:1
        gamma = j
        p = (beta,gamma)
        u0 = [S;I;R]
        tspan = (0.0, 210.0) #po danima (30 dana u mjesecu, 7 mjeseci)
        problem = ODEProblem(SIR, u0, tspan, p)
        sol = solve(problem)
        maxic = maximum(sol[2, :])
        max_indexT = argmax(sol[2, :])
        tMax = sol.t[max_indexT]
        if tMax > 70 && tMax < 75 && maxic > 680
            global found_solution = true
            break
        end
    end
    if found_solution
        break
    end
end 
p = (beta,gamma)
u0 = [S;I;R]
tspan = (0.0,210.0) #po danima (30 dana u mjesecu, 7 mjeseci)
problem = ODEProblem(SIR,u0,tspan,p)
sol = solve(problem)


#u milijunima
plot(sol,vars = (0,1),title = "5GCoronavirus",ylabel = "u milijunima",label = "S",legend = :topright )
plot!(sol,vars = (0,2),label = "I",legend = :topright)
plot!(sol,vars = (0,3),label = "R",legend = :topright)
xlabel!("t (dan)")



#S intervancijom alpha
#alpha = stopa kojom se broj podložnih odmah prebacuje u broj oporavljenih radi utjecaja tkz. "fact-checkera"
function SIRInterventaion(du,u,p,t)
    beta,gamma,alpha = p
    N = u[1]+u[2]+u[3]
    du[1] = -beta*u[1]*u[2]/N-alpha*u[1] #alpha smanjuje broj podložnih
    du[2] = beta*u[1]*u[2]/N-gamma*u[2]
    du[3] = gamma*u[2] + alpha*u[1] #alpha povećava broj oporavljenih za istu stopu kojom se smanjuje broj podložnih
end

S = 7060#pocetni broj podložnih lažnim vijestima
I = 1.1#pocetni broj onih koji šire vijesti
R = 2937#pocetni broj onih koji više ne šire lažne vijesti
#metoda pokusaj pogreska (beta, gamma)
#oni su ograniceni na (0,1)
found_solution = false

for i = 0.1:0.01:1
    beta = i
    for j = 0.1:0.01:1
        gamma = j
        p = (beta,gamma)
        u0 = [S;I;R]
        tspan = (0.0, 210.0) #po danima (30 dana u mjesecu, 7 mjeseci)
        problem = ODEProblem(SIR, u0, tspan, p)
        sol = solve(problem)
        maxic = maximum(sol[2, :]) #maksimalni broj zarazenih
        max_indexT = argmax(sol[2, :]) #njegov indeks u listi
        tMax = sol.t[max_indexT] #t kada se dostiže maks. broj zaraženih
        if tMax > 70 && tMax < 75 && maxic > 680 #uvjeti koje je postavio stvarni svijet
            global found_solution = true
            break
        end
    end
    if found_solution
        break
    end
end
#isprobavanje utjecaja alphe
p = (beta = 0.3,gamma = 0.11,alpha = 1/700)
u0 = [S;I;R]
tspan = (0.0,210.0) #po mjesecima (od siječnja do kolovoza)
problem = ODEProblem(SIRInterventaion,u0,tspan,p);
solintervention = solve(problem)
maxic = maximum(sol[2, :])

#u milijunima
plot!(solintervention,vars = (0,1),label = "S - intervention",legend = :topright)
plot!(solintervention,vars = (0,2),label = "I - intervention",legend = :topright)
plot!(solintervention,vars = (0,3),label = "R - intervention",legend = :topright)
xlabel!("t (dan)")