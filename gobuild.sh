#!/bin/bash

# Program:
#	to build go app
# History:
# 2017/8/4 chentao v1.0

sourcePath=$1
usernaem=米兰的铁匠ct
password=chentao1992
registryAddress=registry.cn-hangzhou.aliyuncs.com

function pushImage()
{
	timestamp=$(date +%s)
        imageName=$1$timestamp
        docker build -t $imageName .
        tagName="registry.cn-hangzhou.aliyuncs.com/chentao/"$imageName
        docker tag $imageName $tagName
        docker login --username=米兰的铁匠ct registry.cn-hangzhou.aliyuncs.com -p=chentao1992
        docker push $tagName
}

function buildDockfile()
{
	
}
function buildGo()
{
	mainPath=$(find $sourcePath -name 'main.go')
	if [ -z "$mainPath" ];then
		echo  -e "not found main.go file/n"
		exit 1
	fi
	go build -o main $mainPath
	
	###dockerfile
	mkdir -p ~/dockerfile/go/
	mv ./main ~/dockerfile/go/
	cd ~/dockerfile/go/
	touch Dockerfile
	echo "FROM scratch" > Dockerfile
	echo "MAINTAINER chentao <chentao_ct@outlook.com>" >> Dockerfile
	echo "WORKDIR /root" >> Dockerfile
	echo "COPY main /root" >> Dockerfile
	echo "CMD ["./main"]" >> Dockerfile
	pushImage "goapp"
}


files=$(ls -R $1|grep '\.go$')
if [ -n "$files" ];then
	buildGo	
fi

files=$(ls -R $1|grep '\.py$')
if [ -n "$files" ];then
	buildPy
fi

files=$(ls -R $1|grep '\.java$')
if [ -n "$files" ];then
	buildJava
fi


