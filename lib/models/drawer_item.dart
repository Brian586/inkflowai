import 'package:flutter/material.dart';

class DrawerItem {
  final String? drawerID;
  final String? title;
  final IconData? iconData;

  DrawerItem({this.drawerID, this.title, this.iconData});
}

final List<DrawerItem> drawerItems = [
  DrawerItem(
    drawerID: "home",
    title: "Home",
    iconData: Icons.home_rounded,
  ),
  DrawerItem(
    drawerID: "notifications",
    title: "Notifications",
    iconData: Icons.notifications_active_rounded,
  ),
  DrawerItem(
    drawerID: "profile",
    title: "Profile",
    iconData: Icons.person_outline_rounded,
  ),
  DrawerItem(
    drawerID: "settings",
    title: "Settings",
    iconData: Icons.settings_rounded,
  ),
];
