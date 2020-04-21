sed -i 's///g' POSCAR
head -n 8 POSCAR > poscar2
tail -n +9 POSCAR > poscar1

# Get the total number of atoms
set -- $( sed '7q;d' POSCAR )
atoms=0
while [ $# -gt 0 ]
do
	i=$1
	atoms=$( echo "$atoms + $i" | bc )
	shift
done

judge1=0.1
judge2=0.2

#set the FFF to lines
for((i=1;i<=$atoms;i++))
do
	zz=` sed -n ${i}p poscar1 |awk '{print $3}'`
	if [ $(echo "$zz < $judge1" |bc) -eq 1 ]
	then
		sed -i "${i}s/$/\ \ \ F\ \ F\ \ F/g" poscar1
	else
		if [ $(echo "$zz < $judge2" |bc) -eq 1 ]
		then
			sed -i "${i}s/$/\ \ \ F\ \ F\ \ T/g" poscar1
		else
			sed -i "${i}s/$/\ \ \ T\ \ T\ \ T/g" poscar1
		fi
	fi
done

sed -i "7a Selective" poscar2
cat poscar2 poscar1 > new-poscar
rm poscar1 poscar2
