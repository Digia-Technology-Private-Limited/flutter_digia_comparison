#!/bin/bash

APP_NAME=$1
PACKAGE_NAME=$2
LOG_FILE="${APP_NAME}_cold_start_results.csv"

echo "Run,ColdStartTime(ms),DigiaInitTime(ms),Timestamp" > "$LOG_FILE"

for i in {1..15}
do
  echo "---- $APP_NAME Run #$i ----"

  adb shell am force-stop $PACKAGE_NAME
  adb logcat -c
  adb shell monkey -p $PACKAGE_NAME -c android.intent.category.LAUNCHER 1 > /dev/null

  # Wait until logs are available
  COLD_START_TIME=""
  DIGIA_INIT_TIME=""

  for _ in {1..15}
  do
    LOG=$(adb logcat -d)
    COLD_START_TIME=$(echo "$LOG" | sed -n 's/.*Cold Start Time: \([0-9]*\) ms.*/\1/p')
    DIGIA_INIT_TIME=$(echo "$LOG" | sed -n 's/.*Digia Init Time: \([0-9]*\) ms.*/\1/p')

    if [ ! -z "$COLD_START_TIME" ]; then
      break
    fi

    sleep 1
  done

  if [ -z "$COLD_START_TIME" ]; then
    echo "⚠️ Cold Start Time not found for run #$i."
  fi

  if [ -z "$DIGIA_INIT_TIME" ]; then
    DIGIA_INIT_TIME="0"  # No Digia Init (for noDigia builds)
  fi

  TS=$(date '+%Y-%m-%d %H:%M:%S')
  echo "$i,$COLD_START_TIME,$DIGIA_INIT_TIME,$TS" >> "$LOG_FILE"
  echo "Run #$i: Cold Start=$COLD_START_TIME ms, Digia Init=$DIGIA_INIT_TIME ms"
done

echo "✅ Results saved to $LOG_FILE"
