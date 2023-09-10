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

void onButtonTapped(BuildContext context, String pageID, String activityID) {
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
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MosaicScreen(
                    activityID: activityID,
                  )));
      break;
    case "stroke":
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StrokeScreen(
                    activityID: activityID,
                  )));
      break;
    case "difference":
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DifferenceScreen(
                    activityID: activityID,
                  )));
      break;
    case "paint":
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaintScreen(
                    activityID: activityID,
                  )));
      break;
    case "pick":
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PickScreen(
                    activityID: activityID,
                  )));
      break;
    case "match":
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MatchScreen(
                    activityID: activityID,
                  )));
      break;
    case "find":
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FindScreen(
                    activityID: activityID,
                  )));
      break;
    case "characters":
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CharactersScreen(
                    activityID: activityID,
                  )));
      break;
  }
}
