import 'package:flutter/material.dart';

// Text Styles

// To make it clear which weight we are using, we'll define the weight even for regular
// fonts
const TextStyle heading1Style = TextStyle(
  fontSize: 34,
  fontWeight: FontWeight.w400,
);

const TextStyle heading2Style = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w600,
);

var shadow = Shadow(
  color: Colors.black.withOpacity(0.16),
  offset: Offset(0, 3.0),
  blurRadius: 6.0,
);

var boxShadow = BoxShadow(
  color: Colors.black.withOpacity(0.16),
  offset: Offset(0, 3.0),
  blurRadius: 6.0,
);


// const TextStyle heading3Style = TextStyle(
//   fontSize: 24,
//   fontWeight: FontWeight.w600,
// );

const TextStyle headlineStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w700,
);

const TextStyle heading3Style = TextStyle(
  fontFamily: 'regu',
  fontSize: 24.0,
  color: Colors.black,
  fontWeight: FontWeight.w700,
);

TextStyle titleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w400,
  fontFamily: 'regu',
  color: Colors.white,
  height: 1.0,
  shadows: [shadow],
);

TextStyle bodyStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w400,
  fontFamily: 'regu',
  color: Colors.white,
  height: 1.0,
  shadows: [shadow],

);

TextStyle buttonStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w700,
);

TextStyle cardStyle = TextStyle(
  fontFamily: 'Calibri',
  fontSize: 14.0,
  color: Colors.black,
  height: 1.0,
  shadows: [shadow],
);

const TextStyle subheadingStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400,
);

const TextStyle captionStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
);
