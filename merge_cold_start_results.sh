#!/bin/bash

# Files
NODIGIA_FILE="nodigia_cold_start_results.csv"
CACHEINIT_FILE="cacheinit_cold_start_results.csv"
NETWORKINIT_FILE="networkinit_cold_start_results.csv"
OUTPUT_FILE="merged_cold_start_results.csv"

# Write header
echo "Run,NoDigia_ColdStart(ms),NoDigia_DigiaInit(ms),CacheInit_ColdStart(ms),CacheInit_DigiaInit(ms),NetworkInit_ColdStart(ms),NetworkInit_DigiaInit(ms)" > "$OUTPUT_FILE"

# Read and merge
for i in {1..15}
do
  NODIGIA_ROW=$(sed -n "$((i+1))p" "$NODIGIA_FILE")
  CACHEINIT_ROW=$(sed -n "$((i+1))p" "$CACHEINIT_FILE")
  NETWORKINIT_ROW=$(sed -n "$((i+1))p" "$NETWORKINIT_FILE")

  NODIGIA_COLDSTART=$(echo "$NODIGIA_ROW" | cut -d',' -f2)
  NODIGIA_DIGIAINIT=$(echo "$NODIGIA_ROW" | cut -d',' -f3)

  CACHEINIT_COLDSTART=$(echo "$CACHEINIT_ROW" | cut -d',' -f2)
  CACHEINIT_DIGIAINIT=$(echo "$CACHEINIT_ROW" | cut -d',' -f3)

  NETWORKINIT_COLDSTART=$(echo "$NETWORKINIT_ROW" | cut -d',' -f2)
  NETWORKINIT_DIGIAINIT=$(echo "$NETWORKINIT_ROW" | cut -d',' -f3)

  echo "$i,$NODIGIA_COLDSTART,$NODIGIA_DIGIAINIT,$CACHEINIT_COLDSTART,$CACHEINIT_DIGIAINIT,$NETWORKINIT_COLDSTART,$NETWORKINIT_DIGIAINIT" >> "$OUTPUT_FILE"
done

echo "✅ Merged results saved to $OUTPUT_FILE"
