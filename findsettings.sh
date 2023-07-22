#! /bin/bash
# Searching and displaying settings in linux folders

sudo find /home -name 'Settings.xml' -size +503c -exec cat {} \;