#!/bin/bash

if test -f /etc/bobcat_version; then
  cat /etc/bobcat_version > /var/dashboard/statuses/bobcat_ver
fi
