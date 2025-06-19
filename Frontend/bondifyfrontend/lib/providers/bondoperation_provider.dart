import '../models/bondoperation_model.dart';
import 'package:flutter/material.dart';

class BondoperationProvider extends ChangeNotifier {
  List<BondOperation> bondOperations = [
    BondOperation(
      id: 1, 
      operationname: 'Bono para mis empleados', 
      bondmethod: 'nose', 
      currency: 'nose', 
      interestratetype: 'nose', 
      capitalizationperiod: 'nose', 
      gracePeriodType: 'nose', 
      gracePeriodStartDate: 'nose', 
      gracePeriodEndDate: 'nose')
  ];

  void deleteBondOperation(int id){
    bondOperations = bondOperations.where((o)=>o.id != id).toList();
    notifyListeners();
  }


  // void addBondOperation(BondOperation operation) {
  //   bondOperations.add(operation);
  //   notifyListeners();
  // }

  // void removeBondOperation(BondOperation operation) {
  //   bondOperations.remove(operation);
  //   notifyListeners();
  // }

  // void clearBondOperations() {
  //   bondOperations.clear();
  //   notifyListeners();
  // }
}