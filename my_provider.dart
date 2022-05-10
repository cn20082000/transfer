import 'package:flutter/material.dart';

class MyProvider<T> extends InheritedWidget {
  late T _data;
  final List<Function()> notifiers = [];

  MyProvider({
    Key? key,
    required Widget child,
    required T data
  }) : super(key: key, child: child) {
    _data = data;
  }

  static MyProvider<R> of<R>(BuildContext context) {
    final MyProvider<R>? result =
        context.dependOnInheritedWidgetOfExactType<MyProvider<R>>();
    assert(result != null, 'No MyProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(MyProvider old) {
    return true;
  }

  void update(T Function(T data) block) {
    _data = block(_data);
    notifiers.forEach((e) => e());
  }

  void registerNotifier(Function()? notifier) {
    if (notifier != null) {
      notifiers.add(notifier);
    }
  }

  void unregisterNotifier(Function()? notifier) {
    if (notifier != null) {
      notifiers.remove(notifier);
    }
  }
}

class MyConsumer<T> extends StatefulWidget {
  final Widget Function() child;
  const MyConsumer({Key? key, required this.child}) : super(key: key);

  @override
  State<MyConsumer<T>> createState() => _MyConsumerState<T>();
}

class _MyConsumerState<T> extends State<MyConsumer<T>> implements CanAccessData<T> {

  late MyProvider<T> _provider;
  Function()? setStateFunc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _provider = MyProvider.of<T>(context);
    setStateFunc = () {
      setState(() {});
    };

    _provider.registerNotifier(setStateFunc);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _provider.unregisterNotifier(setStateFunc);
  }

  @override
  T data() {
    return _provider._data;
  }

  @override
  void update(T Function(T data) block) {
    _provider.update((data) => block(data));
  }
}

abstract class ProviderWidget<T> extends StatelessWidget implements CanAccessData<T> {
  late MyProvider<T> _provider;

  ProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyProvider<T>(
      data: initData(),
      child: Builder(
        builder: (ctx) {
          _provider = MyProvider.of<T>(ctx);
          return builder(ctx);
        }
      )
    );
  }

  @protected
  Widget builder(BuildContext context);

  @protected
  T initData();

  @override
  T data() => _provider._data;

  @override
  void update(T Function(T data) block) {
    _provider.update((data) => block(data));
  }
}

abstract class CanAccessData<T> {
  T data();
  void update(T Function(T data) block);
}

