import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MiniCricketScreen(),
    ),  
  );
}


class MiniCricketScreen extends StatefulWidget {
  const MiniCricketScreen({super.key});

  @override
  State<MiniCricketScreen> createState() => _MiniCricketScreenState();
}

class _MiniCricketScreenState extends State<MiniCricketScreen> {
  static const int ballsPerOver = 6;
  static const List<int> possibleRuns = [0, 1, 2, 3, 4, 6];

  final Random _random = Random();

  int runs = 0;
  int balls = 0;
  int? lastBallRuns; // null until the first ball is bowled

  bool get overFinished => balls >= ballsPerOver;

  void _bowlBall() {
    if (overFinished) return;

    final int outcome = possibleRuns[_random.nextInt(possibleRuns.length)];

    setState(() {
      lastBallRuns = outcome;
      runs += outcome;
      balls += 1;
    });
  }

  void _restart() {
    setState(() {
      runs = 0;
      balls = 0;
      lastBallRuns = null;
    });
  }

  String get _statusText {
    if (overFinished) return 'Over finished — Total: $runs Runs';
    if (lastBallRuns == null) return '';
    return lastBallRuns == 0 ? 'No Runs' : '$lastBallRuns Runs';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini Cricket'), backgroundColor: Colors.blue),
      backgroundColor: Colors.blue,
      body: SafeArea(
        // ---- Outer Column ----
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ---- Row( Col(I1,T1,V1), Col(I2,T2,V2) ) ----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatCard(
                  icon: Icons.sports_cricket,          // I1
                  label: 'Runs',                       // T1
                  value: runs,                          // V1
                ),
                _StatCard(
                  icon: Icons.circle,                   // I2
                  iconColor: Colors.red,
                  label: 'Balls',                       // T2
                  value: balls,                          // V2
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ---- statusText ----
            SizedBox(
              height: 24,
              child: Text(
                _statusText,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),

            // ---- Button (Bat -> Restart once over finishes) ----
            ElevatedButton(
              onPressed: overFinished ? _restart : _bowlBall,
              style: ElevatedButton.styleFrom(
                backgroundColor: overFinished ? Colors.red : Colors.white,
                foregroundColor: overFinished ? Colors.white : Colors.blue.shade900,
              ),
              child: Text(overFinished ? 'Restart' : 'Bat'),
            ),
          ],
        ),
      ),
    );
  }
}

/// One "card": Column( Image, Text label, Value )
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final int value;

  const _StatCard({
    required this.icon,
    this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // I (Image/icon)
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 48, color: iconColor ?? Colors.black87),
        ),
        const SizedBox(height: 8),
        // T (Text label)
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 4),
        // V (Value)
        Text(
          '$value',
          style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}