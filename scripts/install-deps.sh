#!/usr/bin/env bash

# This script installs dependencies for Yocto build environment on Ubuntu/Debian systems.

echo "Updating package lists..."
sudo apt-get update

echo "Installing required packages..."
sudo apt-get install -y --allow-unauthenticated gawk wget git diffstat unzip texinfo gcc build-essential \
chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils \
iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 \
xterm python3-subunit mesa-common-dev zstd liblz4-tool


echo "Installing additional upgraded packages..."
sudo apt-get upgrade -y