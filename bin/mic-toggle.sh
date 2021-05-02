#!/bin/bash

CARD='C920'

declare -A ICONS=([on]=microphone-sensitivity-high [off]=microphone-sensitivity-muted)

# Toggle the mic
amixer -c ${CARD} sset Mic mute toggle

# Grab the state
STATE=$(amixer -c ${CARD} cget name='Mic Capture Switch' | grep -F ': values=' | cut -f2 -d=)

# Notify
notify-send -t 3000 "${CARD} Mic" ${STATE^^} -i ${ICONS[${STATE}]}
