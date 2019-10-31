import 'Artist.dart';

class Levels {
  List<Level> levels = List();

  Levels({this.levels});

  Levels.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData.length > 0) {
      jsonData.forEach((levelId, levelArtistList) {
        List<Artist> artistList = List();
        levelArtistList.forEach((levelArtist) {
          Artist artistToAdd = Artist(
              id: int.parse(levelArtist['artistId']),
              name: levelArtist['name']);
          artistList.add(artistToAdd);
        });

        var level = new Level(id: int.parse(levelId), artistList: artistList);
        levels.add(level);
      });
    }
  }
}

class Level {
  int id;
  List<Artist> artistList;

  Level({this.id, this.artistList});
}
