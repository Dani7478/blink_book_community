import 'package:flutter/material.dart';


TextWidget(String txt,double fSize, Color FColor)
{
  return Text(
    txt,
    style: TextStyle(
      fontSize: fSize,
      fontWeight: FontWeight.bold,
      color: FColor
    ),
  );
}