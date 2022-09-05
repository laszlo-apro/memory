import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memory/src/audio/audio_controller.dart';
import 'package:memory/src/audio/sounds.dart';
import 'package:memory/src/play_session/game_state.dart';
import 'package:memory/src/play_session/memory_card_label.dart';
import 'package:provider/provider.dart';

class MemoryCard extends StatefulWidget {
  const MemoryCard({
    Key? key,
    required this.size,
    required this.rowIndex,
    required this.columnIndex,
    required this.gameState,
  }) : super(key: key);

  final double size;
  final int rowIndex;
  final int columnIndex;
  final GameState gameState;

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard>
    with SingleTickerProviderStateMixin {
  static const _minAngle = 0.0;
  static const _maxAngle = 180.0;

  late AnimationController _controller;
  late Animation<double> _animation;

  late StreamSubscription<EvaluationResult> _evaluationResultSubscription;

  double _currentAngle = _minAngle;
  bool _frontShown = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {
        _currentAngle = _animation.value;
        _setFrontShown();
      });
    });

    _evaluationResultSubscription = widget
        .gameState.evaluationResultStreamController.stream
        .listen(_handleEvaluationResult);
  }

  @override
  void dispose() {
    _evaluationResultSubscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardState =
        widget.gameState.getCardStateAt(widget.rowIndex, widget.columnIndex);
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(_currentAngle / 180 * pi);

    return Container(
      width: widget.size,
      height: widget.size,
      padding: EdgeInsets.all(widget.size * 0.05),
      child: GestureDetector(
        onTap: _frontShown ? null : _handleTap,
        child: Transform(
          transform: transform,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(widget.size * 0.03),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  bottomRight: Radius.circular(32.0),
                ),
                color: Colors.white,
                image: _frontShown
                    ? DecorationImage(
                        image: AssetImage(cardState.card.imagePath))
                    : null),
            child: _frontShown
                ? Transform(
                    transform: Matrix4.identity()..rotateY(pi),
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        MemoryCardLabel(
                          text: cardState.card.name,
                          leftPadding: 4.0,
                          rightPadding: 16.0,
                        ),
                        Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: MemoryCardLabel(
                            text: cardState.card.role,
                            leftPadding: 16.0,
                            rightPadding: 4.0,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(widget.size * 0.15),
                    child: Image.asset('assets/images/bishop-logo.png'),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleTap() async {
    if (widget.gameState.shouldShow) {
      final audioController = context.read<AudioController>();
      audioController.playSfx(SfxType.buttonTap);

      await _show();

      widget.gameState
          .setCardStateAsShownAt(widget.rowIndex, widget.columnIndex);
      widget.gameState.evaluate();
    }
  }

  void _handleEvaluationResult(EvaluationResult result) {
    if ((result.firstRowIndex == widget.rowIndex &&
            result.firstColumnIndex == widget.columnIndex) ||
        (result.secondRowIndex == widget.rowIndex &&
            result.secondColumnIndex == widget.columnIndex)) {
      Future.delayed(const Duration(milliseconds: 300), () {
        final state = widget.gameState
            .getCardStateAt(widget.rowIndex, widget.columnIndex);
        if (state.shown == false) {
          _hide();
        }
      });
    }
  }

  Future<void> _show() async {
    if (!_frontShown) {
      await _animateTo(targetAngle: _maxAngle);
    }
  }

  Future<void> _hide() async {
    if (_frontShown) {
      await _animateTo(targetAngle: _minAngle);
    }
  }

  Future<void> _animateTo({required double targetAngle}) async {
    _animation = Tween<double>(
      begin: _currentAngle,
      end: targetAngle,
    ).animate(_controller);

    await _controller.forward(from: 0.0);
  }

  void _setFrontShown() => _frontShown = _currentAngle > 90;
}
