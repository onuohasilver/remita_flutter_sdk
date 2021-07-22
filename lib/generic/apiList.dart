class RemitaAPI {
  final bool demo;

  ///Collection of the Base APis
  RemitaAPI(this.demo);

  /// The base URL for the live and demo invoice generation APIs
  /// Invoice Generation APIs allow you create payment references
  /// that can be sent to users to make payments in your favor
  get invoiceGenerationBase => demo
      ? 'https://remitademo.net/remita/exapp/api/v1/send/api'
      : 'https://login.remita.net/remita/exapp/api/v1/send/api';

  /// The base URL for the live and demo direct debit Post requests
  /// Direct Debit (or recurrent payment) services will allow you setup
  /// a direct debit agreement between yourself and your customers
  /// that will enable you collect payments recurrently
  get directDebitPostBase => demo
      ? 'https://remitademo.net/remita/exapp/api/v1/send/api'
      : 'https://login.remita.net/remita/exapp/api/v1/send/api/echannelsvc/echannel';

  /// The base URL for the live and demo direct debit Get requests
  get directDebitGetBase => demo
      ? 'https://www.remitademo.net/remita/ecomm'
      : 'https://login.remita.net/remita/ecomm';
}
