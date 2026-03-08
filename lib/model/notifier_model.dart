import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class NotifierModel extends ChangeNotifier {
  bool _busy = false;

  bool get busy => _busy;

  final showMessage = PublishSubject<String>();

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
