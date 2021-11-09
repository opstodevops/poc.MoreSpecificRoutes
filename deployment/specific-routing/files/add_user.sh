#!/bin/bash -xe

echo " %wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers; adduser #insert user to add#
usermod -a -G wheel #insert user to add#