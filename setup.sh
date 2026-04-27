#!/bin/bash
# Initial Setup Script for Raspberry Pi 3
# This script installs Ansible and runs the playbook

set -e  # Exit on error

echo "=========================================="
echo "Raspberry Pi Ansible Setup"
echo "=========================================="
echo ""

# Update package list
echo "Step 1/5: Updating package list..."
sudo apt update

# Configure Git
echo ""
echo "Step 2/5: Configuring Git..."
git config --global user.name "raspi"
git config --global user.email "raspi@localhost"
echo "Git configured with user: raspi"

# Install Ansible
echo ""
echo "Step 3/4: Installing Ansible..."
sudo apt install -y ansible

# Run the Ansible playbook
echo ""
echo "Step 4/4: Running Ansible playbook..."
ansible-playbook dropbox-gallery/ansible.yml
