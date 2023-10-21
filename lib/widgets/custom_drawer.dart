import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inkflowai/models/drawer_item.dart';
import 'package:inkflowai/routes.dart';

class CustomDrawer extends StatelessWidget {
  final User user;
  const CustomDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage:
                      const AssetImage("assets/images/profile.png"),
                  backgroundColor: Colors.grey.shade100,
                  radius: 30.0,
                  foregroundImage: user.photoURL == null
                      ? null
                      : NetworkImage(user.photoURL!),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                user.displayName == null
                    ? const SizedBox()
                    : Text(
                        user.displayName!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                user.email == null
                    ? const SizedBox()
                    : Text(
                        user.email!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(drawerItems.length, (index) {
              DrawerItem item = drawerItems[index];

              return ListTile(
                onTap: () => onButtonTapped(context, item.drawerID!, ""),
                leading: Icon(
                  item.iconData,
                  color: Colors.grey,
                ),
                title: Text(item.title!),
              );
            }),
          )
        ],
      ),
    );
  }
}
