import 'package:flutter/material.dart';

import 'pages/activities/char_screen.dart';
import 'pages/activities/difference_screen.dart';
import 'pages/activities/find_screen.dart';
import 'pages/activities/match_screen.dart';
import 'pages/activities/mosaic.dart';
import 'pages/activities/paint_screen.dart';
import 'pages/activities/pick_screen.dart';
import 'pages/activities/stroke_screen.dart';
import 'pages/profile_page.dart';
import 'pages/notifications_page.dart';
import 'pages/settings_page.dart';

void onButtonTapped(BuildContext context, String pageID) {
  switch (pageID) {
    case "profile":
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProfilePage()));
      break;
    case "notifications":
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NotificationsPage()));
      break;
    case "settings":
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SettingsPage()));
      break;
    //================ACTIVITIES=====================//
    case "mosaic":
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MosaicScreen()));
      break;
    case "stroke":
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const StrokeScreen()));
      break;
    case "difference":
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DifferenceScreen()));
      break;
    case "paint":
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PaintScreen()));
      break;
    case "pick":
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const PickScreen()));
      break;
    case "match":
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MatchScreen()));
      break;
    case "find":
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const FindScreen()));
      break;
    case "characters":
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CharactersScreen()));
      break;
  }
}
