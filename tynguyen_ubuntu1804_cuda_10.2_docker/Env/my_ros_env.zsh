source /opt/ros/melodic/setup.zsh

#source ~/catkin_ws/devel/setup.zsh

unset ROS_HOSTNAME

export ROS_MASTER_IP=10.10.20.115

export ROS_IP=${ROS_MASTER_IP}


export ROS_MASTER_URI=http://${ROS_MASTER_IP}:11311/


