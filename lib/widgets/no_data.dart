import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  const NoData(
      {super.key, this.title, this.imageUrl = "assets/images/empty.png"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imageUrl!,
            width: 150.0,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            title!,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
