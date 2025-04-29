# 🚀 Flutter Digia Comparison

A benchmarking project to measure and compare Flutter Native App cold start performance against Digia SDK (Server-Driven UI) initialization.

This project helps evaluate:

- 🚀 App cold start times
- ⏳ Digia SDK initialization times
- 🆚 Different initialization modes: Pure Flutter, Digia Cache Init, Digia Network Init

## 📦 Project Structure

| Folder/File | Purpose |
| ----------- | ------- |
| `lib/main.dart` | Entry point: measures cold start & Digia SDK init |
| `lib/performance_landing.dart` | Home screen listing all benchmark scenarios |
| `lib/scenario_selector/` | Scenario selector screen |
| `lib/scenarios/` | Flutter-native sample implementations |
| `cold_start_test.sh` | Shell script to measure cold start for APKs |
| `merge_cold_start_results.sh` | Script to merge all CSV results into one |

## 🛠 Flavors Setup

| Flavor | Dart Define (init_mode) | Description |
| ------ | ----------------------- | ----------- |
| No Digia | `noDigia` | Pure Flutter app without Digia SDK |
| Cache Init | `cacheInit` | Digia SDK initialized from local cache |
| Network Init | `networkInit` | Digia SDK initialized from network |

## 🛠 Setup Instructions

### 1. Build the APKs

```bash
flutter build apk --release --dart-define=init_mode=noDigia -t lib/main.dart --flavor nodigia --no-tree-shake-icons
mv build/app/outputs/flutter-apk/app-nodigia-release.apk app_nodigia.apk

flutter build apk --release --dart-define=init_mode=cacheInit -t lib/main.dart --flavor cacheinit --no-tree-shake-icons
mv build/app/outputs/flutter-apk/app-cacheinit-release.apk app_cacheinit.apk

flutter build apk --release --dart-define=init_mode=networkInit -t lib/main.dart --flavor networkinit --no-tree-shake-icons
mv build/app/outputs/flutter-apk/app-networkinit-release.apk app_networkinit.apk
```

### 2. Install APKs and Run Cold Start Tests

Install and test each APK separately:

```bash
# No Digia (Pure Flutter)
adb install -r app_nodigia.apk
./cold_start_test.sh nodigia com.digia.benchmark.nodigia

# Cache Init (Digia SDK from local)
adb install -r app_cacheinit.apk
./cold_start_test.sh cacheinit com.digia.benchmark.cache

# Network Init (Digia SDK from network)
adb install -r app_networkinit.apk
./cold_start_test.sh networkinit com.digia.benchmark.network
```

### 3. Merge All Results

```bash
./merge_cold_start_results.sh
```

This generates:
- ✅ `merged_cold_start_results.csv`

## 📊 Example Cold Start Results (Sample)

| Flavor | Avg Cold Start Time (ms) | Avg Digia Init Time (ms) |
| ------ | ------------------------ | ------------------------ |
| No Digia | ~20ms | 0ms |
| Cache Init | ~60ms | ~40ms |
| Network Init | ~220ms | ~180ms |

## 📈 Visualizations

- 📊 Stacked bar chart:
   - 🟦 Total App Startup Time
   - 🟩 Digia Init Time (inside the total)
   - 🖌️ Fancy 3D-style chart with clear labeling.

## 🎯 Why This Benchmark?

This project scientifically proves:
- How a Server-Driven UI SDK like Digia affects real-world app launch performance.
- Helps teams balance startup performance vs dynamic flexibility.
- Useful for teams making technical architecture decisions.

## 📚 References

- [Flutter Performance Best Practices](https://flutter.dev/docs/perf/rendering/best-practices)


## 🚀 Quick Commands (Cheat Sheet)

| Task | Command |
| ---- | ------- |
| Build APK (no Digia) | `flutter build apk --release --dart-define=init_mode=noDigia` |
| Install APK | `adb install -r app_nodigia.apk` |
| Run Cold Start Test | `./cold_start_test.sh nodigia com.digia.benchmark.nodigia` |
| Merge Results | `./merge_cold_start_results.sh` |

## 📄 License

This project is licensed under the MIT License.