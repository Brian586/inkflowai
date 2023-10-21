import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Config {
  static const String appName = "InkFlow AI";
  static const String googleWebClientID =
      "260846165926-vpbunc8008ufc4fotl8ie1ou40iivmcd.apps.googleusercontent.com";

  // ===== ROBOFLOW ===== //
  static const String roboflowAPIKey = "UJNEhzlNoMK7w8jzXoHC";
  static const String workspace = "4cuskhaled";
  static const String model = "shapes-recognition";

  static TextStyle appNameTextStyle =
      GoogleFonts.caveat(fontWeight: FontWeight.bold);
}
