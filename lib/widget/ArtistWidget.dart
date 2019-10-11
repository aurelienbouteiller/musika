import 'package:flutter/material.dart';

class ArtistWidget extends StatelessWidget {
  const ArtistWidget({Key key, this.artistName, this.imageUrl})
      : super(key: key);

  final String artistName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.only(topRight: Radius.circular(40), bottomRight: Radius.circular(40)),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Color(0xffBE5A38),
              borderRadius: BorderRadius.only(topRight: Radius.circular(40), bottomRight: Radius.circular(40),),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: Container(
                    height: 75,
                    width: 75,
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
                style: TextStyle(
                  color: Color(0xFFF7EDDC),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
