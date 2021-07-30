import 'package:demoproject/handlers/string_handlers.dart';
import 'currencies.dart';

class Countries {
  String name, capital, region,flag;
  int population;
  List<String> callingCodes;
  List<String> borders;
  List<Currencies> currencies;

  Countries({
    this.name,
    this.flag,
    this.capital,
    this.population,
    this.currencies,
  });

  Countries.fromMap(Map<String, dynamic> map) {
    name = map[CountriesFieldNames.name] ?? StringHandlers.NotAvailable;
    flag = map[CountriesFieldNames.flag] ?? StringHandlers.NotAvailable;
    capital = map[CountriesFieldNames.capital] ?? StringHandlers.NotAvailable;
    population =map[CountriesFieldNames.population] ?? 0;
    region = map[CountriesFieldNames.region] ?? StringHandlers.NotAvailable;

    var callingCodesData = map[CountriesFieldNames.callingCodes];
    callingCodes = List<String>.from(callingCodesData.map((i) => i))?? [];

    var bordersData = map[CountriesFieldNames.borders];
    borders = List<String>.from(bordersData.map((i) => i))?? [];

    var currenciesData = map[CountriesFieldNames.currencies];
    currencies = List<Currencies>.from(currenciesData.map((i) => Currencies.fromMap(i)))?? [];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        CountriesFieldNames.name: name,
        CountriesFieldNames.flag: flag,
        CountriesFieldNames.capital: capital,
        CountriesFieldNames.population: population,
        CountriesFieldNames.callingCodes: callingCodes,
        CountriesFieldNames.region: region,
        CountriesFieldNames.borders: borders,
        CountriesFieldNames.currencies: currencies,
      };
}

class CountriesFieldNames {
  static const String name = "name";
  static const String flag = "flag";
  static const String capital = "capital";
  static const String population = "population";
  static const String callingCodes = "callingCodes";
  static const String region = "region";
  static const String borders = "borders";
  static const String currencies = "currencies";
}
