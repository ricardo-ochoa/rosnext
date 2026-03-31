#!/bin/bash

set -e

cd "$(dirname "$0")/.."

source /opt/ros/humble/setup.bash
source install/setup.bash

ros2 launch heartbeat_node bringup.launch.py