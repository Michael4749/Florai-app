import 'package:flutter/material.dart';

const color1 = Color.fromRGBO(0, 18, 11, 1);
const color2 = Color.fromRGBO(53, 96, 90, 1);
const color3 = Color.fromRGBO(107, 129, 140, 1);
const color4 = Color.fromRGBO(216, 228, 255, 1);
const color5 = Color.fromRGBO(49, 233, 129, 1);
const color6 = Color.fromRGBO(23, 28, 31, 1);
const color7 = Color.fromRGBO(54, 63, 67, 1);


const backgroundGradientColor1 = Color(0xFF29353b);
const backgroundGradientColor2 = Color(0xFF2E4547);
const backgroundGradientColor3 = Color(0xFF29353B);
const backgroundGradient = LinearGradient(
  colors: [
    backgroundGradientColor1,
    backgroundGradientColor2,
    backgroundGradientColor3
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const secondaryGradientColor1 = Color(0xFF24323B);
const secondaryGradientColor2 = Color(0xFF363F43);
const secondaryGradientColor3 = Color(0xFF171C1F);
const secondaryGradient = LinearGradient(colors: [
  secondaryGradientColor1,
  secondaryGradientColor2
], begin: Alignment.centerLeft, end: Alignment.centerRight);

const defaultBorder =
    RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)));

const defaultBorderRadius = BorderRadius.all(Radius.circular(15));

const defaultStroke = BorderSide(
    color: color4, strokeAlign: BorderSide.strokeAlignCenter, width: 3);

const defaultBoxShadow = [
  BoxShadow(
      color: Colors.black26,
      blurRadius: 10,
      spreadRadius: 0,
      offset: Offset(5, 2))
];

const headerStyle = TextStyle(
  fontFamily: 'Product Sans',
  fontWeight: FontWeight.bold,
  color: color4,
  fontSize: 62,
);
const creditStyle = TextStyle(
  fontFamily: 'Product Sans',
  color: color4,
  fontSize: 32,
);
const titleStyle = TextStyle(
  fontFamily: 'Product Sans',
  fontWeight: FontWeight.bold,
  height: 1,
  color: color4,
  fontSize: 42,
);
const regularStyle = TextStyle(
  fontFamily: 'Product Sans',
  height: 1,
  color: color4,
  fontSize: 32,
);

/*

00120B -> 0, 18, 11
35605A -> 53, 96, 90
6B818C -> 107, 129, 140
D8E4FF -> 216, 228, 255
31E981 -> 49, 233, 129
171C1F -> 23, 28, 31
363F43 -> 54, 63, 67

*/
