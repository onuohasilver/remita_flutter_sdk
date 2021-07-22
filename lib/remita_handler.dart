abstract class RemitaHandler {
  final String merchantID;
  final String apiKey;
  final bool demo;

  RemitaHandler({
    required this.merchantID,
    required this.apiKey,
    required this.demo,
  });

  @override
  String toString() {
    return 'MerchantID: $merchantID , ApiKey: $apiKey';
  }
}
