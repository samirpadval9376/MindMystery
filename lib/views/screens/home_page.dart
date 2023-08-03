import 'package:drag_drop/utils/image_utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "red";
  List accepted = [];

  @override
  void initState() {
    super.initState();
    accepted = List.generate(
      name.length,
      (index) => false,
    );
  }

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    name.length,
                    (index) => DragTarget(
                      builder: (context, _, __) {
                        return Container(
                          height: 80,
                          width: 80,
                          margin: const EdgeInsets.all(5),
                          color: Colors.grey,
                          child: accepted[index]
                              ? Image.asset(
                                  "assets/images/${name[index].toLowerCase()}.png")
                              : null,
                        );
                      },
                      onWillAccept: (data) {
                        return data == name[index];
                      },
                      onAccept: (data) {
                        setState(() {
                          accepted[index] = true;
                        });
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
                            data: String.fromCharCode(
                              imagePath.indexOf(e) + 97,
                            ),
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
          ),
        ),
      ),
    );
  }
}
