import 'package:drag_drop/controllers/guess_controller.dart';
import 'package:drag_drop/utils/animal_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

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
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Consumer<GuessController>(builder: (context, provider, child) {
            int i = provider.i;

            print("=====================================");
            print("Index: $i");
            print("=====================================");

            return (provider.chance > 0)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List.generate(
                              provider.chance,
                              (index) => const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: s.height * 0.4,
                        width: s.width,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          // shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset(
                              Animal.animals[i]['image'],
                              fit: BoxFit.fill,
                            ),
                            AnimatedOpacity(
                              opacity: (1 -
                                      (1 -
                                          (1 /
                                              ((provider.nameIndex == 0)
                                                  ? 1
                                                  : provider.nameIndex))))
                                  .toDouble(),
                              duration: const Duration(
                                milliseconds: 200,
                              ),
                              child: Image.asset(
                                Animal.animals[i]['image'],
                                color: Colors.black,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            Animal.animals[i]['name'].length,
                            (index) => DragTarget(
                              builder: (context, _, __) {
                                return Container(
                                  height: 60,
                                  width: 60,
                                  margin: const EdgeInsets.all(5),
                                  color: Colors.grey,
                                  child: provider.accepted[index]
                                      ? Image.asset(
                                          "assets/images/pieces/${Animal.animals[i]['name'][index].toLowerCase()}.png")
                                      : null,
                                );
                              },
                              onWillAccept: (data) {
                                if (data == Animal.animals[i]['name'][index]) {
                                  setState(() {
                                    provider.accepted[index] = true;
                                    if (index <
                                        Animal.animals[i]['name'].length - 1) {
                                      provider.nameIndex++;
                                      index++;
                                    } else {
                                      provider.isDone = true;
                                    }
                                  });
                                } else {
                                  setState(() {
                                    provider.chance--;
                                  });
                                }

                                if (provider.isDone) {
                                  setState(() {
                                    Future.delayed(
                                        const Duration(microseconds: 500), () {
                                      provider.init();
                                    });
                                    provider.isDone = false;
                                  });
                                }

                                return (data ==
                                    Animal.animals[i]['name'][index]);
                              },
                              onAccept: (data) {
                                setState(() {
                                  provider.accepted[index] = true;
                                });
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
                          borderRadius: BorderRadius.circular(10),
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
                                  margin: const EdgeInsets.all(10),
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/images/pieces/${String.fromCharCode(index + 97)}.png",
                                    ),
                                  ),
                                ),
                                childWhenDragging: Container(
                                  height: 60,
                                  width: 60,
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.grey,
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
                      const Text("Game Over !!"),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            provider.init();
                            provider.isDone = false;
                          });
                        },
                        child: const Text("RESTART"),
                      ),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
