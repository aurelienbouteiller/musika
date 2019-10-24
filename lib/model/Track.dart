import 'package:musika/model/Artist.dart';

import 'Album.dart';

class Track {
  int id;
  bool readable;
  String title;
  String titleShort;
  String titleVersion;
  String isrc;
  String link;
  String share;
  int duration;
  int trackPosition;
  int diskNumber;
  int rank;
  String releaseDate;
  bool explicitLyrics;
  int explicitContentLyrics;
  int explicitContentCover;
  String preview;
  double bpm;
  double gain;
  List<String> availableCountries;
  List<Artist> contributors;
  Artist artist;
  Album album;
  String type;

  Track(
      {this.id,
      this.readable,
      this.title,
      this.titleShort,
      this.titleVersion,
      this.isrc,
      this.link,
      this.share,
      this.duration,
      this.trackPosition,
      this.diskNumber,
      this.rank,
      this.releaseDate,
      this.explicitLyrics,
      this.explicitContentLyrics,
      this.explicitContentCover,
      this.preview,
      this.bpm,
      this.gain,
      this.availableCountries,
      this.contributors,
      this.artist,
      this.album,
      this.type});

  Track.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readable = json['readable'];
    title = json['title'];
    titleShort = json['title_short'];
    titleVersion = json['title_version'];
    isrc = json['isrc'];
    link = json['link'];
    share = json['share'];
    duration = json['duration'];
    trackPosition = json['track_position'];
    diskNumber = json['disk_number'];
    rank = json['rank'];
    releaseDate = json['release_date'];
    explicitLyrics = json['explicit_lyrics'];
    explicitContentLyrics = json['explicit_content_lyrics'];
    explicitContentCover = json['explicit_content_cover'];
    preview = json['preview'];
    bpm = json['bpm'];
    gain = json['gain'];
    if (json['available_countries'] != null) {
      availableCountries = new List<String>();
      json['available_countries'].forEach((v) {
        availableCountries.add(v);
      });
    }
    if (json['contributors'] != null) {
      contributors = new List<Artist>();
      json['contributors'].forEach((v) {
        contributors.add(new Artist.fromJson(v));
      });
    }
    artist =
        json['artist'] != null ? new Artist.fromJson(json['artist']) : null;
    album = json['album'] != null ? new Album.fromJson(json['album']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['readable'] = this.readable;
    data['title'] = this.title;
    data['title_short'] = this.titleShort;
    data['title_version'] = this.titleVersion;
    data['isrc'] = this.isrc;
    data['link'] = this.link;
    data['share'] = this.share;
    data['duration'] = this.duration;
    data['track_position'] = this.trackPosition;
    data['disk_number'] = this.diskNumber;
    data['rank'] = this.rank;
    data['release_date'] = this.releaseDate;
    data['explicit_lyrics'] = this.explicitLyrics;
    data['explicit_content_lyrics'] = this.explicitContentLyrics;
    data['explicit_content_cover'] = this.explicitContentCover;
    data['preview'] = this.preview;
    data['bpm'] = this.bpm;
    data['gain'] = this.gain;
    if (this.availableCountries != null) {
      data['available_countries'] = this.availableCountries.toList();
    }
    if (this.contributors != null) {
      data['contributors'] = this.contributors.toList();
    }
    if (this.artist != null) {
      data['artist'] = this.artist.toJson();
    }
    if (this.album != null) {
      data['album'] = this.album.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}
