// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<SingleChildWidget> appProviders(SharedPreferences sharedPreferences) {
  return [
    ...independentServices(sharedPreferences),
    ...dependentServices,
    ...uiConsumableProviders,
  ];
}

List<SingleChildWidget> independentServices(
    SharedPreferences sharedPreferences) {
  return [
    Provider.value(value: ApiProvider()),
    Provider.value(value: LocalStorageProvider(sharedPreferences)),
  ];
}

List<SingleChildWidget> dependentServices = [
  ProxyProvider2<ApiProvider, LocalStorageProvider, Repository>(
      update: (BuildContext context,
              ApiProvider apiProvider,
              LocalStorageProvider localStorageProvider,
              Repository? previousRepository) =>
          previousRepository == null
              ? Repository(apiProvider, localStorageProvider)
              : previousRepository),
  // ProxyProvider<Repository, AuthenticationService>(
  //   update: (BuildContext context, Repository repository,
  //           AuthenticationService? previous) =>
  //       previous == null ? AuthenticationService(repository) : previous,
  // )
];

List<SingleChildWidget> uiConsumableProviders = [];
