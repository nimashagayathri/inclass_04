# Mini Cricket App

A simple Flutter app that simulates one over (6 balls) of a cricket innings.

## Features

- Tap **Bat** to "bowl" a ball — a random result is picked from `0, 1, 2, 3, 4, 6`.
- **Runs** and **Balls** counters update after every tap.
- The result of each ball is shown below the counters as `"X Runs"` or `"No Runs"` (for a dot ball).
- Once **6 balls** (one over) have been bowled, the button turns into a red **Restart** and the total score for the over is displayed.
- Tapping **Restart** resets Runs, Balls, and the status text back to zero so a new over can begin.

## Widget Tree

The screen follows this structure:

```
Column(
  Row(
    Col( I1, T1, V1 ),   // bat icon, "Runs" label, runs value
    Col( I2, T2, V2 ),   // ball icon, "Balls" label, balls value
  ),
  statusText,             // "3 Runs" / "No Runs" / final total
  Button,                 // "Bat" while the over is in progress, "Restart" after
)
```

- Each `Col(I, T, V)` is implemented as a small `_StatCard` widget: an icon box, a text label, and the current value stacked vertically.
- The outer `Row` places the two cards (bat/Runs and ball/Balls) side by side.
- The outer `Column` stacks: the Row of cards → the status text → the button.

## Project Structure

```
lib/
  main.dart   # MaterialApp entry point + MiniCricketScreen + _StatCard widgets
```

## Getting Started

1. Make sure the [Flutter SDK](https://flutter.dev) is installed (`flutter doctor` should pass).
2. From the project root (the folder containing `pubspec.yaml`), run:
   ```
   flutter pub get
   flutter run
   ```
3. Choose a connected device or an available browser (e.g. Chrome) when prompted.

## Notes

- Game logic lives entirely in `_MiniCricketScreenState` (`_bowlBall()` and `_restart()`).
- `possibleRuns` and `ballsPerOver` are defined as constants at the top of the state class, so the outcomes or over length can be changed easily.