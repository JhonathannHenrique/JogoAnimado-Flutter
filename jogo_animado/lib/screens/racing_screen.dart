import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/car.dart';
import '../widgets/car_stat_bar.dart';
import '../painters/track_painter.dart';

class RacingScreen extends StatefulWidget {
  final Car car;

  const RacingScreen({
    super.key,
    required this.car,
  });

  @override
  State<RacingScreen> createState() => _RacingScreenState();
}

class _RacingScreenState extends State<RacingScreen>
    with TickerProviderStateMixin {
  // REQUISITO 3 (Animação Explícita)
  late AnimationController _engineController;
  late Animation<double> _vibrationAnimation;
  
  // Controller para animação contínua da pista
  late AnimationController _roadController;

  @override
  void initState() {
    super.initState();
    // Configurando o AnimationController para o tremor constante do motor
    _engineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    // CurvedAnimation para suavizar a vibração
    final curvedVibration = CurvedAnimation(
      parent: _engineController,
      curve: Curves.easeInOut,
    );

    // Tween de -1.0 a 1.0 que multiplicaremos para gerar um offset de tremor
    _vibrationAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(curvedVibration);

    // Configurando o AnimationController para mover a rua rapidamente
    _roadController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    // REQUISITO 3 (Obrigatório): Limpar controller com dispose()
    _engineController.dispose();
    _roadController.dispose();
    super.dispose();
  }

  void _startRace() {
    // Inicia e repete a engine vibration animando o controle (ida e volta)
    if (_engineController.isAnimating) {
      _engineController.stop();
      _roadController.stop();
    } else {
      _engineController.repeat(reverse: true);
      _roadController.repeat(); // Rua vindo em direção infinita
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.car.name),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // REQUISITO 5: CustomPainter desenhando a pista de fundo animada
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _roadController,
              builder: (context, child) {
                return CustomPaint(
                  painter: TrackPainter(
                    stripeColor: widget.car.color,
                    animationValue: _roadController.value,
                  ),
                );
              },
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 1),
                // REQUISITO 3 (Animação Explícita usando AnimatedBuilder)
                AnimatedBuilder(
                  animation: _vibrationAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      // Multiplicamos o offset de tremor por 3 pixels de força X e 1.5 Y
                      offset: Offset(
                        _vibrationAnimation.value * 3.0,
                        _vibrationAnimation.value * 1.5,
                      ),
                      child: child,
                    );
                  },
                  // REQUISITO 3 (Hero Animation): Recebendo a tag da Garagem
                  child: Hero(
                    tag: 'car_image_${widget.car.id}',
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: widget.car.color.withOpacity(0.2),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: widget.car.color.withOpacity(0.4),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        widget.car.iconData,
                        size: 150,
                        color: widget.car.color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Painel de Estatísticas focado no M3 (Cards Estilizados)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Desempenho do Veículo',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 20),
                          // REQUISITO 4: Uso do componente reutilizável (pelo menos 2x)
                          CarStatBar(
                            name: 'Velocidade Máxima',
                            value: widget.car.speed,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(height: 10),
                          CarStatBar(
                            name: 'Aceleração Média',
                            value: widget.car.acceleration,
                            color: Colors.blueAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                // REQUISITO 2: Usar FilledButton do Material 3
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton.icon(
                      onPressed: _startRace,
                      icon: AnimatedIconWidget(controller: _engineController),
                      label: AnimatedTextWidget(controller: _engineController),
                      style: FilledButton.styleFrom(
                        backgroundColor: widget.car.color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widgets auxiliares para o botão
class AnimatedIconWidget extends StatelessWidget {
  final AnimationController controller;
  const AnimatedIconWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Icon(
          controller.isAnimating ? Icons.stop : Icons.play_arrow,
          size: 28,
        );
      },
    );
  }
}

class AnimatedTextWidget extends StatelessWidget {
  final AnimationController controller;
  const AnimatedTextWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Text(
          controller.isAnimating ? 'PARAR CORRIDA' : 'INICIAR CORRIDA',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        );
      },
    );
  }
}
