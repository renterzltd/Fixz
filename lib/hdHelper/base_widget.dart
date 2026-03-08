import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final T model;
  final Widget? child;
  final Function(T)? onModelReady;
  final Function(T)? onModelDestroy;

  BaseWidget(
      {required this.model,
      required this.builder,
      this.child,
      this.onModelReady,
      this.onModelDestroy})
      : super();

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  // We want to store the instance of the model in the state
  // that way it stays constant through rebuilds
  late T model;

  _BaseWidgetState();

  onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  void initState() {
    // assign the model once when state is initialised
    model = widget.model;
    /*ghedeer here */
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    /*ghadeer end*/
    super.initState();
  }

  @override
  void dispose() {
    if (widget.onModelDestroy != null) {
      widget.onModelDestroy!(model);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: widget.builder,
        // builder:  widget.builder,
        child: widget.child ?? Container(),
      ),
    );
  }
}
