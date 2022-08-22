import 'package:flutter/material.dart';
import 'package:flutter_page_lifecycle/flutter_page_lifecycle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLifecycle(
      stateChanged: (appear) {
        debugPrint("HomePage is ${appear ? "appeared" : "disappeared"}");
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SecondPage(),
                  ),
                );
              },
              child: const Text(
                "Next Page",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: ListView.separated(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('$index'),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: ListView.separated(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('$index'),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
