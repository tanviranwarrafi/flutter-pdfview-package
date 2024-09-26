import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const DEFAULT_LOCALE = Locale('en', 'US');
const OVERLAY_STYLE = SystemUiOverlayStyle(
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.dark,
);

Future<void> portraitMode() => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
