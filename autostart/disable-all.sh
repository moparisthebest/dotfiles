#!/bin/bash
set -euxo pipefail

cd ~/.config/autostart/
ls /etc/xdg/autostart/ | tr '\n' '\0' | xargs -0 -n1 ln -s disabled.desktop
