library flutter_page_lifecycle;

import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

typedef PageLifecycleStateChangedCallback = void Function(bool appear);

class PageLifecycle extends SingleChildRenderObjectWidget {
  final PageLifecycleStateChangedCallback stateChanged;

  const PageLifecycle({super.key, required this.stateChanged, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderPageLifecycle(
        route: ModalRoute.of(context), stateChanged: stateChanged);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    super.updateRenderObject(context, renderObject);
    (renderObject as _RenderPageLifecycle).route = ModalRoute.of(context);
  }
}

class _RenderPageLifecycle extends RenderProxyBox {
  final PageLifecycleStateChangedCallback stateChanged;
  ModalRoute? route;
  Timer? _debounce;
  bool _lastIsCurrent = false;

  _RenderPageLifecycle({this.route, required this.stateChanged});

  @override
  void paint(PaintingContext context, Offset offset) {
    context.pushLayer(
        _PageLifecycleLayer(update: _update), super.paint, offset);
  }

  void _update() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () {
      // Ensure that work is done between frames so that calculations are
      // performed from a consistent state.  We use `scheduleTask<T>` here instead
      // of `addPostFrameCallback` or `scheduleFrameCallback` so that work will
      // be done even if a new frame isn't scheduled and without unnecessarily
      // scheduling a new frame.
      SchedulerBinding.instance.scheduleTask<void>(() {
        final newValue = route?.isCurrent ?? false;
        if (_lastIsCurrent != newValue) {
          stateChanged(newValue);
          _lastIsCurrent = newValue;
        }
      }, Priority.touch);
    });
  }
}

class _PageLifecycleLayer extends ContainerLayer {
  final VoidCallback update;

  _PageLifecycleLayer({required this.update});

  @override
  void addToScene(dynamic builder, [Offset layerOffset = Offset.zero]) {
    super.addToScene(builder);
    update();
  }

  @override
  void attach(Object owner) {
    super.attach(owner);
    update();
  }

  @override
  void detach() {
    super.detach();
    update();
  }
}
