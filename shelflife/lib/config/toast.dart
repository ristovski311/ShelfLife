import 'package:flutter/material.dart';
import 'package:shelflife/main.dart';

enum ToastType { success, failure, error, info }

class ToastService {
  static final ToastService instance = ToastService._internal();
  ToastService._internal();

  OverlayEntry? _currentEntry;

  void show(String message, {ToastType type = ToastType.info}) {
    final overlay = navigatorKey.currentState?.overlay;
    if (overlay == null) return;

    _currentEntry?.remove();
    _currentEntry = null;

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: ((context) => _ToastWidget(
        message: message,
        type: type,
        onDismissed: () {
          entry.remove();
          if (_currentEntry == entry) _currentEntry = null;
        },
      )),
    );

    _currentEntry = entry;
    overlay.insert(entry);
  }

  void success(String message) => show(message, type: ToastType.success);
  void failure(String message) => show(message, type: ToastType.failure);
  void error(String message) => show(message, type: ToastType.error);
  void info(String message) => show(message, type: ToastType.info);
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final VoidCallback onDismissed;

  const _ToastWidget({
    required this.message,
    required this.type,
    required this.onDismissed,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;
      await _controller.reverse();
      widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _backgroundColor() {
    switch (widget.type) {
      case ToastType.success:
        return Colors.green.shade600;
      case ToastType.info:
        return Colors.blue.shade600;
      case ToastType.failure:
        return Colors.red.shade600;
      case ToastType.error:
        return const Color.fromARGB(255, 100, 7, 5);
    }
  }

  IconData _icon() {
    switch (widget.type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.info:
        return Icons.info;
      case ToastType.failure:
        return Icons.error;
      case ToastType.error:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 96,
      left: 16,
      right: 16,
      child: FadeTransition(
        opacity: _controller,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
              .animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeOut),
              ),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                border: Border.all(width: 2, color: _backgroundColor()),
                color: Theme.of(context).colorScheme.surface,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_icon(), color: _backgroundColor(), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _backgroundColor(),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
