import 'package:flutter/material.dart';
import '../models/car.dart';
import 'racing_screen.dart';

class GarageScreen extends StatelessWidget {
  const GarageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold M3
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garagem - Escolha seu Carro'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: Car.availableCars.length,
        itemBuilder: (context, index) {
          final car = Car.availableCars[index];
          return _GarageCarItem(car: car);
        },
      ),
    );
  }
}

class _GarageCarItem extends StatefulWidget {
  final Car car;

  const _GarageCarItem({required this.car});

  @override
  State<_GarageCarItem> createState() => _GarageCarItemState();
}

class _GarageCarItemState extends State<_GarageCarItem> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    // Navegar para a tela de corrida
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RacingScreen(car: widget.car),
      ),
    );
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      // REQUISITO 3 (Animação Implícita): 
      // AnimatedContainer respondendo ao toque (mudança de tamanho/borda)
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.all(_isPressed ? 12.0 : 16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isPressed 
              ? widget.car.color 
              : Colors.transparent,
            width: _isPressed ? 3 : 1,
          ),
          boxShadow: _isPressed
              ? [
                  BoxShadow(
                    color: widget.car.color.withOpacity(0.5),
                    blurRadius: 15,
                    spreadRadius: 2,
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Row(
          children: [
            // REQUISITO 3 (Hero Animation): Hero transition da imagem do carro
            Hero(
              tag: 'car_image_${widget.car.id}',
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: widget.car.color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.car.iconData,
                  size: 50,
                  color: widget.car.color,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.car.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Toque para selecionar',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
