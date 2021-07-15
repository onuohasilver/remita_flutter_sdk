class Beneficiary {
  final String linesItemId,
      beneficiaryName,
      beneficiaryAccount,
      bankCode,
      beneficiaryAmount,
      deductFeeFrom;

  const Beneficiary({
    required this.linesItemId,
    required this.beneficiaryName,
    required this.beneficiaryAccount,
    required this.bankCode,
    required this.beneficiaryAmount,
    required this.deductFeeFrom,
  });
  Map<String, String> get toMap => {
        "lineItemsId": linesItemId,
        "beneficiaryName": beneficiaryName,
        "beneficiaryAccount": beneficiaryAccount,
        "bankCode": bankCode,
        "beneficiaryAmount": beneficiaryAmount,
        "deductFeeFrom": deductFeeFrom
      };

  //TODO: Confirm that deductFeeFrom cannot be programmatically added

  static List<Map>? castList([List<Beneficiary>? beneficiariesList]) {
    List<Map> mappedList = [];
    beneficiariesList?.forEach((element) {
      mappedList.add(element.toMap);
    });
    return mappedList.isEmpty ? null : mappedList;
  }
}
