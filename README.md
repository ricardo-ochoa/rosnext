Claro, aquí te lo dejo **completo y bien armado** para pegarlo tal cual en tu `README.md`:

````md
# RosNext

RosNext is a starter template for ROS 2 projects focused on modularity, automation, reproducibility, and developer experience.

## Current status

This repository includes an official starter package:

- `heartbeat_node`

It demonstrates:

- package structure
- parameter loading with YAML
- ROS 2 launch integration
- structured logging
- basic parameter validation

## Project structure

```text
rosnext_ws/
├── config/
├── docker/
├── docs/
├── launch/
├── scripts/
├── src/
│   ├── communication/
│   │   └── heartbeat_node/
│   ├── control/
│   └── perception/
├── .gitignore
├── README.md
└── rosnext.toml
````

## Included starter package

The `heartbeat_node` package is the official RosNext starter package for communication examples.

Its purpose is to:

* validate that the workspace builds correctly
* provide a reference ROS 2 package structure
* demonstrate parameter loading from YAML
* show how to integrate a launch file
* establish a baseline for logging and validation practices

## Requirements

* Ubuntu 22.04 or compatible
* ROS 2 Humble
* `colcon`
* `rosdep`

## Quick start

Source ROS 2:

```bash
source /opt/ros/humble/setup.bash
```

Install dependencies:

```bash
cd ~/rosnext_ws
rosdep install --from-paths src --ignore-src -r -y
```

Build the workspace:

```bash
colcon build
```

Source the workspace:

```bash
source install/setup.bash
```

Run the starter package:

```bash
ros2 launch heartbeat_node bringup.launch.py
```

## Verify published topic

In another terminal:

```bash
source /opt/ros/humble/setup.bash
source ~/rosnext_ws/install/setup.bash
ros2 topic echo /heartbeat
```

You should see output similar to:

```text
data: RosNext heartbeat OK
```

## Goals of RosNext

RosNext aims to provide a clean and scalable foundation for ROS 2 projects by promoting:

* modular package organization
* reusable project structure
* consistent configuration patterns
* better developer onboarding
* future automation through CLI tooling and templates

## Roadmap

Planned next steps for RosNext include:

* workspace bootstrap scripts
* CLI commands such as `rosnext init`
* Docker support
* CI integration with GitHub Actions
* additional starter packages
* dashboards and telemetry tools

## Notes

This repository is currently an early foundation of RosNext. The initial goal is to establish a reliable structure that can later evolve into a reusable GitHub template and developer toolchain for robotics projects.

---

Made with ❤️ by [@ochoagram](https://github.com/ochoagram)
