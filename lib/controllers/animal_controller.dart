import 'dart:math';

import 'package:drag_drop/utils/animal_utils.dart';
import 'package:drag_drop/utils/fruit_utils.dart';
import 'package:flutter/cupertino.dart';

import '../utils/image_utils.dart';

class AnimalController extends ChangeNotifier {
  Random random = Random();
  int score = 0;
  int nameIndex = 0;
  late int i;
  int chance = 0;
  List accepted = [];
  bool isDone = false;

  AnimalController() {
    init();
  }

  init() {
    i = random.nextInt(Animal.animals.length);
    chance = Animal.animals[i]['chance'];

    accepted = List.generate(
      Animal.animals[i]['name'].length,
      (index) => false,
    );

    print("=============================");
    print("${Animal.animals[i]['name']}");
    print("=============================");
    nameIndex = 0;
  }

  reload() {
    init();
    isDone = false;
    if (score >= 5) {
      score -= 5;
    } else {
      score = 0;
    }
    notifyListeners();
  }

  changeName({required int index}) {
    if (Animal.animals[i]['name'][index] == String.fromCharCode(index + 97)) {
      String.fromCharCode(index + 97);
      if (index < Animal.animals[i]['name'].length - 1) {
        index++;
      } else {
        isDone = true;
      }
    } else {
      chance -= 1;
    }
    print("==========================");
    print(nameIndex);
    print("==========================");
    notifyListeners();
  }

  onAccepts({required int index}) {
    accepted[index] = true;
    notifyListeners();
  }
}
