import 'package:flutter/material.dart';

class CustomSliverHeader extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;
  CustomSliverHeader({this.child, this.maxHeight, this.minHeight});
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return maxHeight != oldDelegate.maxExtent ||
        minHeight != oldDelegate.minExtent;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }
}
