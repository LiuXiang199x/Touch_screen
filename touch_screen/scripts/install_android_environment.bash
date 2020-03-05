echo '#Java, Ant & Android VARS' >> ~/.bashrc 
cd ~/
git clone git@asimov.uc3m.es:third_parties/touch_screen.git
cd touch_screen/

#install OpenJDK
sudo tar -xzf jdk-8u121-linux-x64.tar.gz -C ~/
sudo apt-get install openjdk-6-jre
echo 'export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64' >> ~/.bashrc 
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc 

#install ant (V. 1.10.1)
sudo tar -xzf apache-ant-1.10.1-bin.tar.gz -C /usr/bin
echo 'export ANT_HOME="/usr/bin/apache-ant-1.10.1"' >> ~/.bashrc 
echo 'export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$ANT_HOME/bin"' >> ~/.bashrc 

#install android ndk (V. r11c)
sudo apt-get install unzip
unzip android-ndk-r11c-linux-x86_64.zip -d ~
echo 'export PATH=${PATH}:~/android-ndk-r11c' >> ~/.bashrc 

#Configure roscpp_android_ndk
sudo tar -xzf roscpp_android_ndk.tar.gz -C ~/

#install android sdk (V. r24c)
tar zxvf android-sdk_r24.4.1-linux.tgz -C ~
echo 'export ANDROID_SDK_ROOT=~/android-sdk-linux' >> ~/.bashrc 
echo 'export PATH=${PATH}:~/android-sdk-linux/tools' >> ~/.bashrc 
echo 'export PATH=${PATH}:~/android-sdk-linux/platform-tools' >> ~/.bashrc 

echo -e "\e[1m \n Install manually Android SDK Build-tools revision 25"
cd ~/android-sdk-linux/tools
./android update sdk

source ~/.bashrc


