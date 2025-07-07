import 'package:bondifyfrontend/services/financial_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bondifyfrontend/models/bondoperation_model.dart';
import 'package:bondifyfrontend/providers/bond_form_provider.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              flex: 3, // Asigna más espacio a las pestañas
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
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: Text(
                'Flujo de Caja Detallado',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 1),
            // El flujo de caja ahora tiene más espacio
            Expanded(
              flex: 7, // Asigna más espacio al flujo de caja
              child: _buildCashFlowView(context, results)
            ),
          ],
        ),
      ),
    );
  }

  // --- Widgets para las Pestañas (sin cambios) ---
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
  // --- FIN Widgets para las Pestañas ---


  /// Widget para construir la tabla de Flujo de Caja con el nuevo estilo.
  Widget _buildCashFlowView(BuildContext context, Map<String, dynamic> results) {
    final List<CashFlowRow> cashFlow = results['cashFlow'];
    final numberFormat = NumberFormat("#,##0.00", "es_ES");
    final dateFormat = DateFormat('dd/MM/yyyy');
    final headers = [
      'Nº', 'Fecha', '% Inf. Anual', '% Inf. Semestral', 'Plazo Gracia', 'Bono',
      'Bono Index.', 'Cupón (I)', 'Cuota', 'Amort.', 'Prima', 'Escudo', 'Flujo Emisor',
      'Flujo Emisor c/E', 'Flujo Bonista', 'Flujo Act.', 'FA x Plazo', 'pConvexidad'
    ];

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            // Estilo de los encabezados
            headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13),
            dataRowMinHeight: 40,
            dataRowMaxHeight: 48,
            columnSpacing: 24.0,
            // Aplicamos el efecto cebra a las filas
            dataRowColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                }
                return null; // Usa el color predeterminado para filas no seleccionadas.
              },
            ),
            columns: headers.map((header) => DataColumn(label: Text(header, textAlign: TextAlign.center))).toList(),
            rows: cashFlow.asMap().entries.map((entry) {
              int index = entry.key;
              CashFlowRow row = entry.value;
              final isZero = row.period == 0;
              
              // Definir el color de fondo para el efecto cebra
              final Color rowColor = index.isEven ? Colors.transparent : Colors.grey.withOpacity(0.08);

              return DataRow(
                color: MaterialStateProperty.all(rowColor),
                cells: [
                  _buildDataCell(row.period.toString(), isNumeric: true),
                  _buildDataCell(dateFormat.format(row.date.toDate())),
                  _buildDataCell(isZero ? '-' : '${(row.inflationAnnual ?? 0).toStringAsFixed(2)}%', isNumeric: true),
                  _buildDataCell(isZero ? '-' : '${(row.inflationPeriod ?? 0).toStringAsFixed(2)}%', isNumeric: true),
                  _buildDataCell(isZero ? '-' : row.gracePeriod ?? '-', isCenter: true),
                  _buildDataCell(isZero ? '-' : numberFormat.format(row.bondBalance), isNumeric: true),
                  _buildDataCell(isZero ? '-' : numberFormat.format(row.indexedBond), isNumeric: true),
                  _buildDataCell(isZero ? '-' : numberFormat.format(row.couponInterest), value: row.couponInterest, isNumeric: true),
                  // Celda especial para la cuota
                  _buildDataCell(isZero ? '-' : numberFormat.format(row.quota), value: row.quota, isNumeric: true, isQuota: true),
                  _buildDataCell(isZero ? '-' : numberFormat.format(row.amortization), value: row.amortization, isNumeric: true),
                  _buildDataCell(isZero ? '-' : numberFormat.format(row.prima), value: row.prima, isNumeric: true),
                  _buildDataCell(isZero ? '-' : numberFormat.format(row.shield), value: row.shield, isNumeric: true),
                  _buildDataCell(numberFormat.format(row.issuerFlow), value: row.issuerFlow, isNumeric: true),
                  _buildDataCell(numberFormat.format(row.issuerFlowWithShield), value: row.issuerFlowWithShield, isNumeric: true),
                  _buildDataCell(numberFormat.format(row.bondholderFlow), value: row.bondholderFlow, isNumeric: true, isPositive: true),
                  _buildDataCell(isZero ? '-' : numberFormat.format(row.flowAct), value: row.flowAct, isNumeric: true),
                  _buildDataCell(isZero ? '-' : numberFormat.format(row.faPorPlazo), value: row.faPorPlazo, isNumeric: true),
                  _buildDataCell(isZero ? '-' : numberFormat.format(row.pConvexityFactor), value: row.pConvexityFactor, isNumeric: true),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  /// Widget auxiliar para crear celdas de datos con estilo condicional.
  DataCell _buildDataCell(
    String text, {
    double? value,
    bool isNumeric = false,
    bool isPositive = false,
    bool isQuota = false,
    bool isCenter = false,
  }) {
    Color? textColor;
    if (value != null && value < 0) {
      textColor = Colors.red.shade700;
    } else if (isPositive) {
      textColor = Colors.green.shade700;
    }

    return DataCell(
      Container(
        // Si es la columna de cuota, le damos un fondo especial
        color: isQuota ? Colors.orange.shade300 : Colors.transparent,
        alignment: isNumeric ? Alignment.centerRight : (isCenter ? Alignment.center : Alignment.centerLeft),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 13, fontWeight: isQuota ? FontWeight.bold : FontWeight.normal),
          textAlign: isNumeric ? TextAlign.right : TextAlign.left,
        ),
      ),
    );
  }
}