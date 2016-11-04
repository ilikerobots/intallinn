SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`

cd $SCRIPTPATH/..
ionic state reset
ionic platform add android
ionic resources --icon
ionic resources --splash
cd $SCRIPTPATH/
./syncAppContent.sh
