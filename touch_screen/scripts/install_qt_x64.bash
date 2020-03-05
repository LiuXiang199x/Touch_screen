#!/bin/bash
INSTALLATION_PATH=~/Qt5.6.2

cd /tmp
git clone git@asimov.uc3m.es:third_parties/qt_5_4_0
cd qt_5_4_0/

echo -e "\e[1m \n Installing QT ..."
echo -e "\e[7m Qt Installation Guide"
echo -e "\e[7m Step 1. Select the installation path (default: $INSTALLATION_PATH). Press Next >"
echo -e "\e[7m Step 2. Select ALL Qt5.6.2 components clicking on Select All button. Press Next >"
echo -e "\e[7m Step 3. Read and accept the license agreement. Press Next >"
echo -e "\e[7m Step 4. Press Install button \e[27m"
./qt-opensource-linux-x64-android-5.6.2.run

echo -e "\e[1m \n Writing env variables on ~/.bashrc ..."
echo '#Qt5.6.2 configuration' >> ~/.bashrc
echo "QML_IMPORT_PATH=${INSTALLATION_PATH}/5.6/gcc_64/qml:$QML_IMPORT_PATH" >> ~/.bashrc
echo "PATH=${INSTALLATION_PATH}/5.6/gcc_64/bin:$PATH" >> ~/.bashrc

echo "export CMAKE_MODULE_PATH=${INSTALLATION_PATH}/5.6/gcc_64/lib/cmake" >> ~/.bashrc
echo 'export Qt5_DIR=$CMAKE_MODULE_PATH/Qt5' >> ~/.bashrc
echo 'export Qt5Core_DIR=$CMAKE_MODULE_PATH/Qt5Core' >> ~/.bashrc
echo 'export Qt5Gui_DIR=$CMAKE_MODULE_PATH/Qt5Gui' >> ~/.bashrc
echo 'export Qt5WebEngine_DIR=$CMAKE_MODULE_PATH/Qt5WebEngine' >> ~/.bashrc

echo 'export LIBGL_ALWAYS_SOFTWARE=y' >> ~/.bashrc

echo -e "\e[1m Done! \n \e[21m"

