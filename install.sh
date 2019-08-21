#!/bin/sh
if [ ! -d "./virtv/appinit/lib/" ]; then
  echo "Building Virtual Environment"
  virtualenv -p /usr/bin/python3 ./controller/virtv/
  
  echo "Installing Dependencies"
  source ./virtv/appinit/bin/activate
  pip install -r ./virtv/requirements.txt

  echo "Done Installing"
fi
