import 'package:bondifyfrontend/models/bondoperation_model.dart';
import 'package:bondifyfrontend/providers/bondoperation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BondoperationitemWidget extends StatelessWidget {
  const BondoperationitemWidget({
    super.key,
    required this.bondOperation,
    });

    final BondOperation bondOperation;

  @override
  Widget build(BuildContext context) {
    final bondOperationProvider = context.read<BondoperationProvider>();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 238, 235, 221),
        borderRadius: BorderRadius.circular(10),
        boxShadow: List<BoxShadow>.generate(
          3,
          (index)=> BoxShadow(
            color: const Color.fromARGB(66, 0, 0, 0),
            offset: Offset(0, 2 * (index + 1)),
              blurRadius: 2 * (index + 1),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            Text(bondOperation.operationname)
          ],)
        ],
      ),
    );
  }
}