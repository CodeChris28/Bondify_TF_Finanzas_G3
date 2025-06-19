class BondInputData {
  final int id;
  final int operationId;
  final double nominalValue;
  final double commercialValue;
  final int numberOfYears;
  final String couponFrequency;
  final int daysPerYear;
  final double interestRate;
  final double annualDiscountRate;
  final double incomeTax;
  final String issueDate;

  BondInputData({
    required this.id,
    required this.operationId,
    required this.nominalValue,
    required this.commercialValue,
    required this.numberOfYears,
    required this.couponFrequency,
    required this.daysPerYear,
    required this.interestRate,
    required this.annualDiscountRate,
    required this.incomeTax,
    required this.issueDate,
  });
}