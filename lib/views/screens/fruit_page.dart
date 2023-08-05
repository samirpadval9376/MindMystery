import 'package:drag_drop/controllers/animal_controller.dart';
import 'package:drag_drop/utils/fruit_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/fruit_controller.dart';

class FruitPage extends StatelessWidget {
  const FruitPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Guess Fruits",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Consumer<FruitController>(
            builder: (context, provider, child) {
              int i = provider.i;
              return (provider.chanceFruit > 0)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: List.generate(
                                provider.chanceFruit,
                                (index) => const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Text(
                              "Score :- ${provider.scoreFruit}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        SizedBox(
                          height: s.height * 0.4,
                          width: s.width,
                          child: Stack(
                            children: [
                              Image.asset(
                                "${Fruit.fruits[i]['image']}",
                                fit: BoxFit.fill,
                              ),
                              AnimatedOpacity(
                                  duration: const Duration(
                                    milliseconds: 200,
                                  ),
                                  opacity: (1 -
                                          (1 -
                                              (1 /
                                                  ((provider.fruitIndex == 0)
                                                      ? 1
                                                      : provider.fruitIndex))))
                                      .toDouble(),
                                  child: Image.asset(
                                    "${Fruit.fruits[i]['image']}",
                                    color: Colors.black,
                                    fit: BoxFit.fill,
                                  )),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              Fruit.fruits[i]['name'].length,
                              (index) => DragTarget(
                                builder: (context, _, __) {
                                  return Container(
                                    height: 60,
                                    width: 60,
                                    margin: const EdgeInsets.all(5),
                                    color: Colors.grey,
                                    child: provider.acceptedFruit[index]
                                        ? Image.asset(
                                            "assets/images/pieces/${Fruit.fruits[i]['name'][index].toLowerCase()}.png")
                                        : null,
                                  );
                                },
                                onWillAccept: (data) {
                                  provider.changeFruit(
                                      index: index, data: data);
                                  return data == Fruit.fruits[i]['name'][index];
                                },
                                onAccept: (data) {
                                  provider.accept(index: index);
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                26,
                                (index) => LongPressDraggable(
                                  data: String.fromCharCode(
                                    index + 97,
                                  ),
                                  feedback: Container(
                                    height: 80,
                                    width: 80,
                                    margin: const EdgeInsets.all(5),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Image.asset(
                                        "assets/images/pieces/${String.fromCharCode(index + 97)}.png",
                                      ),
                                    ),
                                  ),
                                  childWhenDragging: Container(
                                    height: 80,
                                    width: 80,
                                    margin: const EdgeInsets.all(5),
                                  ),
                                  child: Image.asset(
                                    "assets/images/pieces/${String.fromCharCode(index + 97)}.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Game Over !!",
                        ),
                        ElevatedButton(
                          onPressed: () {
                            provider.reload();
                          },
                          child: const Text("RESTART"),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
