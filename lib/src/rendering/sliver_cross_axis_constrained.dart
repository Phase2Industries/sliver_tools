import 'dart:math';

import 'package:flutter/rendering.dart';

import 'sliver_cross_axis_positioned.dart';

class RenderSliverCrossAxisConstrained extends RenderSliver
    with
        RenderObjectWithChildMixin<RenderSliver>,
        RenderSliverCrossAxisPositionedMixin {
  /// Max allowed limit of the cross axis
  double get maxCrossAxisExtent => _maxCrossAxisExtent!;
  double? _maxCrossAxisExtent;
  double get autoMargin => _autoMargin!;
  double? _autoMargin;

  set maxCrossAxisExtent(double value) {
    assert(value > 0);
    if (_maxCrossAxisExtent != value) {
      _maxCrossAxisExtent = value;
      markNeedsLayout();
    }
  }

  set autoMargin(double value) {
    assert(value >= 0);
    if (_autoMargin != value) {
      _autoMargin = value;
      markNeedsLayout();
    }
  }

  /// How to align the sliver in the cross axis
  /// 0 means center -1 means to the left +1 means to the right
  double get alignment => _alignment!;
  double? _alignment;
  set alignment(double value) {
    assert(value >= -1.0);
    assert(value <= 1.0);
    if (_alignment != value) {
      _alignment = value;
      markNeedsLayout();
    }
  }

  @override
  SliverCrossAxisPositionedData createCrossAxisPositionData(
    SliverConstraints constraints,
  ) {
    double margin = _autoMargin ?? 0;
    double crossAxisExtent = min(
      constraints.crossAxisExtent,
      maxCrossAxisExtent,
    );
    if (margin > 0) {
      final threshold = (maxCrossAxisExtent + (margin * 2));
      if (crossAxisExtent < threshold) {
        margin = (crossAxisExtent > maxCrossAxisExtent
            ? margin - ((crossAxisExtent - maxCrossAxisExtent) / 2)
            : margin);
      }
      crossAxisExtent = (crossAxisExtent < threshold)
          ? crossAxisExtent - (margin * 2)
          : crossAxisExtent;
    }
    return SliverCrossAxisPositionedData(
      crossAxisExtent: crossAxisExtent,
      crossAxisPosition: (alignment + 1) *
          ((constraints.crossAxisExtent - crossAxisExtent) / 2),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<double>('maxCrossAxisExtent', maxCrossAxisExtent));
  }
}
