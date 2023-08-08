import 'dart:math';

import 'package:drag_drop/utils/animal_utils.dart';
import 'package:flutter/cupertino.dart';

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
    nameIndex = 0;
  }

  isDoneAnimal() {
    isDone = false;
    init();
    score += 10;
    notifyListeners();
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

  changeAnimal({required int index, required Object? data}) {
    if (data == Animal.animals[i]['name'][index]) {
      accepted[index] = true;
      if (index < Animal.animals[i]['name'].length - 1) {
        nameIndex++;
        index++;
      } else {
        isDone = true;
      }
    } else {
      if (accepted[index] == false) {
        chance--;
      }
    }
    notifyListeners();
  }

  onAccept({required int index}) {
    accepted[index] = true;
    notifyListeners();
  }
}
