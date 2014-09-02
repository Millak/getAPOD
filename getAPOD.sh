#!/bin/bash

BaseUrl='http://apod.nasa.gov/apod/'
readonly ImageTag='href="image/'
declare -i StartDate=950616
Today=$(date +"%y%m%d")
SaveDir=$HOME'/Pictures/APOD/'

for yy in 95 96 97 98 99
do
	for mm in 01 02 03 04 05 06 07 08 09 10 11 12
	do
		for dd in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
		do
		#echo $yy$mm$dd
			if test $yy$mm$dd -ge $StartDate
			then
				AP=ap$yy$mm$dd
				Pic=$(wget http://apod.nasa.gov/apod/$AP.html -q -O - | grep href=\"image |tr '\"' '\n' | head -n2| tail -n1)
				#echo $Pic
				Name=$(echo $Pic | awk -F'/' '{print $NF}')
				#echo $Name
				if test $Pic #&& echo $BaseUrl$Pic
				then
					test -f $SaveDir$Name || wget $BaseUrl$Pic -q -O $SaveDir$Name
				fi
			fi
		done
	done
done

for yy in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14
do
	for mm in 01 02 03 04 05 06 07 08 09 10 11 12
	do
		for dd in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
		do
			if test $yy$mm$dd -le $Today
			then
				AP=ap$yy$mm$dd
				Pic=$(wget http://apod.nasa.gov/apod/$AP.html -q -O - | grep href=\"image |tr '\"' '\n' | head -n2| tail -n1)
				Name=$(echo $Pic | awk -F'/' '{print $NF}')
				if test $Pic
				then
					test -f $HOME/Pictures/APOD/$Name || wget $BaseUrl$Pic -q -O $SaveDir$Name
				fi
			fi
		done
	done
done

