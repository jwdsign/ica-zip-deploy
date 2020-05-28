#!/bin/sh -v

M_LOCAL_DIR=${LOCAL_DIR:-"./"}
M_REMOTE_DIR=${REMOTE_DIR:-"~/"}
M_FOLDER_NAME=${FOLDER_NAME}
M_ARCHIVE_NAME=${ARCHIVE_NAME}

cd $M_LOCAL_DIR

echo "Creating wrapper directory..."

mkdir -p $M_FOLDER_NAME

echo "Moving all files to wrapper directory..."

rm -r src
rm *.json
rm webpack.config.js
mv * $M_FOLDER_NAME/
mv $M_FOLDER_NAME $M_FOLDER_NAME

echo "Zipping wrapper directory..."

zip ~/$M_ARCHIVE_NAME -r ./$M_FOLDER_NAME -x "src/*" -x ".git/*" -x ".github/*" -x ".gitattributes" -x ".gitignore" -x "bower.json" -x "package.json" -x "webpack.config.js"
cd ~/

echo "Zip file created."

echo "Deploying files"

sshpass -p $DEPLOY_PASSWORD scp -o StrictHostKeyChecking=no $M_ARCHIVE_NAME ${DEPLOY_USERNAME}@${TARGET_SERVER}:${M_REMOTE_DIR}

sshpass -p $DEPLOY_PASSWORD ssh ${DEPLOY_USERNAME}@${TARGET_SERVER} bash -c "'

${EXTRA_COMMANDS}
'"
echo "Deploy completed" 
