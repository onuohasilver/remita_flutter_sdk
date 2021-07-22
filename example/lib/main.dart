import 'dart:math';
import 'package:flutter/material.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/beneficiary.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/customFields.dart';
import 'package:remita_flutter_sdk/remita_flutter_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Remita SDK Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RemitaHandler remitaHandler =
      RemitaHandler(merchantID: '2547916', apiKey: '1946');
  bool loading = false;
  String result = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height * .4,
              width: width * .8,
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Query Results',
                  ),
                  loading
                      ? Center(child: CircularProgressIndicator())
                      : Text(result)
                ],
              ),
            ),
            Flexible(
              child: Container(
                height: height * .1,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          remitaHandler
                              .generateRRR(
                                  serviceID: '4430731',
                                  amount: '20200',
                                  orderID: getRandomString(5),
                                  payerName: 'Ali Nuhu',
                                  payerEmail: 'alinuhu@gmail.com',
                                  payerPhone: '08032773333',
                                  description: 'Coffee')
                              .then((value) => setState(() {
                                    result = value.toString();
                                    loading = false;
                                  }));
                        },
                        child: Container(
                          color: Colors.deepOrange,
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Generate RRR',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          remitaHandler
                              .generateRRR(
                                  serviceID: '4430731',
                                  amount: '20200',
                                  orderID: getRandomString(5),
                                  payerName: 'Ali Nuhu',
                                  payerEmail: 'alinuhu@gmail.com',
                                  payerPhone: '08032773333',
                                  customFields: [
                                    CustomField(
                                        value: '1234567890',
                                        name: 'Payer TIN',
                                        type: 'ALL')
                                  ],
                                  description: 'Coffee')
                              .then((value) => setState(() {
                                    result = value.toString();
                                  }));
                        },
                        child: Container(
                          color: Colors.deepOrange,
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Generate RRR with Custom Fields',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          remitaHandler
                              .generateRRR(
                                  serviceID: '4430731',
                                  amount: '20200',
                                  orderID: getRandomString(5),
                                  payerName: 'Ali Nuhu',
                                  payerEmail: 'alinuhu@gmail.com',
                                  payerPhone: '08032773333',
                                  lineItems: [
                                    Beneficiary(
                                        linesItemId: 'itemid1',
                                        beneficiaryName: 'Alozie Michael',
                                        beneficiaryAccount: '6020067886',
                                        bankCode: '058',
                                        beneficiaryAmount: '20000',
                                        deductFeeFrom: '1'),
                                    Beneficiary(
                                        linesItemId: 'itemid2',
                                        beneficiaryName: 'Folivi Joshua',
                                        beneficiaryAccount: '0360883515',
                                        bankCode: '058',
                                        beneficiaryAmount: '200',
                                        deductFeeFrom: '0')
                                  ],
                                  description: 'Coffee')
                              .then((value) => setState(() {
                                    result = value.toString();
                                    loading = false;
                                  }));
                        },
                        child: Container(
                          color: Colors.deepOrange,
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Generate RRR with Split Payment',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });

                          remitaHandler
                              .generateRRR(
                                  serviceID: '4430731',
                                  amount: '20200',
                                  orderID: 'xxsxa',
                                  payerName: 'Ali Nuhu',
                                  payerEmail: 'alinuhu@gmail.com',
                                  payerPhone: '08032773333',
                                  lineItems: [
                                    Beneficiary(
                                        linesItemId: 'itemid1',
                                        beneficiaryName: 'Alozie Michael',
                                        beneficiaryAccount: '6020067886',
                                        bankCode: '058',
                                        beneficiaryAmount: '20000',
                                        deductFeeFrom: '1'),
                                    Beneficiary(
                                        linesItemId: 'itemid2',
                                        beneficiaryName: 'Folivi Joshua',
                                        beneficiaryAccount: '0360883515',
                                        bankCode: '058',
                                        beneficiaryAmount: '200',
                                        deductFeeFrom: '0')
                                  ],
                                  description: 'Coffee')
                              .then((value) => setState(() {
                                    result = value.toString();
                                    loading = false;
                                  }));
                        },
                        child: Container(
                          color: Colors.deepOrange,
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Generate RRR with Split Payment',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
