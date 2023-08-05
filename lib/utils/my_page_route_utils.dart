class BuildOptions {
  final String name;
  final String route;

  BuildOptions({
    required this.name,
    required this.route,
  });
}

class MyPageRoute {
  static String home = '/';
  static String animalPage = 'animal_page';

  static List<BuildOptions> buildOptions = [
    BuildOptions(
      name: "Animals",
      route: "animal_page",
    ),
    BuildOptions(
      name: "Fruits",
      route: "fruit_page",
    ),
  ];
}
