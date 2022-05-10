import 'package:basic_flutter/my_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Basic Flutter",
    home: HomePage(),
  ));
}

class HomePage extends ProviderWidget<HomeData> {
  HomePage({Key? key}) : super(key: key);

  @override
  HomeData initData() => HomeData();

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic flutter"),
      ),
      body: Center(
        child: MyConsumer<HomeData>(
          child: () => Text("Value is ${data().count}"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          update((data) {
            data.count++;
            return data;
          });
        },
      ),
    );
  }
}

class HomeData {
  int count = 0;
}
