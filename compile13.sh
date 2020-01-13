#!/bin/bash

compile_openjdk13u(){
    is_git_f=$1
    cd /home/lin/openjdk-jdk13u/
    
    if [ "$is_git_f" = "f" ];then
	    git pull -f
    fi
    
    chuan apt-get install -y libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev
    chuan apt-get install ccache -y
    
    cd /home/lin/openjdk-jdk13u/build/linux-x86_64-server-slowdebug/jdk/bin
    has_directory=$?
    if [ "$has_directory" = "0" ];then
	    cd /home/lin/openjdk-jdk13u/
	    # chuan make dist-clean
	    current_directory=`pwd | grep -a 'jdk' | grep -a 'u'`
	    if [ -n "$current_directory" ];then
	        # 指定 bootjdk 为 openjdk13
	       bash configure --with-debug-level=slowdebug --disable-warnings-as-errors \
        	       --with-target-bits=64 \
        	       --enable-ccache --with-native-debug-symbols=external \
	               --with-boot-jdk=/opt/jdk-13.0.1/
	       chuan make hotspot-only CONF=linux-x86_64-server-slowdebug JOBS=1

	       export PATH=$PATH:/home/lin/openjdk-jdk13u/build/linux-x86_64-server-slowdebug/jdk/bin/
	       echo "已经完成编译啦，快去调试吧! $date"
	    else
		    echo "无此目录，无法编译"
	    fi
    fi
}

compile_openjdk13u $*

