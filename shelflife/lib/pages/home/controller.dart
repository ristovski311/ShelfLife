import 'package:flutter/material.dart';
import 'package:shelflife/classes/database/expiration_rep.dart';
import 'package:shelflife/classes/models/expiration.dart';

class HomeController extends ChangeNotifier {
  List<Expiration> soonToExpireProducts = [];
  final _expirationRepo = ExpirationRep();

  Future<void> setup() async {
    await _refresh();
    notifyListeners();
  }

  Future<void> _refresh() async {
    soonToExpireProducts = await _expirationRepo.getSoonExpiring(20);
    notifyListeners();
  }

  List<Expiration> getSoonToExpireProductsHome() {
    return soonToExpireProducts;
  }
}
