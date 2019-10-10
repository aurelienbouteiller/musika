import 'package:http/http.dart' as http;

class Music {
  final id;
  final title;
  final preview;

  const Music(this.id, this.title, this.preview);

  String toString() {
    return '$id, $title, $preview';
  }
}
