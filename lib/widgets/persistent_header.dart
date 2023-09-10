import 'package:flutter/material.dart';
import 'package:inkflowai/widgets/custom_carousel.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final BuildContext ctx;

  PersistentHeader({
    required this.ctx,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: [
        const Expanded(
          child: CustomCarousel(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Explore",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(fontWeightDelta: 3),
            ),
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
