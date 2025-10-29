import 'package:flutter/material.dart';
import 'package:pcfsim_ui/apptheme/apptheme.dart';

class SimpleBarChart extends StatelessWidget {
  const SimpleBarChart._({super.key});

  factory SimpleBarChart.withSampleData() => const SimpleBarChart._();

  @override
  Widget build(BuildContext context) {
    final data = <_BarDatum>[
      _BarDatum('Today', 55),
      _BarDatum('Yesterday', 25),
      _BarDatum('2 days', 100),
      _BarDatum('24 Jun', 75),
      _BarDatum('23 Jun', 15),
      _BarDatum('22 Jun', 85),
      _BarDatum('21 Jun', 45),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxValue = data.map((d) => d.value).fold<int>(0, (a, b) => a > b ? a : b);
        final double barWidth = (constraints.maxWidth / data.length)
            .clamp(16.0, 100.0)
            .toDouble();
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final d in data)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: (constraints.maxHeight - 24) * (d.value / (maxValue == 0 ? 1 : maxValue)),
                        width: barWidth,
                        decoration: BoxDecoration(
                          color: active,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        d.label,
                        style: const TextStyle(fontSize: 10, color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _BarDatum {
  final String label;
  final int value;
  _BarDatum(this.label, this.value);
}
