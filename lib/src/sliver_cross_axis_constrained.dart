import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'rendering/sliver_cross_axis_constrained.dart';

/// Constrains and centers the [child] sliver to a maximum cross axis extent
/// specified by [maxCrossAxisExtent].
/// [alignment] specifies how to align the child where -1 is left +1 is right.
class SliverCrossAxisConstrained extends SingleChildRenderObjectWidget {
  const SliverCrossAxisConstrained({
    Key? key,
    required this.maxCrossAxisExtent,
    required Widget child,
    this.alignment = 0,
    this.autoMargin = 0,
  }) : super(key: key, child: child);

  /// Max allowed limit of the cross axis
  final double maxCrossAxisExtent;

  /// How to align the sliver in the cross axis
  /// 0 means center -1 means to the left +1 means to the right
  final double alignment;

  /// Allow for a margin to be added when less than the maxCrossAxisExtent
  /// This is useful when you want to center the sliver but also want to
  /// add a margin to the left and right of the sliver when minimized
  final double autoMargin;

  @override
  RenderSliverCrossAxisConstrained createRenderObject(BuildContext context) {
    final renderObject = RenderSliverCrossAxisConstrained();
    updateRenderObject(context, renderObject);
    return renderObject;
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSliverCrossAxisConstrained renderObject) {
    renderObject
      ..maxCrossAxisExtent = maxCrossAxisExtent
      ..alignment = alignment
      ..autoMargin = autoMargin;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<double>('maxCrossAxisExtent', maxCrossAxisExtent));
  }
}
