#!/bin/sh
end="\033[0m"
red="\033[1;31m"

settings='{
  "python.pythonPath": "virtv/appinit/bin/python",
}'

function color {
  echo "${red}${1}${end}"
}

if [ ! -d "./virtv/appinit/lib/" ]; then
  if [ ! -d ".vscode/" ]; then
    mkdir .vscode
    touch .vscode/settings.json
    echo $settings > .vscode/settings.json
  fi

  color "Building Virtual Environment"
  virtualenv -p python3 virtv/appinit
  
  color "Installing Dependencies"
  source virtv/appinit/bin/activate
  pip install -r virtv/requirements.txt

  color "Linking Packages"
  pip install --editable packages/auth/
  pip install --editable packages/backend/
  pip install --editable packages/cli/
 
  color "Installing npm packages"
  cd ./packages/ui
  yarn install
  yarn link
  yarn link @app-init/ui 
  
  cd ../frontend
  yarn install
  yarn link @app-init/ui 

  cd ../../
  deactivate  
  color "Done Installing"
fi
