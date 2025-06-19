class GeneralconfigurationModel {
  final int id;
  final String defaultCurrency;
  final String createdAt;
  final String updatedAt;

  GeneralconfigurationModel({
    required this.id,
    required this.defaultCurrency,
    String? createdAt,
    String? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now().toIso8601String().split('T').first,
        updatedAt = updatedAt ?? DateTime.now().toIso8601String().split('T').first;
}