using DifferentialEquations
using Plots
gr()
#= Zamislite da spadate u skupinu bungee skakača koji žele što više
adrenalina, želite doći što bliže tlu a da ga ne udarite. Podesite model
tako da određuje najprikladniju konstantu elastičnosti opruge za
skakače od 60 kg, 65 kg, 70 kg, 75 kg i 80 kg. Usporedite rezultate i
prikažite grafički. Pretpostavka je da skakači skaču s Masleničkog
mosta (provjerite udaljenost skakanja) i da se uže može rastegnuti
maksimalno 2x njegove nerastegnute vrijednosti. =#
#visina Masleničkog mosta = 55m
#pretpostavka: osoba se gleda kao točka (visina se ne uzima u obzir)

function skok(du,u,p,t)
    L,cd,m,k,gamma = p
    g = 9.81
    opruga = 0
    pocetni_put = u[1]
    pocetna_brzina = u[2]
    if pocetni_put > L
        opruga = (k/m)*(pocetni_put-L)+(gamma/m)*pocetna_brzina
    end
    du[1] = pocetna_brzina #dx/dt = v
    du[2] = g- pocetna_brzina*abs(pocetna_brzina)*(cd/m)-opruga
end
#dodati rubni uvjet x = 55m
## potrebno prvo zadati početne parametre
##iskoristiti istu funkciju ali napraviti for petlju s razlicitim k i onda masu, i pogledati kada je x  = 55
L=27.5 # duljina užeta, 2*L = 55,maksimalno se može rastegnuti do 55m
cd=0.25 # koeficijent otpora zraka
gamma=8 # koeficijent prigušenja
u0 = [0.0,0.0]
tspan = (0.0,50.0)
 #lista mogućih težina koje trebamo razmatrati

MasaK = Dict()
for i in 60:5:80
    m = i
    for j = 50:150
        k = j
        p = (L,cd,m,k,gamma)
        problem = ODEProblem(skok,u0,tspan,p)
        sol = solve(problem)
        if(maximum(sol)<55 && maximum(sol)>=54)
            if haskey(MasaK,m)
                if(MasaK[m][1]<k)
                    MasaK[m] = [k,sol]
                end
            else
                MasaK[m] = [k,sol]
            end
        end
    end
end 
plot(title = "bungee skok")
for key in keys(MasaK)
    plot!(MasaK[key][2], vars = (0,1), label="$key")

end

current()
##
