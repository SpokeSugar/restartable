library restartable;

import 'package:flutter/widgets.dart';

class _RestartInheritedWidget extends InheritedWidget {
  const _RestartInheritedWidget(this._callback,
      {super.key, required super.child});

  final VoidCallback _callback;

  static _RestartInheritedWidget? of(BuildContext context) {
    return context
        .getElementForInheritedWidgetOfExactType<_RestartInheritedWidget>()
        ?.widget as _RestartInheritedWidget;
  }

  void reset() {
    _callback.call();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

class RestartWidget extends StatefulWidget {
  const RestartWidget(
      this.child, {
        Key? key,
      }) : super(key: key);
  final Widget child;

  static void reset(BuildContext context) {
    final widget = _RestartInheritedWidget.of(context);
    widget?.reset();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _RestartInheritedWidget(
      restartApp,
      key: key,
      child: widget.child,
    );
  }
}