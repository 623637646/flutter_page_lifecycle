import 'package:flutter/widgets.dart';

class KeepAliveWidget extends StatefulWidget {
  final Widget child;
  const KeepAliveWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<KeepAliveWidget> createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
