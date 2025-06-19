import 'package:bondifyfrontend/models/user_model.dart';

import '../models/bondoperation_model.dart';
import 'package:flutter/material.dart';

class BondoperationProvider extends ChangeNotifier {
  List<BondOperation> bondOperations = [
      BondOperation(
    id: 1,
    user: User(
          id: 1,
          username: 'chrisdev',
          email: 'chris@example.com',
          createdAt: '2025-06-01',
          updatedAt: '2025-06-01',
        ),
    operationname: 'Bono para empleados 2025',
    bondmethod: 'Cupón',
    currency: 'USD',
    interestratetype: 'Fijo',
    capitalizationperiod: 'Anual',
    gracePeriodType: 'Parcial',
    gracePeriodStartDate: '2025-01-01',
    gracePeriodEndDate: '2025-06-01',
    createdAt: '2025-06-19',
    updatedAt: '2025-06-19',
  ),
  BondOperation(
    id: 2,
    user: User(
          id: 1,
          username: 'chrisdev',
          email: 'chris@example.com',
          createdAt: '2025-06-01',
          updatedAt: '2025-06-01',
        ),
    operationname: 'Bono Construcción Lima',
    bondmethod: 'Descuento',
    currency: 'PEN',
    interestratetype: 'Variable',
    capitalizationperiod: 'Semestral',
    gracePeriodType: 'Total',
    gracePeriodStartDate: '2024-12-01',
    gracePeriodEndDate: '2025-03-01',
    createdAt: '2025-05-12',
    updatedAt: '2025-05-12',
  ),
  BondOperation(
    id: 3,
    user: User(
          id: 1,
          username: 'chrisdev',
          email: 'chris@example.com',
          createdAt: '2025-06-01',
          updatedAt: '2025-06-01',
        ),
    operationname: 'Bono Verde Financiero',
    bondmethod: 'Cupón',
    currency: 'USD',
    interestratetype: 'Mixto',
    capitalizationperiod: 'Trimestral',
    gracePeriodType: 'Parcial',
    gracePeriodStartDate: '2025-02-01',
    gracePeriodEndDate: '2025-07-01',
    createdAt: '2025-06-01',
    updatedAt: '2025-06-01',
  ),
  BondOperation(
    id: 4,
    user: User(
          id: 2,
          username: 'chrisdev2',
          email: 'chris@example2.com',
          createdAt: '2025-06-01',
          updatedAt: '2025-06-01',
        ),
    operationname: 'Bono Infraestructura Andes',
    bondmethod: 'Descuento',
    currency: 'EUR',
    interestratetype: 'Fijo',
    capitalizationperiod: 'Mensual',
    gracePeriodType: 'Sin gracia',
    gracePeriodStartDate: '-',
    gracePeriodEndDate: '-',
    createdAt: '2025-04-20',
    updatedAt: '2025-04-20',
  ),

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