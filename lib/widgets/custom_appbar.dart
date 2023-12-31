import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inkflowai/pages/profile_page.dart';

import '../config.dart';

class CustomMainAppbar extends StatelessWidget {
  final GlobalKey<ScaffoldState>? globalKey;
  final User? user;
  const CustomMainAppbar({super.key, this.user, this.globalKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "InkFlow AI",
        style: Config.appNameTextStyle.copyWith(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Theme.of(context).primaryColor),
      ),
      actions: [
        InkWell(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfilePage())),
          child: CircleAvatar(
            backgroundImage: const AssetImage("assets/images/profile.png"),
            backgroundColor: Colors.grey.shade100,
            radius: 15.0,
            foregroundImage:
                user!.photoURL == null ? null : NetworkImage(user!.photoURL!),
          ),
        ),
        IconButton(
          onPressed: () => globalKey!.currentState!.openDrawer(),
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          width: 10.0,
        )
      ],
    );
  }
}

class CustomAppbar extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  const CustomAppbar({super.key, required this.title, required this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
    );
  }
}
