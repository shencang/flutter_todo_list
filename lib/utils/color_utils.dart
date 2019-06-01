import 'package:flutter/material.dart';

var priorityColor = [Colors.red, Colors.orange, Colors.yellow, Colors.white];

class ColorPalette {
  final String colorName;
  final int colorValue;

  ColorPalette(this.colorName, this.colorValue);
}

var colorsPalettes = <ColorPalette>[
  ColorPalette("红", Colors.red.value),
  ColorPalette("粉", Colors.pink.value),
  ColorPalette("紫", Colors.purple.value),
  ColorPalette("深紫", Colors.deepPurple.value),
  ColorPalette("靛青", Colors.indigo.value),
  ColorPalette("蓝", Colors.blue.value),
  ColorPalette("浅蓝", Colors.lightBlue.value),
  ColorPalette("青", Colors.cyan.value),
  ColorPalette("蓝绿", Colors.teal.value),
  ColorPalette("绿", Colors.green.value),
  ColorPalette("浅绿", Colors.lightGreen.value),
  ColorPalette("柠檬", Colors.lime.value),
  ColorPalette("黄", Colors.yellow.value),
  ColorPalette("琥珀", Colors.amber.value),
  ColorPalette("橙", Colors.orange.value),
  ColorPalette("深橙", Colors.deepOrange.value),
  ColorPalette("棕", Colors.brown.value),
  ColorPalette("黑", Colors.black.value),
  ColorPalette("灰", Colors.grey.value),
];
