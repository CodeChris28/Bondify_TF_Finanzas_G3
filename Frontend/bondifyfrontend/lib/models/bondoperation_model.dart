class BondOperation{
  final int id;
  final String operationname;
  final String bondmethod;
  final String currency;
  final String interestratetype;
  final String capitalizationperiod;
  final String gracePeriodType;
  final String gracePeriodStartDate;
  final String gracePeriodEndDate;

  BondOperation({
  required this.id,
  required this.operationname,
  required this.bondmethod,
  required this.currency,
  required this.interestratetype,
  required this.capitalizationperiod,
  required this.gracePeriodType,
  required this.gracePeriodStartDate,
  required this.gracePeriodEndDate
});
}
