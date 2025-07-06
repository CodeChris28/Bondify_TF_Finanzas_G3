// =========================================================================
// ARCHIVO 1 de 2: El Modelo de Datos
// RUTA: lib/models/bondoperation_model.dart (CON EL MÉTODO copyWith AÑADIDO)
// =========================================================================
import 'package:cloud_firestore/cloud_firestore.dart';

class BondOperation {
  final String? id;
  final String userId;

  // --- Datos de Entrada ---
  final String operationName;
  final String currency;
  final String bondMethod;
  final double nominalValue;
  final double commercialValue;
  final int numberOfYears;
  final String couponFrequency;
  final int daysPerYear;
  final String interestRateType;
  final String? capitalization;
  final double interestRate;
  final double annualDiscountRate;
  final double incomeTax;
  final Timestamp issueDate;
  final String gracePeriodType;
  final int gracePeriodPeriods;
  final double initialCostPercent;
  final double structuringCostPercent;
  final double placementCostPercent;
  final double flotationCostPercent;
  final double cavaliCostPercent;

  // --- Resultados Calculados ---
  final double tceaIssuerPercent;
  final double treaBondholderPercent;

  BondOperation({
    this.id,
    required this.userId,
    required this.operationName,
    required this.currency,
    required this.bondMethod,
    required this.nominalValue,
    required this.commercialValue,
    required this.numberOfYears,
    required this.couponFrequency,
    required this.daysPerYear,
    required this.interestRateType,
    this.capitalization,
    required this.interestRate,
    required this.annualDiscountRate,
    required this.incomeTax,
    required this.issueDate,
    required this.gracePeriodType,
    required this.gracePeriodPeriods,
    required this.initialCostPercent,
    required this.structuringCostPercent,
    required this.placementCostPercent,
    required this.flotationCostPercent,
    required this.cavaliCostPercent,
    required this.tceaIssuerPercent,
    required this.treaBondholderPercent,
  });

  // --- MÉTODO copyWith AÑADIDO ---
  // Crea una copia del objeto actual, pero permite sobreescribir algunos campos.
  BondOperation copyWith({
    double? tceaIssuerPercent,
    double? treaBondholderPercent,
  }) {
    return BondOperation(
      id: id,
      userId: userId,
      operationName: operationName,
      currency: currency,
      bondMethod: bondMethod,
      nominalValue: nominalValue,
      commercialValue: commercialValue,
      numberOfYears: numberOfYears,
      couponFrequency: couponFrequency,
      daysPerYear: daysPerYear,
      interestRateType: interestRateType,
      capitalization: capitalization,
      interestRate: interestRate,
      annualDiscountRate: annualDiscountRate,
      incomeTax: incomeTax,
      issueDate: issueDate,
      gracePeriodType: gracePeriodType,
      gracePeriodPeriods: gracePeriodPeriods,
      initialCostPercent: initialCostPercent,
      structuringCostPercent: structuringCostPercent,
      placementCostPercent: placementCostPercent,
      flotationCostPercent: flotationCostPercent,
      cavaliCostPercent: cavaliCostPercent,
      tceaIssuerPercent: tceaIssuerPercent ?? this.tceaIssuerPercent,
      treaBondholderPercent: treaBondholderPercent ?? this.treaBondholderPercent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'operationName': operationName,
      'currency': currency,
      'bondMethod': bondMethod,
      'nominalValue': nominalValue,
      'commercialValue': commercialValue,
      'numberOfYears': numberOfYears,
      'couponFrequency': couponFrequency,
      'daysPerYear': daysPerYear,
      'interestRateType': interestRateType,
      'capitalization': capitalization,
      'interestRate': interestRate,
      'annualDiscountRate': annualDiscountRate,
      'incomeTax': incomeTax,
      'issueDate': issueDate,
      'gracePeriodType': gracePeriodType,
      'gracePeriodPeriods': gracePeriodPeriods,
      'initialCostPercent': initialCostPercent,
      'structuringCostPercent': structuringCostPercent,
      'placementCostPercent': placementCostPercent,
      'flotationCostPercent': flotationCostPercent,
      'cavaliCostPercent': cavaliCostPercent,
      'tceaIssuerPercent': tceaIssuerPercent,
      'treaBondholderPercent': treaBondholderPercent,
    };
  }

  factory BondOperation.fromMap(Map<String, dynamic> map, String documentId) {
    return BondOperation(
      id: documentId,
      userId: map['userId'] ?? '',
      operationName: map['operationName'] ?? 'Sin Nombre',
      currency: map['currency'] ?? 'N/A',
      bondMethod: map['bondMethod'] ?? 'N/A',
      nominalValue: (map['nominalValue'] ?? 0.0).toDouble(),
      commercialValue: (map['commercialValue'] ?? 0.0).toDouble(),
      numberOfYears: map['numberOfYears'] ?? 0,
      couponFrequency: map['couponFrequency'] ?? '',
      daysPerYear: map['daysPerYear'] ?? 0,
      interestRateType: map['interestRateType'] ?? '',
      capitalization: map['capitalization'],
      interestRate: (map['interestRate'] ?? 0.0).toDouble(),
      annualDiscountRate: (map['annualDiscountRate'] ?? 0.0).toDouble(),
      incomeTax: (map['incomeTax'] ?? 0.0).toDouble(),
      issueDate: map['issueDate'] ?? Timestamp.now(),
      gracePeriodType: map['gracePeriodType'] ?? '',
      gracePeriodPeriods: map['gracePeriodPeriods'] ?? 0,
      initialCostPercent: (map['initialCostPercent'] ?? 0.0).toDouble(),
      structuringCostPercent: (map['structuringCostPercent'] ?? 0.0).toDouble(),
      placementCostPercent: (map['placementCostPercent'] ?? 0.0).toDouble(),
      flotationCostPercent: (map['flotationCostPercent'] ?? 0.0).toDouble(),
      cavaliCostPercent: (map['cavaliCostPercent'] ?? 0.0).toDouble(),
      tceaIssuerPercent: (map['tceaIssuerPercent'] ?? 0.0).toDouble(),
      treaBondholderPercent: (map['treaBondholderPercent'] ?? 0.0).toDouble(),
    );
  }
}
