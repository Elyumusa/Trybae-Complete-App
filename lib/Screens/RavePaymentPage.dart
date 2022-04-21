import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:flutterwave/utils/flutterwave_constants.dart';
import 'package:flutterwave/utils/flutterwave_currency.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RavePaymentPage extends StatefulWidget {
  final paymentPayload;

  const RavePaymentPage({Key key, this.paymentPayload}) : super(key: key);
  @override
  _RavePaymentPageState createState() => _RavePaymentPageState();
}

class _RavePaymentPageState extends State<RavePaymentPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  final String txref = "My_unique_transaction_reference_123";
  final String amount = "200";
  final String currency = FlutterwaveCurrency.ZMW;
  List paymentMethods = [];
  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: WebView(
              initialUrl: 'about:blank',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) async {
                _controller = controller;
                final jsonResponse = widget.paymentPayload;
                _controller.loadUrl(
                  "https://developer.tingg.africa/checkout/v2/express/?accessKey=${jsonResponse['accessKey']}&params=${jsonResponse['params']}&countryCode=${jsonResponse['countryCode']}", /*Uri.dataFromString(tinggExpressCheckoutpage,
                        //'<script src="https://developer.tingg.africa/checkout/v2/tingg-checkout.js"></script><button class="awesome-checkout-button"></button><script type="text/javascript">const payload = {"merchantTransactionID": "1e4r4342i095jf","requestAmount": "100.50","currencyCode": "ZMW","accountNumber": "ACC12345","serviceCode": "E-CDEV6118","dueDate": "2021-06-28 18:50:20","requestDescription": "Getting E-Commerce service","countryCode": "ZM","customerFirstName": "John","customerLastName": "Smith","MSISDN": "260955363160","customerEmail": "elyuedu4@gmail.com","successRedirectUrl": "https://success.com","failRedirectUrl": "https://failed.com","paymentWebhookUrl":"https://hooks.slack.com/services/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"};const checkoutType = "modal"; // or "modal"// Render the checkout buttonTingg.renderPayButton({className: "awesome-checkout-button", checkoutType});document.querySelector(".awesome-checkout-button").addEventListener("click", function() {//Call the encryption URL to encrypt the params and render checkoutfunction encrypt() {return fetch("http://127.0.0.1:8000/trybaePaymentEncryption/",{method: "POST",body: JSON.stringify(payload),mode:"cors"}).then(response => response.json())            }encrypt().then(response => {                    // Render the checkout page on click event    Tingg.renderCheckout({checkoutType,merchantProperties: response,});}).catch(error => console.log(error));});</script>',
                        mimeType: 'text/html',
                        encoding: Encoding.getByName('utf-8'))
                    .toString()*/
                );
              }),
        ),
      ),
    );

    /*return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              child: Text('Pay'),
              onPressed: () async {
                await letsSee();
              },
            ),
          ),
          if (paymentMethods.isNotEmpty)
            ...paymentMethods.map((e) => Text('${e['clientLogo']}')).toList()
        ],
      ),
    );
  */
  }

  String get initialUrl =>
      'data:text/html;base64,${base64Encode(Utf8Encoder().convert(tinggExpressCheckoutpage))}';
  String tinggExpressCheckoutpage =
      '''<script src="https://developer.tingg.africa/checkout/v2/tingg-checkout.js"></script>

<button class="awesome-checkout-button"></button>

<script type="text/javascript">
const payload = {
            "merchantTransactionID": "1e4r4342i095jf",
            "requestAmount": '100.50',
            "currencyCode": "ZMW",
            "accountNumber": "ACC12345",
            "serviceCode": "E-CDEV6118",
            "dueDate": "2021-06-28 18:50:20",
            "requestDescription": "Getting E-Commerce service",
            "countryCode": "ZM",
            "customerFirstName": "John",
            "customerLastName": "Smith",
            "MSISDN": '260955363160',
            "customerEmail": "elyuedu4@gmail.com",
            'successRedirectUrl': "https://success.com",
            'failRedirectUrl': 'https://failed.com',
            "paymentWebhookUrl":
                "https://hooks.slack.com/services/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"
          };
const checkoutType = 'modal'; // or 'modal'

// Render the checkout button
Tingg.renderPayButton({
    className: 'awesome-checkout-button', 
    checkoutType
});

document
.querySelector('.awesome-checkout-button')
.addEventListener('click', function() {
    
            //Call the encryption URL to encrypt the params and render checkout
            function encrypt() {
                return fetch(
                    "http://127.0.0.1:8000/trybaePaymentEncryption/",
                    {
                        method: 'POST',
                        body: JSON.stringify(payload),
                        mode:'cors'
                    }).then(response => response.json())
            }
            encrypt().then(response => {
                    // Render the checkout page on click event
                    Tingg.renderCheckout({
                        checkoutType,
                        merchantProperties: response,
                    });
                }
            )
                .catch(error => console.log(error));
        });
</script>''';

  letsSee() async {
    http.Response response = await http.post(
        Uri.parse(
            'https://developer.tingg.africa/checkout/v2/custom/oauth/token'),
        body: {
          "grant_type": 'client_credentials',
          "client_id": "a0c42aac-348e-40ae-a378-4f2a25b2d835",
          "client_secret": "fJaVgAZF0i5TZazuw8jAhm3CkpLWPrQMWCL3TQUc"
        });
    //jsonDecode(response.body);
    print('response body: ${jsonDecode(response.body)['access_token']}');
    http.Response secResponse = await http.post(
        Uri.parse(
            'https://developer.tingg.africa/checkout/v2/custom/requests/initiate'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${jsonDecode(response.body)['access_token']}'
        },
        body: jsonEncode(
          <String, String>{
            "merchantTransactionID": "1e4r4342i095jf",
            "requestAmount": '100.50',
            "currencyCode": "ZMW",
            "accountNumber": "ACC12345",
            "serviceCode": "E-CDEV6118",
            "dueDate": "2021-06-28 18:50:20",
            "requestDescription": "Getting E-Commerce service",
            "countryCode": "ZM",
            "customerFirstName": "John",
            "customerLastName": "Smith",
            "MSISDN": '260955363160',
            "customerEmail": "elyuedu4@gmail.com",
            'successRedirectUrl': "https://success.com",
            'failRedirectUrl': 'https://failed.com',
            "paymentWebhookUrl":
                "https://hooks.slack.com/services/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"
          },
        ));
    setState(() {
      paymentMethods =
          jsonDecode(secResponse.body)['results']['paymentOptions'];
    });
    print(
        'secResponse: ${jsonDecode(secResponse.body)['results']['paymentOptions']}');
  }

  beginPayment() async {
    print('we are here');

    final Flutterwave flutterwave = Flutterwave.forUIPayment(
        context: this.context,
        encryptionKey: "FLWSECK_TEST2a23d4c6a567",
        publicKey: "FLWPUBK_TEST-07a0f1e2460fd8782034ee7136ceab3f-X",
        currency: this.currency,
        amount: this.amount,
        email: "valid@email.com",
        fullName: "Valid Full Name",
        txRef: this.txref,
        isDebugMode: true,
        phoneNumber: "0955363160",
        acceptCardPayment: true,
        acceptUSSDPayment: false,
        acceptAccountPayment: false,
        acceptFrancophoneMobileMoney: false,
        acceptGhanaPayment: false,
        acceptMpesaPayment: false,
        acceptRwandaMoneyPayment: true,
        acceptUgandaPayment: false,
        acceptZambiaPayment: true);

    try {
      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();
      if (response != null) {
        print(
            " user didn't complete the transaction. Payment wasn't successful.");
        this.showLoading(response.data.status);
      } else {
        final isSuccessful = checkPaymentIsSuccessful(response);
        if (isSuccessful) {
          print(' provide value to customer, the payment was successful');
        } else {
          // check message
          print(response.message);

          // check status
          print(response.status);

          // check processor error
          print(response.data.processorResponse);
          this.showLoading("No Response!");
        }
      }
    } catch (error, stacktrace) {
      // handleError(error);
      print('error: $stacktrace');
    }
  }

  bool checkPaymentIsSuccessful(final ChargeResponse response) {
    return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data.currency == this.currency &&
        response.data.amount == this.amount &&
        response.data.txRef == this.txref;
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: this.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }
}
