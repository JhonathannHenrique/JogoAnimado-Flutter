import 'package:flutter/material.dart';

class Car {
  final String id;
  final String name;
  final IconData iconData;
  final Color color;
  final double speed;
  final double acceleration;

  const Car({
    required this.id,
    required this.name,
    required this.iconData,
    required this.color,
    required this.speed,
    required this.acceleration,
  });

  // Mock data para a Garagem
  static const List<Car> availableCars = [
    Car(
      id: 'car_1',
      name: 'Turbo Vermelho',
      iconData: Icons.directions_car,
      color: Colors.redAccent,
      speed: 0.85,
      acceleration: 0.90,
    ),
    Car(
      id: 'car_2',
      name: 'Bólido Azul',
      iconData: Icons.electric_car,
      color: Colors.blueAccent,
      speed: 0.95,
      acceleration: 0.80,
    ),
    Car(
      id: 'car_3',
      name: 'Relâmpago Amarelo',
      iconData: Icons.sports_motorsports,
      color: Colors.amber,
      speed: 0.99,
      acceleration: 0.95,
    ),
    Car(
      id: 'car_4',
      name: 'Tanque Verde',
      iconData: Icons.airport_shuttle,
      color: Colors.green,
      speed: 0.60,
      acceleration: 0.50,
    ),
  ];
}
