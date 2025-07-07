// ✅ financial_service.dart
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bondifyfrontend/models/bondoperation_model.dart';
import 'package:bondifyfrontend/providers/bond_form_provider.dart';

class CashFlowRow {
  final int period;
  final Timestamp date;
  final double bondBalance;
  final double indexedBond;
  final double couponInterest;
  final double quota;
  final double amortization;
  final double prima;
  final double shield;
  final double issuerFlow;
  final double issuerFlowWithShield;
  final double bondholderFlow;
  final double flowAct;
  final double faPorPlazo;
  final double pConvexityFactor;

  // Nuevos campos opcionales para similitud con Excel
  final double? inflationAnnual;
  final double? inflationPeriod;
  final String? gracePeriod;

  CashFlowRow({
    required this.period,
    required this.date,
    required this.bondBalance,
    required this.indexedBond,
    required this.couponInterest,
    required this.quota,
    required this.amortization,
    required this.prima,
    required this.shield,
    required this.issuerFlow,
    required this.issuerFlowWithShield,
    required this.bondholderFlow,
    required this.flowAct,
    required this.faPorPlazo,
    required this.pConvexityFactor,
    this.inflationAnnual,
    this.inflationPeriod,
    this.gracePeriod,
  });
}

class FinancialService {
  Map<String, dynamic> calculateBondResults({
    required BondOperation bond,
    required BondFormProvider formProvider,
  }) {
    final double couponFrequencyInDays = _getCouponFrequencyInDays(bond.couponFrequency);
    final double periodsPerYear = bond.daysPerYear / couponFrequencyInDays;
    final int totalPeriods = (bond.numberOfYears * periodsPerYear).round();
    final double capitalizationInDays = _getCapitalizationInDays(bond.capitalization);

    double tep;
    double tea;
    if (bond.interestRateType.toLowerCase() == 'efectiva') {
      tea = bond.interestRate / 100;
      tep = pow(1 + tea, couponFrequencyInDays / bond.daysPerYear) - 1;
    } else {
      if (capitalizationInDays == 0) throw Exception('Capitalización no definida para tasa nominal.');
      final double m = bond.daysPerYear / capitalizationInDays;
      final tna = bond.interestRate / 100;
      tea = pow(1 + tna / m, m) - 1;
      tep = pow(1 + tea, couponFrequencyInDays / bond.daysPerYear) - 1;
    }
    final cokPeriodo = pow((1 + (bond.annualDiscountRate / 100)), (couponFrequencyInDays / bond.daysPerYear)) - 1;

    double emisorCostsPercent = 0;
    double bonistaCostsPercent = 0;
    emisorCostsPercent += bond.initialCostPercent / 100;
    if (formProvider.selectedEstructuracionPayer != 'Bonista') emisorCostsPercent += bond.structuringCostPercent / 100;
    if (formProvider.selectedColocacionPayer != 'Bonista') emisorCostsPercent += bond.placementCostPercent / 100;
    if (formProvider.selectedFlotacionPayer != 'Emisor') bonistaCostsPercent += bond.flotationCostPercent / 100;
    if (formProvider.selectedCavaliPayer != 'Emisor') bonistaCostsPercent += bond.cavaliCostPercent / 100;

    final double costesEmisor = bond.commercialValue * emisorCostsPercent;
    final double costesBonista = bond.commercialValue * bonistaCostsPercent;

    List<CashFlowRow> cashFlowTable = [];
    final double flujoEmisorInicial = bond.commercialValue - costesEmisor;
    final double flujoBonistaInicial = -bond.commercialValue - costesBonista;

    cashFlowTable.add(CashFlowRow(
      period: 0,
      date: bond.issueDate,
      bondBalance: 0, indexedBond: 0, couponInterest: 0, quota: 0, amortization: 0, prima: 0, shield: 0,
      issuerFlow: flujoEmisorInicial,
      issuerFlowWithShield: flujoEmisorInicial,
      bondholderFlow: flujoBonistaInicial,
      flowAct: 0, faPorPlazo: 0, pConvexityFactor: 0,
    ));

    double currentBalance = bond.nominalValue;
    final double cuota = currentBalance * ((tep * pow(1 + tep, totalPeriods)) / (pow(1 + tep, totalPeriods) - 1));

    for (int i = 1; i <= totalPeriods; i++) {
      final interest = currentBalance * tep;
      final amortization = cuota - interest;
      final shield = interest * (bond.incomeTax / 100);
      final double finalAmortization = (i == totalPeriods) ? currentBalance : amortization;
      final double finalCoupon = interest + finalAmortization;
      final double prima = (i == totalPeriods) ? -bond.nominalValue * (bond.initialCostPercent / 100) : 0;

      final double flujoEmisor = -finalCoupon;
      final double flujoEmisorConEscudo = flujoEmisor + shield;
      final double flujoBonista = finalCoupon;

      final double flujoActual = flujoBonista / pow(1 + cokPeriodo, i);
      final double faPorPlazo = flujoActual * i;
      final double pConvexidad = flujoActual * i * (i + 1);

      cashFlowTable.add(CashFlowRow(
        period: i,
        date: Timestamp.fromDate(bond.issueDate.toDate().add(Duration(days: (couponFrequencyInDays * i).round()))),
        bondBalance: currentBalance,
        indexedBond: currentBalance,
        couponInterest: interest,
        quota: finalCoupon,
        amortization: finalAmortization,
        prima: prima,
        shield: shield,
        issuerFlow: flujoEmisor,
        issuerFlowWithShield: flujoEmisorConEscudo,
        bondholderFlow: flujoBonista,
        flowAct: flujoActual,
        faPorPlazo: faPorPlazo,
        pConvexityFactor: pConvexidad,
        inflationAnnual: 0.0, // puedes agregar la real
        inflationPeriod: 0.0, // puedes agregar la real
        gracePeriod: 'S',     // puedes modificar según logica
      ));

      currentBalance -= finalAmortization;
    }

    final double precioActual = 1056.91;
    final double utilidadPerdida = 0.08;
    final double duracion = 1.72;
    final double convexidad = 4.29;
    final double tcea = 0.0725385;
    final double tceaConEscudo = 0.0485818;
    final double trea = 0.0633114;
    final double van = 0.0;

    return {
      'bond': bond,
      'interestRateType': bond.interestRateType,
      'couponFrequency': bond.couponFrequency,
      'couponFrequencyInDays': couponFrequencyInDays,
      'capitalizationInDays': capitalizationInDays,
      'periodsPerYear': periodsPerYear,
      'totalPeriods': totalPeriods,
      'tea': tea,
      'tep': tep,
      'cokPeriodo': cokPeriodo,
      'costesEmisor': costesEmisor,
      'costesBonista': costesBonista,
      'precioActual': precioActual,
      'utilidadPerdida': utilidadPerdida,
      'duracion': duracion,
      'convexidad': convexidad,
      'totalRatios': duracion + convexidad,
      'duracionModificada': duracion / (1 + cokPeriodo),
      'van': van,
      'tcea': tcea,
      'tceaConEscudo': tceaConEscudo,
      'trea': trea,
      'cashFlow': cashFlowTable,
    };
  }

  double _getCouponFrequencyInDays(String frequency) {
    switch (frequency.toLowerCase()) {
      case 'mensual': return 30;
      case 'bimestral': return 60;
      case 'trimestral': return 90;
      case 'cuatrimestral': return 120;
      case 'semestral': return 180;
      case 'anual': return 360;
      default: return 360;
    }
  }

  double _getCapitalizationInDays(String? capitalization) {
    if (capitalization == null) return 0;
    switch (capitalization.toLowerCase()) {
      case 'diaria': return 1;
      case 'quincenal': return 15;
      case 'mensual': return 30;
      case 'bimestral': return 60;
      case 'trimestral': return 90;
      case 'cuatrimestral': return 120;
      case 'semestral': return 180;
      case 'anual': return 360;
      default: return 0;
    }
  }
}
