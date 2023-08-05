import 'package:drag_drop/controllers/animal_controller.dart';
import 'package:drag_drop/utils/animal_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalPage extends StatefulWidget {
  const AnimalPage({super.key});

  @override
  State<AnimalPage> createState() => _AnimalPage();
}

class _AnimalPage extends State<AnimalPage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Guess Animals",
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
        padding: const EdgeInsets.all(10),
        child: Center(
          child:
              Consumer<AnimalController>(builder: (context, provider, child) {
            int i = provider.i;

            print("=====================================");
            print("Index: $i");
            print("=====================================");

            return (provider.chance > 0)
                ? Column(
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
                          Text(
                            "Score :- ${provider.score}",
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
                      SizedBox(
                        height: s.height * 0.04,
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
                                      print("=============================");
                                      print(
                                          "IN :- $index & Length :- ${Animal.animals[i]['name'].length - 1}");
                                      print("=============================");
                                    } else {
                                      // print("=============================");
                                      // print("${provider.isDone}");
                                      // print("=============================");
                                      provider.isDone = true;

                                      print("=============================");
                                      print("${provider.isDone}");
                                      print("=============================");
                                    }
                                  });
                                } else {
                                  setState(() {
                                    if (provider.accepted[index] == false) {
                                      provider.chance--;
                                    }
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
                      SizedBox(
                        height: s.height * 0.05,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      SizedBox(
                        height: s.height * 0.02,
                      ),
                      Visibility(
                        visible:
                            provider.accepted.every((element) => (element)),
                        child: SizedBox(
                          height: 60,
                          width: 200,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.amber,
                              ),
                            ),
                            onPressed: () {
                              if (provider.isDone) {
                                print("++++++++++++++++++++++++++++");
                                print("${provider.isDone}");
                                print("+++++++++++++++++++++++++++++");
                                setState(() {
                                  provider.isDone = false;
                                  provider.init();
                                  provider.score += 10;
                                });
                              }
                            },
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                          provider.reload();
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
