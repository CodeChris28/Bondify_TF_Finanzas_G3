import 'user_model.dart';
class BondOperation {
  final int id;
  final User user;
  final String operationname;
  final String bondmethod;
  final String currency;
  final String interestratetype;
  final String capitalizationperiod;
  final String gracePeriodType;
  final String gracePeriodStartDate;
  final String gracePeriodEndDate;
  final String createdAt;
  final String updatedAt;

  BondOperation({
    required this.id,
    required this.user,
    required this.operationname,
    required this.bondmethod,
    required this.currency,
    required this.interestratetype,
    required this.capitalizationperiod,
    required this.gracePeriodType,
    required this.gracePeriodStartDate,
    required this.gracePeriodEndDate,
    String? createdAt,
    String? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now().toIso8601String().split('T').first,
        updatedAt = updatedAt ?? DateTime.now().toIso8601String().split('T').first;
}
