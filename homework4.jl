global m=70
global cd=0.25
global g=9.81

function deriva(v)
    dv=g-((cd/m)*v*abs(v))
    return dv
end

function freeFallput(v0,t0,dt,tk)
    deltaT = dt
    vi = v0
    s = 0
    ti = t0
    put = zeros(0)
    br = zeros(0)
    vrijeme = zeros(0)
    while ti<tk
        if ti+deltaT>tk
            deltaT = tk-ti
        end
        append!(put,s)
        append!(vrijeme,ti)
        append!(br,vi)
        dvdt = deriva(vi)
        vi = vi + dvdt*deltaT
        s = s-vi*deltaT #podrazumijeva se da skacemo od 0 visine
        ti = ti+deltaT
    end
    return br,vrijeme,put
end

using Plots
gr()
b,vri, p = freeFallput(-40,0,2,20)


plot(vri, p, label="Put ovisno o vremenu", legend = :bottomright)
plot!(xlab="t [s]", ylab="s [m]")
