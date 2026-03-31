import os

from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch_ros.actions import Node


def generate_launch_description():
    package_share_directory = get_package_share_directory('heartbeat_node')
    config_file = os.path.join(package_share_directory, 'config', 'params.yaml')

    return LaunchDescription([
        Node(
            package='heartbeat_node',
            executable='heartbeat_node',
            name='heartbeat_node',
            output='screen',
            parameters=[config_file]
        )
    ])