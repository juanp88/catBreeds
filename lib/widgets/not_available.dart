import 'package:flutter/material.dart';

import '../utils/constants.dart';

Widget notAvailable() {
  return Image.network(Constants.noDisponible,
      loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return const CircularProgressIndicator();
  });
}
