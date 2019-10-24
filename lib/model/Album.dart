class Album {
  int id;
  String title;
  String link;
  String cover;
  String coverSmall;
  String coverMedium;
  String coverBig;
  String coverXl;
  String releaseDate;
  String tracklist;
  String type;

  Album(
      {this.id,
      this.title,
      this.link,
      this.cover,
      this.coverSmall,
      this.coverMedium,
      this.coverBig,
      this.coverXl,
      this.releaseDate,
      this.tracklist,
      this.type});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    link = json['link'];
    cover = json['cover'];
    coverSmall = json['cover_small'];
    coverMedium = json['cover_medium'];
    coverBig = json['cover_big'];
    coverXl = json['cover_xl'];
    releaseDate = json['release_date'];
    tracklist = json['tracklist'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['link'] = this.link;
    data['cover'] = this.cover;
    data['cover_small'] = this.coverSmall;
    data['cover_medium'] = this.coverMedium;
    data['cover_big'] = this.coverBig;
    data['cover_xl'] = this.coverXl;
    data['release_date'] = this.releaseDate;
    data['tracklist'] = this.tracklist;
    data['type'] = this.type;
    return data;
  }
}
