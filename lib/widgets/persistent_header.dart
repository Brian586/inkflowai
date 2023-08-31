import 'package:flutter/material.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final BuildContext ctx;

  PersistentHeader({
    required this.ctx,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SizedBox(
          height: size.height * 0.4,
          width: size.width,
        ),
        // Image.asset(
        //   "assets/images/main_background.png",
        //   height: size.height * 0.4,
        //   width: size.width,
        //   fit: BoxFit.contain,
        // ),
        const Positioned.fill(
          child: Center(
            child: Text(
              "Hello 👋",
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
        ),
        Positioned(
          bottom: 10.0,
          left: 20.0,
          child: Text(
            "Explore",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .apply(fontWeightDelta: 3),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => MediaQuery.of(ctx).size.height * 0.4;

  @override
  // TODO: implement minExtent
  double get minExtent => MediaQuery.of(ctx).size.height * 0.05;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
