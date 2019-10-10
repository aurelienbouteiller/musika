class Artiste {
  final id;
  final name;
  final link;

  const Artiste(this.id, this.name, this.link);

  String toString() {
    return '$id, $name, $link';
  }
}
