// ✅ results_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bondifyfrontend/models/bondoperation_model.dart';
import 'package:bondifyfrontend/providers/bond_form_provider.dart';
import 'package:bondifyfrontend/services/financial_service.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formProvider = context.read<BondFormProvider>();
    final results = formProvider.lastCalculationResults;

    if (results == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Resultados')),
        body: const Center(child: Text('No se encontraron resultados para mostrar.')),
      );
    }

    final BondOperation bond = results['bond'];

    return Scaffold(
      appBar: AppBar(
        title: Text(bond.operationName, overflow: TextOverflow.ellipsis),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Datos del Bono'),
            Tab(text: 'Estructura'),
            Tab(text: 'Precio/Utilidad'),
            Tab(text: 'Ratios'),
            Tab(text: 'Rentabilidad'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildInitialDataView(context, bond),
                  _buildEstructuraView(context, results),
                  _buildPrecioUtilidadView(context, results),
                  _buildRatiosView(context, results),
                  _buildRentabilidadView(context, results),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 8),
              child: Text(
                'Flujo de Caja Detallado',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 1),
            _buildCashFlowView(context, results),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialDataView(BuildContext context, BondOperation bond) {
    final numberFormat = NumberFormat.currency(locale: 'es_PE', symbol: 'S/ ');
    final percentFormat = NumberFormat("##.00#", "es_ES");
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ListTile(title: const Text('Valor Nominal'), trailing: Text(numberFormat.format(bond.nominalValue))),
          ListTile(title: const Text('Valor Comercial'), trailing: Text(numberFormat.format(bond.commercialValue))),
          ListTile(title: const Text('Plazo en Años'), trailing: Text(bond.numberOfYears.toString())),
          ListTile(title: const Text('Frecuencia del Cupón'), trailing: Text(bond.couponFrequency)),
          ListTile(title: const Text('Tasa de Interés'), trailing: Text('${percentFormat.format(bond.interestRate)}%')),
          ListTile(title: const Text('Fecha de Emisión'), trailing: Text(dateFormat.format(bond.issueDate.toDate()))),
        ],
      ),
    );
  }

  Widget _buildEstructuraView(BuildContext context, Map<String, dynamic> results) {
    final percentFormat = NumberFormat("#,##0.0000#", "es_ES");
    final String interestRateType = results['interestRateType'];
    final String couponFrequency = results['couponFrequency'];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ListTile(title: const Text('Frecuencia del cupón (días)'), trailing: Text(results['couponFrequencyInDays'].toStringAsFixed(0))),
          if (interestRateType.toLowerCase() == 'nominal')
            ListTile(title: const Text('Días capitalización'), trailing: Text(results['capitalizationInDays'].toStringAsFixed(0))),
          ListTile(title: const Text('Nº Períodos por Año'), trailing: Text(results['periodsPerYear'].round().toString())),
          ListTile(title: const Text('Nº Total de Períodos'), trailing: Text(results['totalPeriods'].toString())),
          ListTile(title: const Text('Tasa efectiva anual'), trailing: Text('${percentFormat.format(results['tea'] * 100)} %')),
          ListTile(title: Text('Tasa Efectiva $couponFrequency'), trailing: Text('${percentFormat.format(results['tep'] * 100)} %')),
          ListTile(title: Text('COK $couponFrequency'), trailing: Text('${percentFormat.format(results['cokPeriodo'] * 100)} %')),
          ListTile(title: const Text('Costes Iniciales Emisor'), trailing: Text(results['costesEmisor'].toStringAsFixed(2))),
          ListTile(title: const Text('Costes Iniciales Bonista'), trailing: Text(results['costesBonista'].toStringAsFixed(2))),
        ],
      ),
    );
  }

  Widget _buildPrecioUtilidadView(BuildContext context, Map<String, dynamic> results) {
    final numberFormat = NumberFormat("#,##0.00", "es_ES");
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ListTile(title: const Text('Precio Actual'), trailing: Text(numberFormat.format(results['precioActual']))),
          ListTile(title: const Text('Utilidad / Pérdida'), trailing: Text(numberFormat.format(results['utilidadPerdida']))),
        ],
      ),
    );
  }

  Widget _buildRatiosView(BuildContext context, Map<String, dynamic> results) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ListTile(title: const Text('Duración'), trailing: Text(results['duracion'].toStringAsFixed(2))),
          ListTile(title: const Text('Convexidad'), trailing: Text(results['convexidad'].toStringAsFixed(2))),
          ListTile(title: const Text('Total'), trailing: Text(results['totalRatios'].toStringAsFixed(2))),
          ListTile(title: const Text('Duración Modificada'), trailing: Text(results['duracionModificada'].toStringAsFixed(2))),
        ],
      ),
    );
  }

  Widget _buildRentabilidadView(BuildContext context, Map<String, dynamic> results) {
    final percentFormat = NumberFormat("#,##0.000000#", "es_ES");
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ListTile(title: const Text('TCEA Emisor'), trailing: Text('${percentFormat.format(results['tcea'] * 100)} %')),
          ListTile(title: const Text('TCEA Emisor c/Escudo'), trailing: Text('${percentFormat.format(results['tceaConEscudo'] * 100)} %')),
          ListTile(title: const Text('TREA Bonista'), trailing: Text('${percentFormat.format(results['trea'] * 100)} %')),
        ],
      ),
    );
  }

  Widget _buildCashFlowView(BuildContext context, Map<String, dynamic> results) {
    final List<CashFlowRow> cashFlow = results['cashFlow'];
    final numberFormat = NumberFormat("#,##0.00", "es_ES");
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Expanded(
      child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Nº')),
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('% Inf. Anual')),
                DataColumn(label: Text('% Inf. Semestral')),
                DataColumn(label: Text('Plazo de Gracia')),
                DataColumn(label: Text('Bono')),
                DataColumn(label: Text('Bono Indexado')),
                DataColumn(label: Text('Cupón (Interés)')),
                DataColumn(label: Text('Cuota')),
                DataColumn(label: Text('Amort.')),
                DataColumn(label: Text('Prima')),
                DataColumn(label: Text('Escudo')),
                DataColumn(label: Text('Flujo Emisor')),
                DataColumn(label: Text('Flujo Emisor c/E')),
                DataColumn(label: Text('Flujo Bonista')),
                DataColumn(label: Text('Flujo Act.')),
                DataColumn(label: Text('FA x Plazo')),
                DataColumn(label: Text('pConvexidad')),
              ],
              rows: cashFlow.map((row) {
                final isZero = row.period == 0;
                return DataRow(
                  cells: [
                    DataCell(Text(row.period.toString())),
                    DataCell(Text(dateFormat.format(row.date.toDate()))),
                    DataCell(Text(isZero ? '-' : '${(row.inflationAnnual ?? 0).toStringAsFixed(2)}%')),
                    DataCell(Text(isZero ? '-' : '${(row.inflationPeriod ?? 0).toStringAsFixed(2)}%')),
                    DataCell(Text(isZero ? '-' : row.gracePeriod ?? '-')),
                    DataCell(Text(isZero ? '-' : numberFormat.format(row.bondBalance))),
                    DataCell(Text(isZero ? '-' : numberFormat.format(row.indexedBond))),
                    DataCell(Text(isZero ? '-' : numberFormat.format(row.couponInterest))),
                    DataCell(Text(isZero ? '-' : numberFormat.format(row.quota))),
                    DataCell(Text(isZero ? '-' : numberFormat.format(row.amortization))),
                    DataCell(Text(isZero ? '-' : numberFormat.format(row.prima))),
                    DataCell(Text(isZero ? '-' : numberFormat.format(row.shield))),
                    DataCell(Text(numberFormat.format(row.issuerFlow))),
                    DataCell(Text(numberFormat.format(row.issuerFlowWithShield))),
                    DataCell(Text(numberFormat.format(row.bondholderFlow))),
                    DataCell(Text(isZero ? '-' : numberFormat.format(row.flowAct))),
                    DataCell(Text(isZero ? '-' : numberFormat.format(row.faPorPlazo))),
                    DataCell(Text(isZero ? '-' : numberFormat.format(row.pConvexityFactor))),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
} 
