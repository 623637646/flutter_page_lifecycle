Android's onResume/onPause and iOS's viewDidAppear/viewDidDisappear for Flutter.

Inspired by [visibility_detector](https://github.com/google/flutter.widgets/tree/master/packages/visibility_detector)


## Getting started

Add dependency

```yaml
dependencies:
  flutter_page_lifecycle: ^latest
```

## Usage

```dart
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLifecycle(
      stateChanged: (appear) {
        debugPrint("HomePage is ${appear ? "appeared" : "disappeared"}");
      },
      child: Scaffold(),
    );
  }
}
```
