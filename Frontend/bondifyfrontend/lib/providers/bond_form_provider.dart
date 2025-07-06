import 'package:bondifyfrontend/models/bondoperation_model.dart';
import 'package:bondifyfrontend/providers/bondoperation_provider.dart';
import 'package:bondifyfrontend/services/financial_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BondFormProvider extends ChangeNotifier {
  final FinancialService _financialService = FinancialService();
  Map<String, dynamic>? lastCalculationResults;

  // --- Listas de Opciones para los Dropdowns ---
  final List<String> couponFrequencyOptions = ['Mensual', 'Bimestral', 'Trimestral', 'Cuatrimestral', 'Semestral', 'Anual'];
  final List<String> daysPerYearOptions = ['360', '365'];
  final List<String> interestRateTypeOptions = ['Efectiva', 'Nominal'];
  final List<String> capitalizationOptions = ['Diaria', 'Quincenal', 'Mensual', 'Bimestral', 'Trimestral', 'Cuatrimestral', 'Semestral', 'Anual'];
  final List<String> costPayerOptions = ['Emisor', 'Bonista', 'Ambos'];
  final List<String> gracePeriodTypeOptions = ['Sin Gracia', 'Parcial (P)', 'Total (T)'];

  // --- Estado para los valores seleccionados ---
  String? selectedCouponFrequency = 'Semestral';
  String? selectedDaysPerYear = '360';
  String? selectedInterestRateType = 'Efectiva';
  String? selectedCapitalization;
  String? selectedPrimaPayer = 'Emisor';
  String? selectedEstructuracionPayer = 'Emisor';
  String? selectedColocacionPayer = 'Emisor';
  String? selectedFlotacionPayer = 'Ambos';
  String? selectedCavaliPayer = 'Ambos';
  String? selectedGracePeriodType = 'Sin Gracia';
  
  // --- Controladores de Texto ---
  final operationNameController = TextEditingController();
  final nominalValueController = TextEditingController();
  final commercialValueController = TextEditingController();
  final numberOfYearsController = TextEditingController();
  final interestRateController = TextEditingController();
  final annualDiscountRateController = TextEditingController();
  final incomeTaxController = TextEditingController();
  final issueDateController = TextEditingController();
  final initialCostPercentController = TextEditingController();
  final structuringCostPercentController = TextEditingController();
  final placementCostPercentController = TextEditingController();
  final flotationCostPercentController = TextEditingController();
  final cavaliCostPercentController = TextEditingController();
  final gracePeriodPeriodsController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void updateDropdownValue({required String field, required String? value}) {
    switch (field) {
      case 'couponFrequency': selectedCouponFrequency = value; break;
      case 'daysPerYear': selectedDaysPerYear = value; break;
      case 'interestRateType':
        selectedInterestRateType = value;
        if (value == 'Efectiva') { selectedCapitalization = null; }
        break;
      case 'capitalization': selectedCapitalization = value; break;
      case 'primaPayer': selectedPrimaPayer = value; break;
      case 'estructuracionPayer': selectedEstructuracionPayer = value; break;
      case 'colocacionPayer': selectedColocacionPayer = value; break;
      case 'flotacionPayer': selectedFlotacionPayer = value; break;
      case 'cavaliPayer': selectedCavaliPayer = value; break;
      case 'gracePeriodType': selectedGracePeriodType = value; break;
    }
    notifyListeners();
  }

  Future<void> selectIssueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      issueDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      notifyListeners();
    }
  }

  Future<bool> calculateAndSaveBond(BuildContext context, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      DateTime issueDateTime;
      try {
        issueDateTime = DateFormat('dd/MM/yyyy').parse(issueDateController.text);
      } catch (e) {
        issueDateTime = DateTime.now();
      }
      final issueTimestamp = Timestamp.fromDate(issueDateTime);

      final bondDataForCalculation = BondOperation(
        userId: userId,
        operationName: operationNameController.text,
        currency: 'PEN',
        bondMethod: 'Francés',
        nominalValue: double.tryParse(nominalValueController.text) ?? 0.0,
        commercialValue: double.tryParse(commercialValueController.text) ?? 0.0,
        numberOfYears: int.tryParse(numberOfYearsController.text) ?? 0,
        couponFrequency: selectedCouponFrequency ?? 'Semestral',
        daysPerYear: int.tryParse(selectedDaysPerYear ?? '360') ?? 360,
        interestRateType: selectedInterestRateType ?? 'Efectiva',
        capitalization: selectedCapitalization,
        interestRate: double.tryParse(interestRateController.text) ?? 0.0,
        annualDiscountRate: double.tryParse(annualDiscountRateController.text) ?? 0.0,
        incomeTax: double.tryParse(incomeTaxController.text) ?? 0.0,
        issueDate: issueTimestamp,
        gracePeriodType: selectedGracePeriodType ?? 'Sin Gracia',
        gracePeriodPeriods: int.tryParse(gracePeriodPeriodsController.text) ?? 0,
        initialCostPercent: double.tryParse(initialCostPercentController.text) ?? 0.0,
        structuringCostPercent: double.tryParse(structuringCostPercentController.text) ?? 0.0,
        placementCostPercent: double.tryParse(placementCostPercentController.text) ?? 0.0,
        flotationCostPercent: double.tryParse(flotationCostPercentController.text) ?? 0.0,
        cavaliCostPercent: double.tryParse(cavaliCostPercentController.text) ?? 0.0,
        tceaIssuerPercent: 0,
        treaBondholderPercent: 0,
      );

      // --- ¡AQUÍ ESTÁ EL CAMBIO CLAVE! ---
      // Le pasamos 'this' (la instancia actual del BondFormProvider) al servicio de cálculo.
      lastCalculationResults = _financialService.calculateBondResults(
        bond: bondDataForCalculation,
        formProvider: this, 
      );

      final finalOperationToSave = bondDataForCalculation.copyWith(
        tceaIssuerPercent: lastCalculationResults!['tcea'],
        treaBondholderPercent: lastCalculationResults!['trea'],
      );

      await context.read<BondoperationProvider>().addOperation(finalOperationToSave);
      
      _isLoading = false;
      notifyListeners();
      return true;

    } catch (e) {
      print("Error al calcular y guardar el bono: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  void selectAndCalculateBond(BondOperation bond) {
    // También actualizamos esta función para que pase el provider
    lastCalculationResults = _financialService.calculateBondResults(
      bond: bond,
      formProvider: this,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    operationNameController.dispose();
    nominalValueController.dispose();
    commercialValueController.dispose();
    numberOfYearsController.dispose();
    interestRateController.dispose();
    annualDiscountRateController.dispose();
    incomeTaxController.dispose();
    issueDateController.dispose();
    initialCostPercentController.dispose();
    structuringCostPercentController.dispose();
    placementCostPercentController.dispose();
    flotationCostPercentController.dispose();
    cavaliCostPercentController.dispose();
    gracePeriodPeriodsController.dispose();
    super.dispose();
  }
}
