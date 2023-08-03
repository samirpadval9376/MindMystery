import 'package:drag_drop/controllers/guess_controller.dart';
import 'package:drag_drop/utils/animal_utils.dart';
import 'package:drag_drop/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Guess Game",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Consumer<GuessController>(builder: (context, provider, child) {
            int i = provider.i;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      Animal.animals[i]['name'].length,
                      (index) => DragTarget(
                        builder: (context, _, __) {
                          return Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.all(5),
                            color: Colors.grey,
                            child: provider.animalName[index] != null
                                ? Image.asset(
                                    "assets/images/pieces/${Animal.animals[index]['name'].toLowerCase()}.png")
                                : null,
                          );
                        },
                        onWillAccept: (data) {
                          return data == Animal.animals[i]['name'];
                        },
                        onAccept: (data) {
                          provider.onAccepts(index: index);
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: imagePath
                          .map(
                            (e) => LongPressDraggable(
                              data: Animal.animals[i]['name'] ==
                                      String.fromCharCode(
                                          imagePath.indexOf(e) + 97)
                                  ? provider.changeName(index: e)(provider
                                              .nameIndex <
                                          Animal.animals[i]['name'].length - 1)
                                      ? provider.nameIndex++
                                      : provider.isDone = true
                                  : provider.chance -= 1,
                              feedback: Container(
                                height: 80,
                                width: 80,
                                margin: const EdgeInsets.all(10),
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Image.asset(e),
                                ),
                              ),
                              childWhenDragging: Container(
                                height: 60,
                                width: 60,
                                margin: const EdgeInsets.all(10),
                                color: Colors.grey,
                              ),
                              child: Image.asset(e),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
    ;
  }
}
