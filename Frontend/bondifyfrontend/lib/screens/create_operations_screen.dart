import 'package:bondifyfrontend/widgets/bottom_navigation_bar_widget';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bond_form_provider.dart';
import '../providers/auth_provider.dart';

class CreateOperationScreen extends StatelessWidget {
  const CreateOperationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos 'watch' para que la UI se redibuje cuando cambien los valores de los dropdowns
    final formProvider = context.watch<BondFormProvider>();
    // Usamos 'read' para el authProvider porque solo necesitamos leer el uid al presionar el botón
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Nueva Operación'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionCard(
                  context: context,
                  title: 'Datos Generales',
                  children: [
                    TextFormField(
                      controller: formProvider.operationNameController,
                      decoration: const InputDecoration(labelText: 'Nombre de la Operación', border: OutlineInputBorder())
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: TextFormField(controller: formProvider.nominalValueController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Valor Nominal', border: OutlineInputBorder()))),
                        const SizedBox(width: 16),
                        Expanded(child: TextFormField(controller: formProvider.commercialValueController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Valor Comercial', border: OutlineInputBorder()))),
                      ],
                    ),
                  ],
                ),
                
                _buildSectionCard(
                  context: context,
                  title: 'Tasas y Plazos',
                  children: [
                    Row(
                      children: [
                        Expanded(child: TextFormField(controller: formProvider.numberOfYearsController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Nº de Años', border: OutlineInputBorder()))),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: formProvider.selectedCouponFrequency,
                            decoration: const InputDecoration(labelText: 'Frec. del Cupón', border: OutlineInputBorder()),
                            items: formProvider.couponFrequencyOptions.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
                            onChanged: (value) => formProvider.updateDropdownValue(field: 'couponFrequency', value: value),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: formProvider.selectedDaysPerYear,
                            decoration: const InputDecoration(labelText: 'Días por Año', border: OutlineInputBorder()),
                            items: formProvider.daysPerYearOptions.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
                            onChanged: (value) => formProvider.updateDropdownValue(field: 'daysPerYear', value: value),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: formProvider.selectedInterestRateType,
                            decoration: const InputDecoration(labelText: 'Tipo de Tasa', border: OutlineInputBorder()),
                            items: formProvider.interestRateTypeOptions.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
                            onChanged: (value) => formProvider.updateDropdownValue(field: 'interestRateType', value: value),
                          ),
                        ),
                      ],
                    ),
                    if (formProvider.selectedInterestRateType == 'Nominal') ...[
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: formProvider.selectedCapitalization,
                        decoration: const InputDecoration(labelText: 'Capitalización', border: OutlineInputBorder()),
                        hint: const Text('Seleccionar'),
                        items: formProvider.capitalizationOptions.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
                        onChanged: (value) => formProvider.updateDropdownValue(field: 'capitalization', value: value),
                      ),
                    ],
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: formProvider.issueDateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Fecha de Emisión',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () {
                        context.read<BondFormProvider>().selectIssueDate(context);
                      },
                    ),
                     const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: TextFormField(controller: formProvider.interestRateController, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Tasa de Interés (%)', border: OutlineInputBorder()))),
                        const SizedBox(width: 16),
                        Expanded(child: TextFormField(controller: formProvider.annualDiscountRateController, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Tasa de Descuento (%)', border: OutlineInputBorder()))),
                      ],
                    ),
                     const SizedBox(height: 16),
                    TextFormField(controller: formProvider.incomeTaxController, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Impuesto a la Renta (%)', border: OutlineInputBorder())),
                  ],
                ),

                _buildSectionCard(
                  context: context,
                  title: 'Costos y Gastos Iniciales (%)',
                  children: [
                    _buildCostRow(formProvider, 'primaPayer', formProvider.initialCostPercentController, '% Prima', formProvider.selectedPrimaPayer),
                    const SizedBox(height: 16),
                    _buildCostRow(formProvider, 'estructuracionPayer', formProvider.structuringCostPercentController, '% Estructuración', formProvider.selectedEstructuracionPayer),
                    const SizedBox(height: 16),
                    _buildCostRow(formProvider, 'colocacionPayer', formProvider.placementCostPercentController, '% Colocación', formProvider.selectedColocacionPayer),
                    const SizedBox(height: 16),
                    _buildCostRow(formProvider, 'flotacionPayer', formProvider.flotationCostPercentController, '% Flotación', formProvider.selectedFlotacionPayer),
                    const SizedBox(height: 16),
                    _buildCostRow(formProvider, 'cavaliPayer', formProvider.cavaliCostPercentController, '% CAVALI', formProvider.selectedCavaliPayer),
                  ],
                ),

                _buildSectionCard(
                  context: context,
                  title: 'Periodo de Gracia',
                  children: [
                     Row(
                       children: [
                         Expanded(
                           child: DropdownButtonFormField<String>(
                            value: formProvider.selectedGracePeriodType,
                            decoration: const InputDecoration(labelText: 'Tipo de Gracia', border: OutlineInputBorder()),
                            items: formProvider.gracePeriodTypeOptions.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
                            onChanged: (value) => formProvider.updateDropdownValue(field: 'gracePeriodType', value: value),
                           ),
                         ),
                         const SizedBox(width: 16),
                         Expanded(child: TextFormField(controller: formProvider.gracePeriodPeriodsController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Nº Periodos de Gracia', border: OutlineInputBorder()))),
                       ],
                     ),
                  ],
                ),
                
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: formProvider.isLoading ? null : () async {
                    final userId = authProvider.firebaseUser?.uid;
                    if (userId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error: No se pudo identificar al usuario.')));
                      return;
                    }
                    final success = await context.read<BondFormProvider>().calculateAndSaveBond(context, userId);
                    if (success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Operación guardada con éxito.'), backgroundColor: Colors.green));
                      Navigator.pushNamed(context, 'resultsScreen');
                    } else if (!success && context.mounted) {
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al guardar la operación.'), backgroundColor: Colors.red));
                    }
                  },
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
                  child: formProvider.isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Calcular y Guardar', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }

  Widget _buildSectionCard({required BuildContext context, required String title, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildCostRow(BondFormProvider provider, String fieldName, TextEditingController controller, String label, String? selectedValue) {
    return Row(
      children: [
        Expanded(flex: 2, child: TextFormField(controller: controller, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()))),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            decoration: const InputDecoration(labelText: 'Pagado por', border: OutlineInputBorder()),
            items: provider.costPayerOptions.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
            onChanged: (value) => provider.updateDropdownValue(field: fieldName, value: value),
          ),
        ),
      ],
    );
  }
}
