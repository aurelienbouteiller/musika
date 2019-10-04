import 'package:flutter/material.dart';

class ArtistWidget extends StatelessWidget {
  const ArtistWidget({Key key, this.artistName, this.imageUrl})
      : super(key: key);

  final String artistName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
            ),
            Text(
              artistName,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
