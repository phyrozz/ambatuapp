class Character {
  final String name;
  final String imagePath;

  Character({required this.name, required this.imagePath});
}

List<Character> characters = [
  Character(name: 'Dreamy', imagePath: 'assets/images/bird_1.png'),
  Character(name: 'Kakangku', imagePath: 'assets/images/bird_2.png'),
  Character(name: 'Nissan', imagePath: 'assets/images/bird_3.png'),
  Character(name: 'Bunda Rahma', imagePath: 'assets/images/bird_4.png'),
  // Add more characters as needed...
];
