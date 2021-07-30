import 'dart:convert';

import 'package:demoproject/components/custom_cupertino_action.dart';
import 'package:demoproject/components/custom_cupertino_action_message.dart';
import 'package:demoproject/components/custom_list_item.dart';
import 'package:demoproject/components/custom_progress_handler.dart';
import 'package:demoproject/components/flushbar_message.dart';
import 'package:demoproject/contants/http_status_codes.dart';
import 'package:demoproject/contants/internet_connection.dart';
import 'package:demoproject/contants/message_types.dart';
import 'package:demoproject/handlers/network_handler.dart';
import 'package:demoproject/models/countries.dart';
import 'package:demoproject/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'country_details_page.dart';

class AllCountiesPage extends StatefulWidget {
  @override
  _AllCountiesPageState createState() => _AllCountiesPageState();
}

class _AllCountiesPageState extends State<AllCountiesPage>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _countryPageGlobalKey;

  final ScrollController _scrollController = ScrollController();
  TextEditingController filterController;
  bool _isLoading;
  String _loadingText;
  AnimationController animationController;
  List<Countries> countriesList = [];
  List<Countries> filterCountriesList = [];
  List<String> _sortingList = [
    "Name (Ascending)",
    "Capital Name (Ascending)",
    "Currency (Ascending)",
    "Population (Descending)",
  ];

  @override
  void initState() {
    super.initState();
    filterController = new TextEditingController();
    filterController.addListener(() {
      setState(() {
        if(filterController.text!=""){
          filterCountriesList = countriesList
              .where((i) =>
          i.name
              .toLowerCase()
              .contains(filterController.text.toLowerCase()) ||
              i.capital
                  .toLowerCase()
                  .contains(filterController.text.toLowerCase()) ||
              i.population
                  .toString()
                  .contains(filterController.text.toString()))
              .toList();
        }else{
          filterCountriesList.addAll(countriesList);
        }

      });
    });
    _isLoading = true;
    _loadingText = 'Loading . . .';
    _countryPageGlobalKey = new GlobalKey<ScaffoldState>();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    GetCountriesDtlList();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomProgressHandler(
        isLoading: this._isLoading,
        loadingText: this._loadingText,
        child: Scaffold(
            key: _countryPageGlobalKey,
            backgroundColor: AppTheme.backgroundColor,
            appBar: AppBar(
              title: Text(
                "All Counties",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: NestedScrollView(
                    controller: _scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Container(
                              // color: Colors.grey[200],
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Column(
                                children: <Widget>[
                                  getFilterBarUI(),
                                ],
                              ),
                            );
                          }, childCount: 1),
                        ),
                      ];
                    },
                    body: Container(
                      child: ListView.builder(
                        itemCount: filterCountriesList.length,
                        padding: const EdgeInsets.only(top: 5),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final int count = filterCountriesList.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: animationController,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                          animationController.forward();
                          return AnimatedBuilder(
                            animation: animationController,
                            builder: (BuildContext context, Widget child) {
                              return FadeTransition(
                                opacity: animation,
                                child: Transform(
                                  transform: Matrix4.translationValues(
                                      0.0, 50 * (1.0 - animation.value), 0.0),
                                  child: CustomListItem(
                                    countryName:
                                        filterCountriesList[index].name,
                                    capitalName:
                                        filterCountriesList[index].capital,
                                    currencies:
                                        filterCountriesList[index].currencies,
                                    population: filterCountriesList[index]
                                        .population
                                        .toString(),
                                    networkPath: filterCountriesList[index]
                                        .flag
                                        .toString(),
                                    onItemTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                CountryDetailPage(countries: filterCountriesList[index])),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
  Widget getFilterBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 16, top: 8, bottom: 4),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: AppTheme.primary,
                      size: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        child: TextFormField(
                          controller: filterController,
                          decoration: InputDecoration.collapsed(
                              border: InputBorder.none,
                              hintText: "Search",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: AppTheme.primary,
                                  )),
                          style:
                              Theme.of(context).textTheme.bodyText1.copyWith(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(4.0),
                ),
                onTap: () {
                  showSortBy();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Sort',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.sort, color: AppTheme.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSortBy() async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        message: CustomCupertinoActionMessage(
          message: "Sort",
        ),
        actions: List<Widget>.generate(
          _sortingList.length,
          (i) => CustomCupertinoAction(
            actionText: _sortingList[i],
            actionIndex: i,
            onActionPressed: () {
              setState(() {
                filterCountries(_sortingList[i]);
              });
            },
          ),
        ),
      ),
    );
  }

  void filterCountries(String filter) {
    switch (filter) {
      case "Name (Ascending)":
        setState(() {
          filterCountriesList.clear();
          filterCountriesList.addAll(countriesList);
          filterCountriesList.sort((a, b) => a.name.compareTo(b.name));
        });
        Navigator.pop(context);
        break;
      case "Capital Name (Ascending)":
        setState(() {
          filterCountriesList.clear();
          filterCountriesList.addAll(countriesList);
          filterCountriesList.sort((a, b) => a.capital.compareTo(b.capital));
        });
        print(filterCountriesList.length.toString());
        Navigator.pop(context);
        break;
      case "Currency (Ascending)":
        setState(() {
          filterCountriesList.clear();
          filterCountriesList.addAll(countriesList);
          for (int i = 0; i < filterCountriesList.length; i++) {
            filterCountriesList[i]
                .currencies
                .sort((a, b) => a.name.compareTo(b.name));
          }
        });
        Navigator.pop(context);
        break;
      case "Population (Descending)":
        setState(() {
          filterCountriesList.clear();
          filterCountriesList.addAll(countriesList);
          filterCountriesList
              .sort((a, b) => b.population.compareTo(a.population));
        });
        print(filterCountriesList.length.toString());
        Navigator.pop(context);
        break;
    }
  }

  Future<void> GetCountriesDtlList() async {
    try {
      setState(() {
        _isLoading = true;
      });

      String connectionStatus = await NetworkHandler.checkInternetConnection();
      if (connectionStatus == InternetConnection.CONNECTED) {
        Uri uri = Uri.parse(
          "https://restcountries.eu/rest/v2/all",
        );

        Response response;
        response = await get(uri);

        if (response.statusCode != HttpStatusCodes.OK) {
          FlushbarMessage.show(
            context,
            "Country List Not Available",
            MessageTypes.WARNING,
          );
        } else {
          var data = json.decode(response.body);
          setState(() {
            countriesList =
                List<Countries>.from(data.map((i) => Countries.fromMap(i)));
            filterCountriesList.addAll(countriesList);
            filterCountriesList.sort((a, b) => a.name.compareTo(b.name));
          });
        }
      } else {
        FlushbarMessage.show(
          context,
          "Please check your wifi or mobile data is active.",
          MessageTypes.WARNING,
        );
      }
    } catch (e) {
      FlushbarMessage.show(
        context,
        e.toString(),
        MessageTypes.WARNING,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
