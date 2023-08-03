import 'dart:math';

import 'package:drag_drop/utils/animal_utils.dart';
import 'package:flutter/cupertino.dart';

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
    animalName[nameIndex] = String.fromCharCode(index + 97);
    print("==============================");
    print("${animalName[nameIndex]}");
    print("==============================");
    notifyListeners();
  }

  onAccepts({required int index}) {
    accepted[index] = true;
    notifyListeners();
  }
}
