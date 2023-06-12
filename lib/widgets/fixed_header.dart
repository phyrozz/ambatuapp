import 'package:flutter/material.dart';

class FixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final String text;

  FixedHeaderDelegate({required this.child, required this.text});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double fontSize = Tween<double>(begin: 28.0, end: 18.0)
        .transform(shrinkOffset / maxExtent); // Font size transition
    final Alignment alignment = AlignmentTween(
      begin: Alignment.center,
      end: Alignment(-0.95, 0),
    ).transform(shrinkOffset / maxExtent); // Alignment transition

    return Container(
      alignment: alignment,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100.0; // Adjust the height of the fixed header

  @override
  double get minExtent => 65.0; // Adjust the height of the fixed header

  @override
  bool shouldRebuild(FixedHeaderDelegate oldDelegate) {
    return false;
  }
}
