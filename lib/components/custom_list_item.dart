import 'package:demoproject/models/currencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomListItem extends StatefulWidget {
  final String countryName;
  final String capitalName;
  final String population;
  List<Currencies> currencies;
  final String networkPath;
  final Function onItemTap;

  CustomListItem(
      {this.countryName,
      this.capitalName,
      this.population,
      this.currencies,
      this.networkPath,
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
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey[400],
                          ),
                        ),
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: SvgPicture.network(
                          widget.networkPath.toString(),
                          placeholderBuilder: (context) => CircularProgressIndicator(),
                           fit: BoxFit.cover,

                        )
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
                          Table(
                            columnWidths: {
                              0: FractionColumnWidth(.4),
                            },
                            children: [
                              TableRow(
                                children: [
                                  Container(),
                                  Container(),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 3.0,
                                    ),
                                    child: Text(
                                      "Capital Name",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 3.0,
                                    ),
                                    child: Text(
                                      widget.capitalName,
                                      style: Theme.of(context).textTheme.caption.copyWith(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 3.0,
                                    ),
                                    child:Text(
                                      "Currency",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 3.0,
                                    ),
                                    child: Wrap(
                                      children: List.generate(
                                          widget.currencies
                                              .length, (curnIndex) {
                                        return Text(
                                            widget.currencies[curnIndex]
                                                .name+
                                                (widget.currencies.length-1 != curnIndex? ",":""),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                             // color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign:TextAlign.start
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 3.0,
                                    ),
                                    child: Text(
                                      "Population",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 3.0,
                                    ),
                                    child: Text(
                                      this.widget.population,
                                      style: Theme.of(context).textTheme.caption.copyWith(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],)
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
      )
    );
  }
}
