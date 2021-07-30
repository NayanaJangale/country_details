import 'package:demoproject/models/currencies.dart';
import 'package:demoproject/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListItem extends StatefulWidget {
  final String countryName;
  final String capitalName;
  final String population;
  List<Currencies> currencies;
  final Function onItemTap;

  CustomListItem(
      {this.countryName,
        this.capitalName,
        this.population,
        this.currencies,
        this.onItemTap});

  @override
  _CustomListItemState createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onItemTap,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey[400],
                          ),
                        ),
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: Image.network('https://picsum.photos/250?image=9',
                          fit: BoxFit.cover,
                          width: 35,
                          height: 35,)
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 30.0,
                    width: 1.0,
                    color: Colors.grey.withOpacity(0.5),
                    margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                  ),
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              widget.countryName.trimLeft(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                              ),
                              textAlign:TextAlign.start
                          ),

                          Text(
                              "Capital Name"+" - " + widget.capitalName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                              ),
                              textAlign:TextAlign.start
                          ),
                          Row(
                            children: [
                              Text(
                                  "Currency - ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                  ),
                                  textAlign:TextAlign.start
                              ),
                              Expanded(
                                child: Wrap(
                                  children: List.generate(
                                      widget.currencies
                                          .length, (curnIndex) {
                                    return Text(
                                        widget.currencies[curnIndex]
                                            .name+
                                            ",",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                          // color: AppTheme.grey
                                        ),
                                        textAlign:TextAlign.start
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                          /*Text(
                             "Currency"+" - " +widget.currencies[i],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                 // color: AppTheme.grey
                              ),
                              textAlign:TextAlign.start
                          ),*/
                          Text(
                              "Population" +" - "+ widget.population,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                // color: AppTheme.grey
                              ),
                              textAlign:TextAlign.start
                          ),
                        ],)
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: Colors.grey,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
