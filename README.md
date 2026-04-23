# Jogo de Carros Animado - Flutter 🏎️💨

Este é um projeto desenvolvido como atividade acadêmica para a disciplina de **Desenvolvimento Mobile**. O objetivo deste aplicativo é demonstrar o domínio de conceitos avançados de UI no Flutter, com um foco profundo em Animações (Implícitas, Explícitas e Hero Transitions), Desenho Customizado (CustomPainter) e Material Design 3.

---

## 📸 Estrutura das Telas

O aplicativo possui arquitetura enxuta e está dividido em duas telas principais focadas no universo automobilístico:

1. **Garagem (Lista de Carros)**: Onde o jogador pode visualizar os "Bólidos" disponíveis. Ao interagir fisicamente tocando nos cards, o carro ganha um brilho especial indicando a seleção.
2. **Corrida / Detalhes**: Tela focada no carro selecionado, apresentando painéis estatísticos reaproveitáveis de velocidade e aceleração. Ao acionar o botão principal, o visual ganha vida com uma pista deslizando em perspectiva infinita e o motor do carro tremendo através de uma animação constante.

---

## 🎯 Requisitos Técnicos Cumpridos

Todos os requisitos solicitados na documentação e propostas de código estrutural foram perfeitamente implementados:

- **Material Design 3**: Implementação global do `useMaterial3: true` usando um `ColorScheme.fromSeed(seedColor: Colors.blueAccent)` configurado em tema sombrio (ideal para jogos). A UI usa recursos como botões modernos (`FilledButton`) e Cartões estilizados (`surfaceContainerHighest`). 
- **Estruturação de Pastas**: Código rigorosamente separado (`models`, `widgets`, `screens`, `painters`) para melhor manutenção e injeção de dependências.
- **Widgets Reutilizáveis (Customizado)**: Criação do widget `CarStatBar` que recebe parâmetros cruzados (`name`, `value`, `color`) via construtores constantes garantindo altíssima performance. Usado ao menos duas vezes para "Velocidade Média" e "Aceleração".
- **Livre de Warnings**: Todo o código foi validado através dos Lintings do Flutter utilizando `flutter analyze`.

### 🎥 Animações Implementadas

Este é o coração visual do aplicativo. Diferentes tipos de arquiteturas de transição do Flutter foram utilizadas no jogo:

- **Animação Implícita (Garagem)**: Utilização do poderoso `AnimatedContainer` encapsulando componentes que aguardam os ganchos do usuário. Um toque no carro redimensiona os fundos e altera as cores da borda instantaneamente, gerando feedback háptico-visual e "Neon effects".
- **Hero Animation**: Os componentes de desenho dos veículos ganharam `Heroes` linkando a *Garagem* e a *Corrida*. A transição de escala de forma esférica entre cenários é majestosa, passando a sensação de ser um componente único.
- **Animação Explícita (Motor do Carro)**: Animações de quadro-a-quadro matemáticas com o `AnimationController`. Utilizando métodos unificados do `TickerProviderStateMixin`, usamos um controlador matemático de tempo que ativa `Curves` com senooidalidade (`Tween`) para fazer a carcaça do carro apresentar um forte "tremor de força bruta de motor" na tela. Garantido o não-vazamento de memória usando os métodos estritos `dispose()`.
- **(Bônus) CustomPainter**: Incorporado o `TrackPainter` no sub-background que desenha, na mão do próprio framework em Canvas, a pista inteira com geometria simples mas efetiva. Ele conta com faixas centrais que foram linkadas ao tempo de Animações Explícitas, descendo infinitamente contra a tela criando a ilusão ótica de "asfalto em alta velocidade"!

---

## 🚀 Como Rodar o Projeto

**Pré-requisitos**: Possuir o framework do [Flutter / Dart](https://flutter.dev) devidamente instalados no computador e um emulador funcional (Android/iOS) ou macOS de alvo pronto.

**Passos para Execução**:

1. Faça o clone ou baixe este projeto localmente na sua máquina.
2. Abra a interface de terminal (linha de comando) na raiz do projeto `jogo_animado`.
3. Instale/atualize suas dependências (caso precise) rodando o comando:
   ```bash
   flutter pub get
   ```
4. Para realizar a checagem automática e comprovar a estabilidade do código perante o Linting (SEM AVISOS/ERROS), rode:
   ```bash
   flutter analyze
   ```
5. Para testar ativamente a aplicação, rode e selecione seu dispositivo:
   ```bash
   flutter run
   ```

Aproveite a Corrida! 🏎️🏁
