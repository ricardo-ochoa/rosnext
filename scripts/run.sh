#!/bin/bash
set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

detect_ros_distro() {
  if [ -n "$ROS_DISTRO" ] && [ -f "/opt/ros/$ROS_DISTRO/setup.bash" ]; then
    echo "$ROS_DISTRO"
    return
  fi

  if [ -f "/opt/ros/humble/setup.bash" ]; then
    echo "humble"
    return
  fi

  if [ -f "/opt/ros/jazzy/setup.bash" ]; then
    echo "jazzy"
    return
  fi

  echo ""
}

ROS_NEXT_DISTRO="$(detect_ros_distro)"

if [ -z "$ROS_NEXT_DISTRO" ]; then
  echo "[RosNext] Error: no se encontró una instalación compatible de ROS 2 en /opt/ros."
  exit 1
fi

source "/opt/ros/$ROS_NEXT_DISTRO/setup.bash"

if [ ! -f "$ROOT_DIR/install/setup.bash" ]; then
  echo "[RosNext] Error: no existe $ROOT_DIR/install/setup.bash"
  echo "[RosNext] Ejecuta primero:"
  echo "  ./scripts/bootstrap.sh"
  exit 1
fi

source "$ROOT_DIR/install/setup.bash"

cd "$ROOT_DIR"

echo "[RosNext] Ejecutando heartbeat_node..."
ros2 launch heartbeat_node bringup.launch.py