moodle_zip=$1

rootdir="$(pwd)"
rm "${rootdir}/not_compiled"
rm -r "${rootdir}"/results
mkdir "${rootdir}"/results

correct_output="${rootdir}"/correct_output.txt

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
	result="$(find -name '*.c' | head -n 1)"
	loc=$(dirname "${result}")

	echo "${folder}"
	echo ${loc}

	
	mkdir "${rootdir}"/results/"${folder}"
	
	gcc ${loc}/*.c 2> "${rootdir}"/results/"${folder}/compile" 
	if test ! -f "a.out" 
	then
		((count++))
		echo "${folder}" >> "${rootdir}/not_compiled"
	else
		answer="${rootdir}"/results/"${folder}"/answer
		dump="${rootdir}"/results/"${folder}"/dump

		cp -r "${rootdir}"/input .
		imgs=($(ls input/*cena* input/*objeto*))
		for (( i = 0; i < ${#imgs[@]}; i+=2 )); 
		do
			echo "./a.out ${imgs[i]} ${imgs[i+1]} saida.txt" >> "${dump}"
			./a.out ${imgs[i]} ${imgs[i+1]} saida.txt >> "${dump}" 2>> "${dump}"
			
			cat saida.txt >> "${answer}"
			echo "" >> "${answer}"

			if test -f "saida.txt"
			then
				rm saida.txt
			fi
		done  
		c_diff=($(diff -Z -B "${answer}" "${correct_output}" | grep "^>" | wc -l))

		echo ${folder} ${c_diff} >> "${rootdir}"/results/summary
	fi

	cd ..
done

echo "Not compiled : ${count}" >> "${rootdir}"/results/summary

cd ..
rm -r works