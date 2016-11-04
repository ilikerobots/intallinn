SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`

PROJ_PATH=$SCRIPTPATH/../../..
CONTENT_PROJ_PATH=/home/mike/WebstormProjects/inTallinn_content

if [ ! -f "$PROJ_PATH/pubspec.yaml" ]; then
  echo "pubspec.yaml not found at $PROJ_PATH"
  echo "Please update path in $SCRIPT"
  exit 1
fi

if [ ! -d "$CONTENT_PROJ_PATH" ]; then
  echo "No directory exists for content project at $CONTENT_PROJ_PATH"
  echo "Please update path in $SCRIPT"
  exit 1
fi


cd $PROJ_PATH
pub build
cd $SCRIPTPATH
rm -rf ../www/* ./tmp/build
mkdir -p ./tmp/build
cp -r ../../../build/web/* ./tmp/build
sed -i '/<!-- cordova\|cordova -->/d' tmp/build/index.html
vulcanize --strip-comments  --exclude='pub/'  --exclude='cordova.js' --exclude='main.dart.js' --inline-css tmp/build/index.html > tmp/build/build.html
cp tmp/build/build.html tmp/build/index.html
cp -r ./tmp/build/* ../www/
rm -rf ./tmp


cd  $CONTENT_PROJ_PATH
pub build
cd $SCRIPTPATH
cp -r  $CONTENT_PROJ_PATH/build/web/content/ ../www/content
