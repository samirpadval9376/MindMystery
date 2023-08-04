import 'dart:math';

import 'package:drag_drop/utils/animal_utils.dart';
import 'package:flutter/cupertino.dart';

import '../utils/image_utils.dart';

class GuessController extends ChangeNotifier {
  List animalName = [];
  Random random = Random();
  String name = "";
  int nameIndex = 0;
  late int i;
  int chance = 0;
  List accepted = [];
  bool isDone = false;

  GuessController() {
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

    animalName =
        List.generate(Animal.animals[i]['name'].length, (index) => null);
    nameIndex = 0;
  }

  changeName({required int index}) {
    if (Animal.animals[i]['name'][nameIndex] ==
        String.fromCharCode(index + 97)) {
      animalName[nameIndex] = String.fromCharCode(index + 97);
      if (nameIndex < Animal.animals[i]['name'].length - 1) {
        nameIndex++;
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
