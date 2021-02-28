import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseChangeNotifierProvider<T extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;

  BaseChangeNotifierProvider(
      {Key key, this.builder, this.model, this.child, this.onModelReady})
      : super(key: key);

  @override
  _BaseChangeNotifierProviderState<T> createState() =>
      _BaseChangeNotifierProviderState<T>();
}

class _BaseChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<BaseChangeNotifierProvider<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      builder: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
