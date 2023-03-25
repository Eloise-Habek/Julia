function R_calculate(vx,vy,Q,n,m,xG,yG,N)
    Ex = zeros(N,N)
    Ey= zeros(N,N)
    #za svaki naboj se racuna njegov utjecaj na tocku u mrezi
    for i=1:(n+m)
        Rx = xG .- vx[i]
        Ry = yG .- vy[i]
        R = sqrt.(Rx.^2 + Ry.^2).^3
        #ima n pozitivnih i m negativnih
        #ako je broj veci od n onda smo presli upis poz i prelazimo na upis neg
        if i>n
            Q = -1*Q
        end
        if i==1
            Ex = k .* Q .* Rx ./ R
            Ey = k .* Q .* Ry ./ R
        else
            Ex += k .* Q .* Rx ./ R
            Ey += k .* Q .* Ry ./ R
        end
    end
    E = sqrt.(Ex.^2 + Ey.^2)
    u = Ex./E 
    v = Ey./E 
    return u,v,E
end

function main()
    #inicijalizacija
    vx = Vector{Float64}()
    vy = Vector{Float64}()
    n = rand(1:3) #stavila sam da moze biti izmedu 1 i 3 poz naboja
    #upis pozicije x i y svih n naboja
    for i=1:n
        #upis koordinata, restrikcija na podrucje od -3,3
        push!(vx,rand(-3:3))
       
        push!(vy,rand(-3:3))
    end
    m= 3-n #ovdje je slucaj gdje ce biti 3 naboja
    for i=1:m
       
        push!(vx,rand(-3:3))
      
        push!(vy,rand(-3:3))
    end
  
    Q = rand(1:50) #naboj ce biti nasumicni broj izmedu 1 i 50
    #mreza ce se sastojati od 20 tocaka
    N=20
    #namješteno da ce biti -4,4 jer sam postavila granice mogucnosti gdje se naboji mogu nalaziti
    x=range(-4,4, length=N)
    y=range(-4,4, length=N)

    xG=x' .* ones(N)
    yG=ones(N)' .* y
    u,v,E = R_calculate(vx,vy,Q,n,m,xG,yG,N)
    Plots.scatter(vx, vy, label = "Naboj ", aspect_ratio=:equal)
    for i=1:N
        display(quiver!(xG[i,:],yG[i,:],quiver=(u[i,:]/5,v[i,:]/5)))
    end
end

# konstante i inicijalizacija
eps0 = 8.854e-12
k = 1/(4*pi*eps0);
using Plots
gr()
main()

