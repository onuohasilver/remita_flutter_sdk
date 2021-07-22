abstract class RemitaHandler {
  final String merchantID;
  final String apiKey;

  RemitaHandler({required this.merchantID, required this.apiKey});

  @override
  String toString() {
    return 'MerchantID: $merchantID , ApiKey: $apiKey';
  }
}
