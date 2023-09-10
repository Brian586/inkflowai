import 'package:flutter/material.dart';

import '../models/activity.dart';

class CameraButton extends StatelessWidget {
  final String activityID;
  final void Function() onTap;
  const CameraButton(
      {super.key, required this.activityID, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Activity activity = activities
        .where((activity) => activity.activityID == activityID)
        .toList()
        .first;
    int red = activity.rgbColor![0];
    int green = activity.rgbColor![1];
    int blue = activity.rgbColor![2];

    Color color = Color.fromRGBO(red, green, blue, 1.0);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 8.0,
          color: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Turn Camera On",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Start your live camera now!",
                      style: TextStyle(color: Colors.white60),
                    )
                  ],
                )),
                Image.asset(
                  "assets/images/cam_person.png",
                  height: 250.0,
                  width: size.width * 0.4,
                  fit: BoxFit.contain,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
