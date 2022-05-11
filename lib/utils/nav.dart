import 'package:flutter/material.dart';

toNextScreen(context, page) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => page),
  );
}
