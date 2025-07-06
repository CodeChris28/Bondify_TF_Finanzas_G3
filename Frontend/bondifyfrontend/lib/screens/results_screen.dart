import 'package:bondifyfrontend/providers/bond_form_provider.dart';
import 'package:bondifyfrontend/services/financial_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    _tabController = TabController(length: 4, vsync: this);
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
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados de la Operación'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Estructura'),
            Tab(text: 'Precio/Utilidad'),
            Tab(text: 'Ratios'),
            Tab(text: 'Rentabilidad'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildEstructuraView(context, results),
                _buildPrecioUtilidadView(context, results),
                _buildRatiosView(context, results),
                _buildRentabilidadView(context, results),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text(
              'Flujo de Caja Detallado',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          Expanded(
            child: _buildCashFlowView(context, results),
          ),
        ],
      ),
    );
  }

  Widget _buildEstructuraView(BuildContext context, Map<String, dynamic> results) {
    final percentFormat = NumberFormat("#,##0.0000#", "es_ES");
    final String interestRateType = results['interestRateType'];
    final String couponFrequency = results['couponFrequency'];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(title: const Text('Frecuencia del cupón (días)'), trailing: Text(results['couponFrequencyInDays'].toStringAsFixed(0))),
                if (interestRateType.toLowerCase() == 'nominal')
                  ListTile(title: const Text('Días capitalización'), trailing: Text(results['capitalizationInDays'].toStringAsFixed(0))),
                ListTile(title: const Text('Nº Períodos por Año'), trailing: Text(results['periodsPerYear'].round().toString())),
                ListTile(title: const Text('Nº Total de Períodos'), trailing: Text(results['totalPeriods'].toString())),
                ListTile(title: const Text('Tasa efectiva anual'), trailing: Text('${percentFormat.format(results['tea'] * 100)} %')),
                ListTile(title: Text('Tasa Efectiva ${couponFrequency}'), trailing: Text('${percentFormat.format(results['tep'] * 100)} %')),
                ListTile(title: Text('COK ${couponFrequency}'), trailing: Text('${percentFormat.format(results['cokPeriodo'] * 100)} %')),
                ListTile(title: const Text('Costes Iniciales Emisor'), trailing: Text(results['costesEmisor'].toStringAsFixed(2))),
                ListTile(title: const Text('Costes Iniciales Bonista'), trailing: Text(results['costesBonista'].toStringAsFixed(2))),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPrecioUtilidadView(BuildContext context, Map<String, dynamic> results) {
    final numberFormat = NumberFormat("#,##0.00", "es_ES");
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(title: const Text('Precio Actual'), trailing: Text(numberFormat.format(results['precioActual']))),
                ListTile(title: const Text('Utilidad / Pérdida'), trailing: Text(numberFormat.format(results['utilidadPerdida']))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatiosView(BuildContext context, Map<String, dynamic> results) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(title: const Text('Duración'), trailing: Text(results['duracion'].toStringAsFixed(2))),
                ListTile(title: const Text('Convexidad'), trailing: Text(results['convexidad'].toStringAsFixed(2))),
                ListTile(title: const Text('Total'), trailing: Text(results['totalRatios'].toStringAsFixed(2))),
                ListTile(title: const Text('Duración Modificada'), trailing: Text(results['duracionModificada'].toStringAsFixed(2))),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildRentabilidadView(BuildContext context, Map<String, dynamic> results) {
    final percentFormat = NumberFormat("#,##0.000000#", "es_ES");
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(title: const Text('TCEA Emisor'), trailing: Text('${percentFormat.format(results['tcea'] * 100)} %')),
                ListTile(title: const Text('TCEA Emisor c/Escudo'), trailing: Text('${percentFormat.format(results['tceaConEscudo'] * 100)} %')),
                ListTile(title: const Text('TREA Bonista'), trailing: Text('${percentFormat.format(results['trea'] * 100)} %')),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCashFlowView(BuildContext context, Map<String, dynamic> results) {
    final List<CashFlowRow> cashFlow = results['cashFlow'];
    final numberFormat = NumberFormat("#,##0.00", "es_ES");
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Nº')),
            DataColumn(label: Text('Interés')),
            DataColumn(label: Text('Amort.')),
            DataColumn(label: Text('Cupón')),
            DataColumn(label: Text('Escudo')),
            DataColumn(label: Text('Flujo Emisor')),
          ],
          rows: cashFlow.map((row) => DataRow(
            cells: [
              DataCell(Text(row.period.toString())),
              DataCell(Text(numberFormat.format(row.interest))),
              DataCell(Text(numberFormat.format(row.amortization))),
              DataCell(Text(numberFormat.format(row.coupon))),
              DataCell(Text(numberFormat.format(row.shield))),
              DataCell(Text(numberFormat.format(row.issuerCashFlow))),
            ]
          )).toList(),
        ),
      ),
    );
  }
}
