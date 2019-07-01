import 'package:flutter/material.dart';

var priorityColor = [Colors.red, Colors.orange, Colors.yellow, Colors.white];

class ColorPalette {
  final String colorName;
  final int colorValue;

  ColorPalette(this.colorName, this.colorValue);
}

var colorsPalettes = <ColorPalette>[
  ColorPalette("红", Colors.red.value),//1
  ColorPalette("粉", Colors.pink.value),//2
  ColorPalette("紫", Colors.purple.value),//3
  ColorPalette("深紫", Colors.deepPurple.value),//4
  ColorPalette("靛青", Colors.indigo.value),//5
  ColorPalette("蓝", Colors.blue.value),//6
  ColorPalette("浅蓝", Colors.lightBlue.value),//7
  ColorPalette("青", Colors.cyan.value),//8
  ColorPalette("蓝绿", Colors.teal.value),//9
  ColorPalette("绿", Colors.green.value),//10
  ColorPalette("浅绿", Colors.lightGreen.value),//11
  ColorPalette("柠檬", Colors.lime.value),//12
  ColorPalette("黄", Colors.yellow.value),//13
  ColorPalette("琥珀", Colors.amber.value),//14
  ColorPalette("橙", Colors.orange.value),//15
  ColorPalette("深橙", Colors.deepOrange.value),//16
  ColorPalette("棕", Colors.brown.value),//17
  ColorPalette("黑", Colors.black.value),//18
  ColorPalette("灰", Colors.grey.value),//19
];
