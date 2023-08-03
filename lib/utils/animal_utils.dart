String animalPath = "assets/images/animals/";

class Animal {
  static List<Map<String, dynamic>> animals = [
    {
      'id': 1,
      'image': "${animalPath}deer.png",
      'name': "deer",
      'chance': 3,
    },
    {
      'id': 2,
      'image': "${animalPath}elephant.png",
      'name': "elephant",
      'chance': 3,
    },
    {
      'id': 3,
      'image': "${animalPath}lion.png",
      'name': "lion",
      'chance': 3,
    },
    {
      'id': 4,
      'image': "${animalPath}rabbit.png",
      'name': "rabbit",
      'chance': 3,
    },
    {
      'id': 5,
      'image': "${animalPath}rhino.png",
      'name': "rhino",
      'chance': 3,
    },
  ];
}
