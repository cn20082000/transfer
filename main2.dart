import 'package:flutter/material.dart';

void main() {
  runApp(CanRebuild(
    builder: () => MaterialApp(
      key: UniqueKey(),
      title: "Basic theme",
      home: HomePage(),
    ),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyle.theme().appBar(),
        title: const Text("Basic theme"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: AppStyle.theme().nextButton()
              ),
              child: const Text("Next"),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: AppStyle.theme().backButton()
              ),
              child: const Text("Back"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppStyle.changeMode(AppStyle.mode() == StyleMode.hot ? StyleMode.cold : StyleMode.hot);
          CanRebuild.hotRestart(context);
        },
        backgroundColor: AppStyle.theme().faButton(),
        child: const Icon(Icons.swap_horiz),
      ),
    );
  }
}

class CanRebuild extends StatefulWidget {
  final Widget Function() builder;
  const CanRebuild({Key? key, required this.builder}) : super(key: key);

  @override
  State<CanRebuild> createState() => _CanRebuildState();

  static hotRestart(BuildContext context) {
    final state = context.findAncestorStateOfType<_CanRebuildState>();
    state?.hotRestart();
  }
}

class _CanRebuildState extends State<CanRebuild> {

  @override
  Widget build(BuildContext context) {
    return widget.builder();
  }

  void hotRestart() {
    setState(() {});
  }
}


abstract class AppStyle {
  Color appBar();
  Color nextButton();
  Color backButton();
  Color faButton();

  static AppStyle _theme = HotStyle();
  static AppStyle theme() => _theme;
  static StyleMode _mode = StyleMode.hot;
  static StyleMode mode() => _mode;

  static void changeMode(StyleMode mode) {
    _mode = mode;
    switch (mode) {
      case StyleMode.hot: _theme = HotStyle(); break;
      case StyleMode.cold: _theme = ColdStyle(); break;
      default: break;
    }
  }
}

class HotStyle implements AppStyle {
  @override
  Color appBar() => Colors.brown;

  @override
  Color backButton() => Colors.orange;

  @override
  Color faButton() => Colors.orangeAccent;

  @override
  Color nextButton() => Colors.green;
}

class ColdStyle implements AppStyle {
  @override
  Color appBar() => Colors.blue;

  @override
  Color backButton() => Colors.blueGrey;

  @override
  Color faButton() => Colors.blueAccent;

  @override
  Color nextButton() => Colors.red;
}

enum StyleMode {
  hot,
  cold
}

