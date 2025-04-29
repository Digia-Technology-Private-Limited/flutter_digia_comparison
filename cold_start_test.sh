#!/bin/bash

APP_NAME=$1
PACKAGE_NAME=$2
LOG_FILE="${APP_NAME}_cold_start_results.csv"

echo "Run,ColdStartTime(ms),Timestamp" > "$LOG_FILE"

for i in {1..5}
do
  echo "---- $APP_NAME Run #$i ----"
  adb shell am force-stop $PACKAGE_NAME
  adb logcat -c
  adb shell monkey -p $PACKAGE_NAME -c android.intent.category.LAUNCHER 1 > /dev/null

  # Wait until the log appears
  TIME=""
  for _ in {1..15}
  do
    LOG=$(adb logcat -d | grep "Cold Start Time")
    TIME=$(echo "$LOG" | sed -n 's/.*Cold Start Time: \([0-9]*\) ms.*/\1/p')

    if [ ! -z "$TIME" ]; then
      break
    fi

    sleep 1
  done

  if [ -z "$TIME" ]; then
    echo "⚠️ Cold Start Time not found for run #$i."
  fi

  TS=$(date '+%Y-%m-%d %H:%M:%S')
  echo "$i,$TIME,$TS" >> "$LOG_FILE"
  echo "Run #$i: $TIME ms"
done

echo "✅ Results saved to $LOG_FILE"
