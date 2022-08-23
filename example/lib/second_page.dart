import 'package:flutter/material.dart';
import 'package:flutter_page_lifecycle/flutter_page_lifecycle.dart';

class SecondPage extends StatelessWidget {
  final String title;
  const SecondPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return PageLifecycle(
      stateChanged: (appeared) {
        debugPrint("[Page][${appeared ? "appeared" : "disappeared"}] $title");
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
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
