#!/bin/sh
if eww active-windows | grep -q dashboard_window; then
  eww close dashboard_window
else
  eww open dashboard_window
fi
