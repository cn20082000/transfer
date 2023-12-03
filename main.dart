import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.bottomLeft,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              HeroDialogRoute(builder: (ctx) => const Center(
                child: AlertDialog(
                  title: Text("Some thing"),
                  content:SizedBox(
                  width: 500,
                  child: Wrap(
                    children: [
                      Hero(
                        tag: "preview1",
                        child: Icon(
                          Icons.ac_unit,
                          size: 240,
                        ),
                      ),
                      Hero(
                        tag: "preview2",
                        child: Icon(
                          Icons.access_alarms_sharp,
                          size: 240,
                        ),
                      ),
                      Hero(
                        tag: "preview3",
                        child: Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 240,
                        ),
                      ),
                      Hero(
                        tag: "preview4",
                        child: Icon(
                          Icons.ballot,
                          size: 240,
                        ),
                      ),
                      Hero(
                        tag: "preview5",
                        child: Icon(
                          Icons.yard,
                          size: 240,
                        ),
                      ),
                    ],
                  ),
                ),
                ),
              ))
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              width: 100,
              child: Wrap(
                children: [
                  Hero(
                    tag: "preview1",
                    child: Icon(
                      Icons.ac_unit,
                      size: 24,
                    ),
                  ),
                  Hero(
                    tag: "preview2",
                    child: Icon(
                      Icons.access_alarms_sharp,
                      size: 24,
                    ),
                  ),
                  Hero(
                    tag: "preview3",
                    child: Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 24,
                    ),
                  ),
                  Hero(
                    tag: "preview4",
                    child: Icon(
                      Icons.ballot,
                      size: 24,
                    ),
                  ),
                  Hero(
                    tag: "preview5",
                    child: Icon(
                      Icons.yard,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({ required this.builder }) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
        opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut
        ),
        child: child
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  String? get barrierLabel => "";

}
