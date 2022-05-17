import 'package:flutter/material.dart';

Widget sizedContainer(Widget child) {
  return Container(
    padding: const EdgeInsets.all(10),
    width: 350.0,
    height: 250.0,
    child: Center(child: child),
  );
}
