

DIR=app_JADX/sources/

#remove previously created obfuscation map filee

rm obfuscation_map.txt

#creates obfuscation map from the decompiled java files

for i in $(find $DIR -name '*.java' -print);
	do 
		filename=`basename $i`
		obfuscatedName=`echo "${filename%.*}"`
		sourceName=`grep "compiled from" $i | cut -d ' ' -f4`
		 
		if [[ ! -z $sourceName && ${obfuscatedName::1} == "C" ]] 
		then
			targetPath=`echo $i | sed -e "s/${obfuscatedName}/${sourceName}/g"`
			mv $i $targetPath 
			echo $i
			echo $targetPath
			if [ $? -eq 0 ]
			then
				sourceName=${sourceName%%.*}
				echo $obfuscatedName $sourceName >> obfuscation_map.txt
			fi
		fi
	done

#creates the sed replace func with the help of obfuscation map

sedCmd=""
while read -r obfuscatedName sourceName; do

    echo "$obfuscatedName" "$sourceName"

    sedCmd=$sedCmd" -e 's:${obfuscatedName}:${sourceName}:g' "
done < obfuscation_map.txt

sedCmd="sed -i '' ${sedCmd} "

#run the replace script for all the java files

for i in $(find $DIR -name '*.java' -print);
	do 
		echo $i
		cmd=$sedCmd$i
		eval $cmd 
	done






