import 'package:flutter/material.dart';

class FixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final String text;

  FixedHeaderDelegate({required this.child, required this.text});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double fontSize = Tween<double>(begin: 28.0, end: 22.0)
        .transform(shrinkOffset / maxExtent); // Font size transition

    final bool isScrolled = shrinkOffset > 0; // Check if the user has scrolled

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: isScrolled
            ? Border(
                bottom: BorderSide(
                    width: 2.0, color: Theme.of(context).primaryColorLight))
            : null, // Add border when scrolled
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100.0; // Adjust the height of the fixed header

  @override
  double get minExtent => 60.0; // Adjust the height of the fixed header

  @override
  bool shouldRebuild(FixedHeaderDelegate oldDelegate) {
    return false;
  }
}
