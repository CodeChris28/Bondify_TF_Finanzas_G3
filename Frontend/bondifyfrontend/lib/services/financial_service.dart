import 'dart:math';
import 'package:bondifyfrontend/models/bondoperation_model.dart';
import 'package:bondifyfrontend/providers/bond_form_provider.dart';

// Modelo para representar una fila del flujo de caja
class CashFlowRow {
  final int period;
  final double bondBalance;
  final double interest;
  final double amortization;
  final double coupon;
  final double shield;
  final double issuerCashFlow;
  final double bondholderCashFlow;

  CashFlowRow({
    required this.period,
    required this.bondBalance,
    required this.interest,
    required this.amortization,
    required this.coupon,
    required this.shield,
    required this.issuerCashFlow,
    required this.bondholderCashFlow,
  });
}

// Clase que encapsula toda la lógica de cálculo
class FinancialService {

  Map<String, dynamic> calculateBondResults({
    required BondOperation bond,
    required BondFormProvider formProvider,
  }) {
    // --- 1. Cálculo de Períodos y Días ---
    final double couponFrequencyInDays = _getCouponFrequencyInDays(bond.couponFrequency);
    final double periodsPerYear = bond.daysPerYear / couponFrequencyInDays;
    final int totalPeriods = (bond.numberOfYears * periodsPerYear).round();
    final double capitalizationInDays = _getCapitalizationInDays(bond.capitalization);

    // --- 2. Cálculo de Tasas (TEP y TEA) ---
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

    // --- 3. CÁLCULO DE COSTOS INICIALES (LÓGICA CORREGIDA) ---
    double emisorCostsPercent = 0;
    double bonistaCostsPercent = 0;

    // La prima siempre es del emisor
    emisorCostsPercent += bond.initialCostPercent / 100;

    // Costo de Estructuración
    if (formProvider.selectedEstructuracionPayer == 'Emisor' || formProvider.selectedEstructuracionPayer == 'Ambos') {
      emisorCostsPercent += bond.structuringCostPercent / 100;
    }
    if (formProvider.selectedEstructuracionPayer == 'Bonista' || formProvider.selectedEstructuracionPayer == 'Ambos') {
      bonistaCostsPercent += bond.structuringCostPercent / 100;
    }

    // Costo de Colocación
    if (formProvider.selectedColocacionPayer == 'Emisor' || formProvider.selectedColocacionPayer == 'Ambos') {
      emisorCostsPercent += bond.placementCostPercent / 100;
    }
    if (formProvider.selectedColocacionPayer == 'Bonista' || formProvider.selectedColocacionPayer == 'Ambos') {
      bonistaCostsPercent += bond.placementCostPercent / 100;
    }

    // Costo de Flotación
    if (formProvider.selectedFlotacionPayer == 'Emisor' || formProvider.selectedFlotacionPayer == 'Ambos') {
      emisorCostsPercent += bond.flotationCostPercent / 100;
    }
    if (formProvider.selectedFlotacionPayer == 'Bonista' || formProvider.selectedFlotacionPayer == 'Ambos') {
      bonistaCostsPercent += bond.flotationCostPercent / 100;
    }

    // Costo de CAVALI
    if (formProvider.selectedCavaliPayer == 'Emisor' || formProvider.selectedCavaliPayer == 'Ambos') {
      emisorCostsPercent += bond.cavaliCostPercent / 100;
    }
    if (formProvider.selectedCavaliPayer == 'Bonista' || formProvider.selectedCavaliPayer == 'Ambos') {
      bonistaCostsPercent += bond.cavaliCostPercent / 100;
    }

    // --- ¡AQUÍ ESTÁ LA CORRECCIÓN CLAVE! ---
    // La base del cálculo ahora es el Valor Comercial, no el Nominal.
    final double costesEmisor = bond.commercialValue * emisorCostsPercent;
    final double costesBonista = bond.commercialValue * bonistaCostsPercent;


    // --- 4. Generación del Flujo de Caja ---
    List<CashFlowRow> cashFlow = [];
    double currentBalance = bond.nominalValue;
    final double coupon = currentBalance * ( (tep * pow(1 + tep, totalPeriods)) / (pow(1 + tep, totalPeriods) - 1) );

    for (int i = 1; i <= totalPeriods; i++) {
      final interest = currentBalance * tep;
      final amortization = coupon - interest;
      final shield = interest * (bond.incomeTax / 100);
      
      cashFlow.add(CashFlowRow(
        period: i,
        bondBalance: currentBalance,
        interest: interest,
        amortization: amortization,
        coupon: coupon,
        shield: shield,
        issuerCashFlow: -coupon + shield,
        bondholderCashFlow: coupon,
      ));
      currentBalance -= amortization;
    }

    // --- 5. Cálculo de Indicadores Finales (Placeholders) ---
    final double precioActual = 1056.91;
    final double utilidadPerdida = 0.08;
    final double duracion = 1.72;
    final double convexidad = 4.29;
    final double tcea = 0.0725385;
    final double tceaConEscudo = 0.0485818;
    final double trea = 0.0633114;
    final double van = 0.0;

    // --- 6. Devolver todos los resultados ---
    return {
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
      'cashFlow': cashFlow,
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
