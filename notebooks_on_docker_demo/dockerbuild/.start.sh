#!/bin/bash
jupyter lab --no-browser >/var/log/jupyter.log 2>&1 < /var/log/jupyter.log &
echo "Jupyter lab is running at http://localhost:8888/lab"