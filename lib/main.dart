import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_movie_app/src/presentation/screens/export_screens.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}
