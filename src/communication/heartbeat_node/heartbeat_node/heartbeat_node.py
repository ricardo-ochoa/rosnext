import rclpy
from rclpy.node import Node
from std_msgs.msg import String


class HeartbeatNode(Node):
    def __init__(self):
        super().__init__('heartbeat_node')

        self.declare_parameter('message', 'RosNext heartbeat OK')
        self.declare_parameter('topic_name', '/heartbeat')
        self.declare_parameter('period', 1.0)

        self.message_text = self.get_parameter('message').value
        self.topic_name = self.get_parameter('topic_name').value
        self.period = self.get_parameter('period').value

        self._validate_parameters()

        self.publisher_ = self.create_publisher(String, self.topic_name, 10)
        self.timer = self.create_timer(self.period, self.publish_heartbeat)

        self.get_logger().info(
            f'[RosNext] heartbeat_node started | topic={self.topic_name} | '
            f'period={self.period} | message="{self.message_text}"'
        )

    def _validate_parameters(self):
        if not isinstance(self.message_text, str) or not self.message_text.strip():
            raise ValueError("Invalid parameter: 'message' must be a non-empty string")

        if not isinstance(self.topic_name, str) or not self.topic_name.strip():
            raise ValueError("Invalid parameter: 'topic_name' must be a non-empty string")

        if not isinstance(self.period, (int, float)) or self.period <= 0:
            raise ValueError("Invalid parameter: 'period' must be greater than 0")

    def publish_heartbeat(self):
        try:
            msg = String()
            msg.data = self.message_text
            self.publisher_.publish(msg)
            self.get_logger().info(f'[RosNext] Published heartbeat: "{msg.data}"')
        except Exception as error:
            self.get_logger().error(f'[RosNext] Publish error: {error}')


def main(args=None):
    rclpy.init(args=args)
    node = None

    try:
        node = HeartbeatNode()
        rclpy.spin(node)
    except Exception as error:
        if node is not None:
            node.get_logger().error(f'[RosNext] Critical node error: {error}')
        else:
            print(f'[RosNext] Initialization error: {error}')
    finally:
        if node is not None:
            node.destroy_node()
        rclpy.shutdown()


if __name__ == '__main__':
    main()