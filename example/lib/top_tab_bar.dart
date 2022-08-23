import 'package:example/keep_alive_widget.dart';
import 'package:example/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_lifecycle/flutter_page_lifecycle.dart';

class TopTabBar extends StatelessWidget {
  final String bottomTabTitle;

  const TopTabBar({super.key, required this.bottomTabTitle});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MyAppBar(
          title: bottomTabTitle,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Page 0",
              ),
              Tab(
                text: "Page 1",
              ),
              Tab(
                text: "Page 2",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            KeepAliveWidget(
              child: ListView.separated(
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
            const KeepAliveWidget(
              child: Icon(Icons.directions_transit),
            ),
            const KeepAliveWidget(
              child: Icon(Icons.directions_bike),
            ),
          ]
              .asMap()
              .map(
                (i, e) => MapEntry(
                  i,
                  PageLifecycle(
                      stateChanged: (appeared) {
                        debugPrint(
                            "[Page][${appeared ? "appeared" : "disappeared"}] $bottomTabTitle > Page $i Tab");
                      },
                      child: e),
                ),
              )
              .values
              .toList(),
        ),
      ),
    );
  }
}
