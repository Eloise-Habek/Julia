x = y = z = 1
x,y,z = 1,1,1 #ovo radi isto kao i ono gore
x
y
z
15 = a #ovo je netocan nacin pridruzivanja varijabli
a#ERROR: a is not defined
xy #ovo nista ne napravi jer nema operaciju medu njima
x*y# ovo je operacija mnozenja
function volumen(a,s) #racuna volumen kocke ili sfera ovisno o upisu
    a = a^3
    if s == "kocka"
        return a
    elseif s == "sfera"
        return 4/3*pi*a
    else
        print("Krivi upis -> ")
    end
end

volumen(3,"kocka")
volumen(3,"sfera")
volumen(3,"valjak")
apsolutno(x)=abs(x)#funckija koja racuna apsolutnu vrijednost
apsolutno(-8)
apsolutno(7)
x = (2,3)#jedna tocka
y = (3,4)#druga tocka
function ud(x,y)#racuna udaljenost
    prva = y[1]-x[1]
    druga = y[2]-x[2]
    return sqrt(prva^2+druga^2)
end
ud(x,y)#ispis svih brojeva koji nisu djeljivi s 3 izmedu 1 i 30
for i=1:30
    if rem(i,3)!=0
        println(i)
    end
end
str = "Volim studirati u Zagrebu."
sum = 0
for s in str #racuna broj slova a u stringu str
    if s=='a'
        sum+=1
    end
end
sum



