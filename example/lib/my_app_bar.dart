import 'package:example/second_page.dart';
import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar({
    super.key,
    required String title,
    super.bottom,
  }) : super(
          title: Text(title),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          SecondPage(title: "$title > Second Page"),
                    ),
                  );
                },
                child: const Text(
                  "Next Page",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        );
}
