#!/bin/bash

compile_openjdk13u(){
    chuan apt-get install -y libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev
    chuan apt-get install ccache -y
    cd /home/lin/projects/openjdk-jdk13u
    # chuan make dist-clean
    current_directory=`pwd | grep -a 'jdk' | grep -a 'u'`
    if [ -n "$current_directory" ];then
        # 指定 bootjdk 为 openjdk13
        bash configure --with-debug-level=slowdebug --disable-warnings-as-errors \
                --with-target-bits=64 \
                --enable-ccache --with-native-debug-symbols=external \
                --with-boot-jdk=/opt/jdk-13.0.1/
    else
        bash configure --with-debug-level=slowdebug --disable-warnings-as-errors --enable-ccache --with-native-debug-symbols=external
    fi
    # chuan make clean CONF=linux-x86_64-normal-server-fastdebug
    # chuan make clean CONF=linux-x86_64-normal-server-slowdebug

    chuan make CONF=linux-x86_64-server-slowdebug 

    export PATH=$PATH:/home/lin/openjdk-jdk13u/build/linux-x86_64-server-slowdebug/jdk/bin/
}
compile_openjdk13u
