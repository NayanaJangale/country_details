import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoAction extends StatelessWidget {
  final String actionText;
  final int actionIndex;
  final Function onActionPressed;

  CustomCupertinoAction({
    this.actionText,
    this.actionIndex,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheetAction(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(''),
            width: 3.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment
                    .bottomRight, // 10% of the width, so there are ten blinds.
                colors: [
                  Colors.grey[300],
                  Colors.grey[400],
                  Colors.grey,
                ], // whitish to gray
                tileMode:
                TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              actionText,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(
              ),
            ),
          ),
          Icon(
            Icons.navigate_next,
            color: Colors.grey,
          ),
        ],
      ),
      onPressed: () {
        onActionPressed();
      },
    );
  }
}
