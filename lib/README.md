# TweenAnimationBuilder Demo — Flutter

A food delivery order tracker demonstrating the Flutter `TweenAnimationBuilder` widget.

## Widget
`TweenAnimationBuilder` — animates any value between two points automatically,
without needing an AnimationController. Works with doubles, colors, sizes, and more.

## Real-world use case
Food delivery order tracker. The progress ring animates smoothly between
stages (Placed → Preparing → On the Way → Delivered), with live percentage,
changing icons, and colour transitions — all driven by TweenAnimationBuilder.

## How to run
1. Make sure Flutter is installed — run `flutter doctor`
2. Clone this repo
3. Run `flutter pub get`
4. Run `flutter run`

## Three properties demonstrated

| Property | What it does |
|---|---|
| `tween` | Defines the start and end values. The widget animates between them automatically every time `end` changes |
| `duration` | Controls how long the animation takes — set to 800ms for a smooth feel |
| `curve` | Controls the speed shape — `Curves.easeInOut` starts slow, speeds up, then eases to a stop |

## Screenshot
![App Screenshot](screenshot.png)