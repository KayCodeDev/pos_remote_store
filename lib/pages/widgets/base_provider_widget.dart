import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BaseProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child)? builder;
  final T? model;
  final Widget? child;
  final Function(T)? onModelReady;

  const BaseProviderWidget({
    super.key,
    @required this.builder,
    this.model,
    this.child,
    this.onModelReady,
  });

  @override
  BaseWidgetState<T> createState() => BaseWidgetState<T>();
}

class BaseWidgetState<T extends ChangeNotifier>
    extends State<BaseProviderWidget<T>> {
  T? model;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady!(model!);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
          create: (context) => model!,
          child: Consumer<T>(
            builder: widget.builder!,
            child: widget.child,
          ),
        );
  }
}
