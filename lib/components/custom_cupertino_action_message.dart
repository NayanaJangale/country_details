import 'package:demoproject/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoActionMessage extends StatelessWidget {
  final String message;

  const CustomCupertinoActionMessage({this.message});
  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyText1.copyWith(
        letterSpacing: 1.2,
        fontWeight: FontWeight.w500,
        color: AppTheme.primary
      ),
    );
  }
}
