moodle_zip=$1

rootdir="$(pwd)"
rm "${rootdir}/not_compiled"
rm -r "${rootdir}"/results
mkdir "${rootdir}"/results

rm -r works
mkdir works

cd works
unzip ../"${moodle_zip}"
for file in *; do	
	dtrx --one=inside -n -q "${file}"
done

# removes compressed files
rm -v *.zip *.tar.* *.7z *.rar

count=0
for folder in *; do
	cd "${folder}"
	result=($(find -name '*.c' | head -n 1))
	loc=$(dirname "${result}")

	echo "${folder}"
	echo ${loc}

	out=($(gcc ${loc}/*.c))

	if test ! -f "a.out" 
	then
		((count++))
		echo "${folder}" >> "${rootdir}/not_compiled"
	else
		mkdir "${rootdir}"/results/"${folder}"
		cp -r "${rootdir}"/input .
		imgs=($(ls input/*cena* input/*objeto*))
		for (( i = 0; i < ${#imgs[@]}; i+=2 )); 
		do
			echo "./a.out ${imgs[i]} ${imgs[i+1]} saida.txt" >> "${rootdir}"/results/"${folder}"/dump
			./a.out ${imgs[i]} ${imgs[i+1]} saida.txt >> "${rootdir}"/results/"${folder}"/dump
			cat saida.txt >> "${rootdir}"/results/"${folder}"/answer
			echo "" >> "${rootdir}"/results/"${folder}"/answer
			if test -f "saida.txt"
			then
				rm saida.txt
			fi
		done  
	fi

	cd ..
done

echo "Not compiled : ${count}" 

cd ..
rm -r works