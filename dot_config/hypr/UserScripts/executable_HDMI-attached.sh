#!/usr/bin/env bash

# This script runs when HDMI is plugged/unplugged to move workspaces 1-5 and maintain focus

# Get current workspace IMMEDIATELY - before any delays or monitor detection
CURRENT_WS=$(hyprctl activeworkspace -j | jq -r ".id")

# Small delay to ensure monitors are fully detected
sleep 0.5

# Get monitor names
LAPTOP=$(hyprctl monitors -j | jq -r '.[] | select(.name | test("^eDP")) | .name' | head -n1)
EXTERNAL=$(hyprctl monitors -j | jq -r '.[] | select(.name | test("^(HDMI|DP)")) | .name' | head -n1)
EXTERNAL=${EXTERNAL:=${LAPTOP}}

for i in $(hyprctl workspaces -j | jq -r '.[] | select(.id >= 1 and .id <= 5) | select(.monitor | test("^eDP")) | .id'); do
  hyprctl dispatch moveworkspacetomonitor "${i}" "${EXTERNAL}"
done

# Switch to the workspace we were on
hyprctl dispatch workspace "${CURRENT_WS}"

# Focus the external monitor
hyprctl dispatch focusmonitor "${EXTERNAL}"

# if [[ -n "$EXTERNAL" ]]; then
#   # === PLUG CASE: HDMI was added ===
#   # Move workspaces 1-5 that are on eDP (laptop) to external
#   for i in $(hyprctl workspaces -j | jq -r '.[] | select(.id >= 1 and .id <= 5) | select(.monitor | test("^eDP")) | .id'); do
#     hyprctl dispatch moveworkspacetomonitor "${i}" "${EXTERNAL}"
#   done
#
#   # Switch to the workspace we were on
#   hyprctl dispatch workspace "${CURRENT_WS}"
#
#   # Focus the external monitor
#   hyprctl dispatch focusmonitor "${EXTERNAL}"
# else
#   # === UNPLUG CASE: HDMI was removed ===
#   # Move workspaces 1-5 that are on external to laptop
#   for i in $(hyprctl workspaces -j | jq -r '.[] | select(.id >= 1 and .id <= 5) | select(.monitor | test("^(HDMI|DP)")) | .id'); do
#     hyprctl dispatch moveworkspacetomonitor "${i}" "${LAPTOP}"
#   done
#
#   # Switch to the workspace we were on
#   hyprctl dispatch workspace "${CURRENT_WS}"
#
#   # Focus the laptop monitor
#   hyprctl dispatch focusmonitor "${LAPTOP}"
# fi
