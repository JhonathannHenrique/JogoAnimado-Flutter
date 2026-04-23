import 'package:flutter/material.dart';

// REQUISITO 4: Widget Customizado Reutilizável
class CarStatBar extends StatelessWidget {
  final String name;
  final double value;
  final Color color;

  // Uso de const constructor sempre que possível para otimização
  const CarStatBar({
    super.key,
    required this.name,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '${(value * 100).toInt()}%',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: color,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: value,
              color: color,
              backgroundColor: color.withOpacity(0.2),
              minHeight: 12,
            ),
          ),
        ],
      ),
    );
  }
}
