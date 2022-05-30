class Kek {
  bool isKek;
  String name;

  Kek({this.isKek = false, required this.name});
}

void main() {
  Kek kek = Kek(isKek: true, name: 'kek');
  Kek datBoi = Kek(name: 'dat boi');

  var keks = [kek, datBoi];

  print(keks);
}
