import 'dart:math';

import 'package:drag_drop/utils/fruit_utils.dart';
import 'package:flutter/material.dart';

class FruitController extends ChangeNotifier {
  int fruitIndex = 0;
  List acceptedFruit = [];
  int chanceFruit = 0;
  Random randomFruit = Random();
  bool isFruit = false;
  late int i;
  int scoreFruit = 0;

  FruitController() {
    init();
  }

  init() {
    i = randomFruit.nextInt(Fruit.fruits.length);
    chanceFruit = Fruit.fruits[i]['chance'];

    acceptedFruit =
        List.generate(Fruit.fruits[i]['name'].length, (index) => false);
    fruitIndex = 0;
  }

  reload() {
    init();
    isFruit = false;
    if (scoreFruit >= 5) {
      scoreFruit - 5;
    } else {
      scoreFruit = 0;
    }
    notifyListeners();
  }

  changeFruit({required int index, required Object? data}) {
    if (data == Fruit.fruits[i]['name'][index]) {
      acceptedFruit[index] = true;
      if (index < Fruit.fruits[i]['name'].length - 1) {
        fruitIndex++;
        index++;
      } else {
        isFruit = true;
      }
    } else {
      if (acceptedFruit[index] == false) {
        chanceFruit--;
      }
    }
    notifyListeners();
  }

  isDone() {
    isFruit = false;
    init();
    scoreFruit += 10;
    notifyListeners();
  }

  accept({required int index}) {
    acceptedFruit[index] = true;
    notifyListeners();
  }
}
