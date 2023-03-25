function tempConvert(temp, scale)
    if scale=="F"
        return temp*(9/5) + 32
    elseif scale=="K"
        return temp+273.15
    else
        print("Krivi upis -> ")
    end
end
println("Upisi temperaturu: ")
temp = readline()
temp = parse(Int64,temp)
println("Upisi mjernu jedinicu: ")
scale = readline()
print(tempConvert(temp,scale))


#Napravite model koji računa površinu pravokutnog trokuta ovisno o tome što je poznato. Npr.
#mogu biti poznate duljine kateta, duljina jedne katete i hipotenuze....
function racunajPravokutni(a,b,c)
    if a==0.0
        alpha = acos(b/c)
        a = c*sin(alpha)
    elseif b==0.0
        alpha = acos(a/c)
        b = c*sin(alpha)
    end
    return a*b/2
end

function main()
    println("Ukoliko nema zadanog podatka upisite 0 (NULA)")
    println("Upisi 1.katetu: ")
    a = parse(Float64,readline())
    println("Upisi 2.katetu: ")
    b = parse(Float64,readline())
    println("Upisi hipotenuzu: ")
    c = parse(Float64,readline())
    println(racunajPravokutni(a,b,c))
end
main()

function racunajTrokut(a,b,c)#racuna povrsinu bilo kojeg trokuta preko Heronove formule
    s = (a+b+c)/2
    return sqrt(s*(s-a)*(s-b)*(s-c))
end
print(racunajTrokut(3,4,5))
