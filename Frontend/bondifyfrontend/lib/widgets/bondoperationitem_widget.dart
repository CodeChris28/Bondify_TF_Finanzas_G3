import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bondifyfrontend/models/bondoperation_model.dart';
import 'package:bondifyfrontend/providers/bond_form_provider.dart';
import 'package:bondifyfrontend/providers/bondoperation_provider.dart';
import 'package:provider/provider.dart';

class BondoperationitemWidget extends StatelessWidget {
  const BondoperationitemWidget({
    super.key,
    required this.bondOperation,
  });

  final BondOperation bondOperation;

  @override
  Widget build(BuildContext context) {
    // Formateadores para moneda, porcentaje y fecha
    final currencyFormat = NumberFormat.currency(locale: 'es_PE', symbol: '${bondOperation.currency} ');
    final percentFormat = NumberFormat("##0.00'%'", "es_ES");
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          // Al tocar, calculamos los resultados y navegamos a la pantalla de detalles
          final formProvider = context.read<BondFormProvider>();
          formProvider.selectAndCalculateBond(bondOperation);
          Navigator.pushNamed(context, 'resultsScreen');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SECCIÓN 1: ENCABEZADO ---
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.analytics_outlined, color: Colors.deepPurple, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bondOperation.operationName,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          // Subtítulo con fecha de emisión
                          'Emitido el: ${dateFormat.format(bondOperation.issueDate.toDate())}',
                          style: const TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  // Menú de acciones (Editar/Eliminar)
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'delete' && bondOperation.id != null) {
                        context.read<BondoperationProvider>().deleteBondOperation(bondOperation.id!);
                      }
                      // Aquí puedes añadir la lógica para 'edit'
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit, size: 18), SizedBox(width: 8), Text('Editar')])),
                      const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, size: 18), SizedBox(width: 8), Text('Eliminar')])),
                    ],
                  ),
                ],
              ),
              const Divider(height: 24, thickness: 0.5),

              // --- SECCIÓN 2: MÉTRICAS CLAVE (TREA Y TCEA) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMetric(
                    icon: Icons.trending_up_rounded,
                    label: 'TREA Bonista',
                    value: percentFormat.format(bondOperation.treaBondholderPercent),
                    color: Colors.green.shade700,
                  ),
                  _buildMetric(
                    icon: Icons.trending_down_rounded,
                    label: 'TCEA Emisor',
                    value: percentFormat.format(bondOperation.tceaIssuerPercent),
                    color: Colors.red.shade700,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // --- SECCIÓN 3: ATRIBUTOS DEL BONO ---
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAttribute('Valor Nominal', currencyFormat.format(bondOperation.nominalValue)),
                    _buildAttribute('Frecuencia', bondOperation.couponFrequency),
                    _buildAttribute('Plazo', '${bondOperation.numberOfYears} Años'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para las métricas principales (TREA/TCEA)
  Widget _buildMetric({required IconData icon, required String label, required String value, required Color color}) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.black54, fontSize: 12)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color)),
      ],
    );
  }

  // Widget auxiliar para los atributos en la fila inferior
  Widget _buildAttribute(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: const TextStyle(color: Colors.black54, fontSize: 11)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87)),
      ],
    );
  }
}