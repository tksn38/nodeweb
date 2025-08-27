#!/bin/bash
IPAddress="xxx.xxx.xxx.xxx"
curl -v --silent $IPAddress:80 2>&1 | grep "小马看奥运"
