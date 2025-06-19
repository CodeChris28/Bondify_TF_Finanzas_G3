import 'package:flutter/material.dart';
import 'package:bondifyfrontend/models/bondoperation_model.dart';

class BondoperationitemWidget extends StatelessWidget {
  const BondoperationitemWidget({
    super.key,
    required this.bondOperation,
  });

  final BondOperation bondOperation;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔷 Título y acciones
            Row(
              children: [
                Expanded(
                  child: Text(
                    bondOperation.operationname,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    // Manejar acción
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Editar')),
                    const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                  ],
                )
              ],
            ),

            const SizedBox(height: 6),

            /// Subtítulo
            Text(
              '${bondOperation.currency} | ${bondOperation.createdAt}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),

            const Divider(height: 20),

            /// Info principal
            Row(
              children: [
                const Icon(Icons.percent, size: 20),
                const SizedBox(width: 6),
                Text('Interés: ${bondOperation.interestratetype}'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.sync_alt, size: 20),
                const SizedBox(width: 6),
                Text('Método: ${bondOperation.bondmethod}'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.schedule, size: 20),
                const SizedBox(width: 6),
                Text('Capitalización: ${bondOperation.capitalizationperiod}'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.date_range, size: 20),
                const SizedBox(width: 6),
                Text('Gracia: ${bondOperation.gracePeriodStartDate} → ${bondOperation.gracePeriodEndDate}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
