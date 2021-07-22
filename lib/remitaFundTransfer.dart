import 'package:remita_flutter_sdk/remita_handler.dart';

class RemitaFundTransfer extends RemitaHandler {
  final String merchantID, apiKey;
  final bool demo;

  RemitaFundTransfer(
      {required this.merchantID, required this.demo, required this.apiKey})
      : super(merchantID: merchantID, demo: demo, apiKey: apiKey);
}
