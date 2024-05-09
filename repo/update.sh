#!/bin/bash

for file in `ls update`
do
	if [[ ${file} == PPSSPP*ipa ]];then
		mv update/${file} ../ipas
		sed -i "s/\.\.\/ipas\/PPSSPP_0v[0-9]\+\.[0-9]\+\(\.[0-9]\+\)\?\(-[0-9]\+-[0-9a-z]\{11\}\)\?\.ipa/\.\.\/ipas\/${file}/g" ../en_US/index.html
		sed -i "s/\.\.\/ipas\/PPSSPP_0v[0-9]\+\.[0-9]\+\(\.[0-9]\+\)\?\(-[0-9]\+-[0-9a-z]\{11\}\)\?\.ipa/\.\.\/ipas\/${file}/g" ../zh_CN/index.html
		plutil -replace items.0.assets.0.url -string "https://halo-michael.github.io/ipas/${file}" ../download/ppsspp_en_US.plist
		plutil -replace items.0.metadata.bundle-version -string "$(echo ${file} | sed -e 's/PPSSPP_0v//g' -e 's/.ipa//g')" ../download/ppsspp_en_US.plist
		plutil -replace items.0.metadata.title -string "$(echo ${file} | sed -e 's/.ipa//g')(Need AppSync)" ../download/ppsspp_en_US.plist
		plutil -replace items.0.assets.0.url -string "https://halo-michael.github.io/ipas/${file}" ../download/ppsspp_zh_CN.plist
		plutil -replace items.0.metadata.bundle-version -string "$(echo ${file} | sed -e 's/PPSSPP_0v//g' -e 's/.ipa//g')" ../download/ppsspp_zh_CN.plist
		plutil -replace items.0.metadata.title -string "$(echo ${file} | sed -e 's/.ipa//g')(需要 AppSync)" ../download/ppsspp_zh_CN.plist
	fi
	if [[ ${file} == org.ppsspp.ppsspp*deb ]];then
		mv update/${file} debs
	fi
done

rm -rf Packages Packages.bz2 Packages.xz Packages.lzma
dpkg-scanpackages -m ./debs /dev/null >Packages
sed -i 's/\.\/debs\/com\.michael\.fonts\.apple-emoji-theme/https:\/\/media\.githubusercontent\.com\/media\/Halo-Michael\/halo-michael.github.io\/master\/repo\/debs\/com\.michael\.fonts\.apple-emoji-theme/g' Packages
bzip2 -9fkv Packages > Packages.bz2
xz -9fkev Packages > Packages.xz
xz -9fkev --format=lzma Packages > Packages.lzma
