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
  echo "[RosNext] Instala ROS 2 Humble o Jazzy antes de continuar."
  exit 1
fi

echo "[RosNext] Root directory: $ROOT_DIR"
echo "[RosNext] ROS distro detectada: $ROS_NEXT_DISTRO"

source "/opt/ros/$ROS_NEXT_DISTRO/setup.bash"

cd "$ROOT_DIR"

if ! command -v rosdep >/dev/null 2>&1; then
  echo "[RosNext] Error: rosdep no está instalado."
  exit 1
fi

if ! command -v colcon >/dev/null 2>&1; then
  echo "[RosNext] Error: colcon no está instalado."
  exit 1
fi

echo "[RosNext] Actualizando rosdep..."
rosdep update

echo "[RosNext] Instalando dependencias del workspace..."
rosdep install --from-paths src --ignore-src -r -y

echo "[RosNext] Compilando workspace..."
colcon build

echo "[RosNext] Bootstrap completado correctamente."
echo "[RosNext] Siguiente paso:"
echo "  source scripts/dev.sh"
echo "  ./scripts/run.sh"