#!/bin/bash
#
rclone mount yandex: /home/serg/cloud/yandex --daemon
rclone mount google: /home/serg/cloud/google --daemon
rclone mount onedrive: /home/serg/cloud/onedrive --daemon
