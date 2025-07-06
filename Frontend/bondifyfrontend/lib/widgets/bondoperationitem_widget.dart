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
    final numberFormat = NumberFormat.currency(locale: 'es_PE', symbol: 'S/ ');
    final percentFormat = NumberFormat("##.00#", "es_ES");

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          final formProvider = context.read<BondFormProvider>();
          formProvider.selectAndCalculateBond(bondOperation);
          Navigator.pushNamed(context, 'resultsScreen');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      bondOperation.operationName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'delete' && bondOperation.id != null) {
                         context.read<BondoperationProvider>().deleteBondOperation(bondOperation.id!);
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem(value: 'edit', child: Text('Editar')),
                      const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                    ],
                  )
                ],
              ),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoColumn('Valor Nominal', numberFormat.format(bondOperation.nominalValue)),
                  _buildInfoColumn('Tasa Interés', '${percentFormat.format(bondOperation.interestRate)}%'),
                  _buildInfoColumn('Plazo (Años)', bondOperation.numberOfYears.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.black54, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}
