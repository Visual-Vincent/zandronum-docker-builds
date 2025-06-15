#!/bin/bash
set -e

# Install dependencies required at runtime
dnf -y install SDL libXcursor libjpeg

# Clear package cache
dnf -y clean all

set +e
