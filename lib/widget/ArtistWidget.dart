import 'package:flutter/material.dart';

class ArtistWidget extends StatefulWidget {
  const ArtistWidget({Key key, this.artistName, this.imageUrl})
      : super(key: key);

  final String artistName;
  final String imageUrl;

  @override
  _ArtistWidgetState createState() => _ArtistWidgetState();
}

class _ArtistWidgetState extends State<ArtistWidget> {
  double containerWidth = 100;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onHorizontalDragUpdate: (detail) {
            var x = detail.localPosition.dx;
            if (x > 100 && x < 250) {
              setState(() {
                containerWidth = x;
              });
            }
          },
          onHorizontalDragEnd: (detail) {
            setState(() {
              if (containerWidth > 245) {
                Future.delayed(
                    Duration(milliseconds: 200), () => Navigator.pop(context));
              }
              containerWidth = 100;
            });
          },
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40)),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              alignment: Alignment.topRight,
              width: containerWidth,
              height: 120,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xffBE5A38),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(widget.imageUrl),
                  ),
                  Text(
                    widget.artistName,
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
        ),
      ),
    );
  }
}
