#!/bin/bash

if test -f /etc/bobcat-version; then
  cat /etc/bobcat-version > /var/dashboard/statuses/bobcat_ver
fi
