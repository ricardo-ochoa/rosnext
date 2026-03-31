#!/bin/bash

set -e

cd "$(dirname "$0")/.."

source /opt/ros/humble/setup.bash

rosdep install --from-paths src --ignore-src -r -y
colcon build