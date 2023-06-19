import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomCharacterHeader extends SliverPersistentHeaderDelegate {
  final String bgUrl;
  final String text;

  CustomCharacterHeader({required this.bgUrl, required this.text});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double opacity = shrinkOffset / maxExtent;
    final double fontSize =
        Tween<double>(begin: 32, end: 26).transform(opacity);
    final Alignment alignment = AlignmentTween(
      begin: Alignment.bottomCenter,
      end: Alignment.bottomLeft,
    ).transform(shrinkOffset / maxExtent); // Alignment transition

    return Stack(
      fit: StackFit.expand,
      children: [
        FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          placeholderFit: BoxFit.none,
          image: AssetImage(bgUrl),
          fit: BoxFit.cover,
        ),
        Opacity(
          opacity: 1.0 - opacity, // Reverse the opacity
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.25),
                  Theme.of(context).primaryColor,
                ],
                stops: [0.5, 1.0],
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: opacity,
          duration: Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.65)),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 25),
          alignment: alignment,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 250.0;

  @override
  double get minExtent => 80.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
