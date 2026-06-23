import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TweenAnimationBuilder Demo',
      theme: ThemeData.dark(),
      home: const OrderTrackerPage(),
    );
  }
}

class OrderTrackerPage extends StatefulWidget {
  const OrderTrackerPage({super.key});

  @override
  State<OrderTrackerPage> createState() => _OrderTrackerPageState();
}

class _OrderTrackerPageState extends State<OrderTrackerPage> {

  // Each stage has a progress value, colour, icon, and label
  final List<Map<String, dynamic>> _stages = [
    {
      'label': 'Order Placed',
      'progress': 0.0,
      'color': Colors.grey,
      'icon': Icons.receipt_long,
    },
    {
      'label': 'Preparing',
      'progress': 0.33,
      'color': Colors.orange,
      'icon': Icons.restaurant,
    },
    {
      'label': 'On the Way',
      'progress': 0.66,
      'color': Colors.blue,
      'icon': Icons.delivery_dining,
    },
    {
      'label': 'Delivered!',
      'progress': 1.0,
      'color': Colors.greenAccent,
      'icon': Icons.check_circle,
    },
  ];

  int _currentStage = 0;

  // These are the values TweenAnimationBuilder animates BETWEEN
  double _targetProgress = 0.0;
  Color _targetColor = Colors.grey;

  void _nextStage() {
    if (_currentStage < _stages.length - 1) {
      setState(() {
        _currentStage++;
        _targetProgress = _stages[_currentStage]['progress'];
        _targetColor = _stages[_currentStage]['color'];
      });
    }
  }

  void _reset() {
    setState(() {
      _currentStage = 0;
      _targetProgress = 0.0;
      _targetColor = Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f0e17),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a2e),
        title: const Text('Order Tracker'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                'Your Order',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                _stages[_currentStage]['label'],
                style: TextStyle(
                  color: _targetColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 48),

              // ══════════════════════════════════════════════
              // TWEEN ANIMATION BUILDER — ANIMATES THE RING
              // ══════════════════════════════════════════════
              TweenAnimationBuilder<double>(

                // PROPERTY 1: tween
                // Defines the START and END values to animate between.
                // The builder always animates from its current position
                // to the new 'end' value whenever end changes.
                tween: Tween<double>(begin: 0.0, end: _targetProgress),

                // PROPERTY 2: duration
                // How long the animation takes to complete.
                // 800ms feels smooth — try 3000ms to see it crawl.
                duration: const Duration(milliseconds: 800),

                // PROPERTY 3: curve
                // Controls the speed shape of the animation.
                // easeInOut starts slow, speeds up, then slows at the end.
                // Try Curves.linear or Curves.bounceOut to see the difference.
                curve: Curves.easeInOut,

                // builder fires on every animation frame with the
                // current interpolated value between begin and end
                builder: (context, double value, child) {
                  return SizedBox(
                    width: 220,
                    height: 220,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [

                        // Progress ring drawn with CircularProgressIndicator
                        SizedBox(
                          width: 220,
                          height: 220,
                          child: CircularProgressIndicator(
                            value: value,
                            strokeWidth: 14,
                            backgroundColor: const Color(0xFF2a2a4a),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _targetColor,
                            ),
                          ),
                        ),

                        // Centre content
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _stages[_currentStage]['icon'],
                              size: 52,
                              color: _targetColor,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              // Show the live animated percentage
                              '${(value * 100).toInt()}%',
                              style: TextStyle(
                                color: _targetColor,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  );
                },
              ),
              // ══════════════════════════════════════════════

              const SizedBox(height: 48),

              // Stage dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_stages.length, (i) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: i == _currentStage ? 24 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: i <= _currentStage
                          ? _stages[i]['color']
                          : const Color(0xFF2a2a4a),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 40),

              // Next stage button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _currentStage == _stages.length - 1
                      ? const Color(0xFF1a1a2e)
                      : const Color(0xFFe94560),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _currentStage < _stages.length - 1
                    ? _nextStage
                    : null,
                icon: const Icon(Icons.arrow_forward),
                label: Text(
                  _currentStage < _stages.length - 1
                      ? 'Next Stage'
                      : 'Order Complete',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Reset button
              TextButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh, color: Colors.white54),
                label: const Text(
                  'Reset order',
                  style: TextStyle(color: Colors.white54),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}