#!/bin/bash

# Start the first process
cd /root/notebooks
jupyter lab --no-browser >/var/log/jupyter.log 2>&1 < /var/log/jupyter.log &

/bin/bash
