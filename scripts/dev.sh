#!/bin/bash

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
  return 1 2>/dev/null || exit 1
fi

source "/opt/ros/$ROS_NEXT_DISTRO/setup.bash"

if [ ! -f "$ROOT_DIR/install/setup.bash" ]; then
  echo "[RosNext] Error: no existe $ROOT_DIR/install/setup.bash"
  echo "[RosNext] Primero ejecuta:"
  echo "  ./scripts/bootstrap.sh"
  return 1 2>/dev/null || exit 1
fi

source "$ROOT_DIR/install/setup.bash"

export ROSNEXT_ROOT="$ROOT_DIR"
export ROSNEXT_DISTRO="$ROS_NEXT_DISTRO"

echo "[RosNext] Entorno cargado correctamente."
echo "[RosNext] Root: $ROSNEXT_ROOT"
echo "[RosNext] ROS distro: $ROSNEXT_DISTRO"
echo "[RosNext] Ya puedes usar comandos como:"
echo "  ros2 pkg list"
echo "  ros2 launch heartbeat_node bringup.launch.py"
echo "  colcon build"