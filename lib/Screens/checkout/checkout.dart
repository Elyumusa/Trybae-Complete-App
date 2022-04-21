import 'package:TrybaeCustomerApp/Components/BuildPhoneNumberField.dart';
import 'package:TrybaeCustomerApp/Components/BuildTextFormField.dart';
import 'package:TrybaeCustomerApp/Components/DefaultButton.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/Components/product_photo_container.dart';
import 'package:TrybaeCustomerApp/Screens/RavePaymentPage.dart';
import 'package:TrybaeCustomerApp/Screens/authentication/BuildEmailFormField.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../OrderSummaryPage.dart';

String addressInfo = 'Not yet entered address info, please do';
String phone;
String deliveryAddress;
String fname;
String sname;
String email;
var paymentPayload = {
  "merchantTransactionID": '${DateTime.now().millisecondsSinceEpoch}',
  "requestAmount": '600',
  "currencyCode": "ZMW",
  "accountNumber": "ACC12345",
  "serviceCode": "E-CDEV6118",
  "dueDate": "${DateTime.now().add(Duration(hours: 3))}",
  "requestDescription": "Getting E-Commerce service",
  "countryCode": "ZM",
  "customerFirstName": "",
  "customerLastName": "",
  "MSISDN": '',
  "customerEmail": "",
  'successRedirectUrl': "https://success.com",
  'failRedirectUrl': 'https://failed.com',
  "paymentWebhookUrl":
      "https://hooks.slack.com/services/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"
};

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController fnameController = TextEditingController();
  TextEditingController snameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    print('date ${DateTime.now()}');
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                'Check Out',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                '3 items',
                style: TextStyle(color: Colors.black26, fontSize: 15),
              )
            ],
          ),
          elevation: 0,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                size: 35,
                color: Colors.black,
              )),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenWidth(context, 30),
                horizontal: getProportionateScreenWidth(context, 15)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, -15),
                      blurRadius: 20,
                      color: Colors.white.withOpacity(0.6))
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(TextSpan(
                      text: 'Total:\n',
                      style: TextStyle(color: Colors.black45),
                      children: [
                        TextSpan(
                            text: 'K600.98',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold))
                      ])),
                  SizedBox(
                    width: getProportionateScreenWidth(context, 200),
                    child: DefaultButton(
                      onPressed: () async {
                        setState(() {});
                        if (_formkey.currentState.validate()) {
                          _formkey.currentState.save();
                          setState(() {});
                          paymentPayload["customerFirstName"] = fname;
                          paymentPayload["customerLastName"] = sname;
                          paymentPayload["MSISDN"] = phoneController.text;
                          paymentPayload["customerEmail"] = email;
                        }
                        try {
                          Response encResponse = await http.post(
                              Uri.parse(
                                  "http://10.0.2.2:8000/trybaePaymentEncryption/"),
                              body: json.encode(paymentPayload));
                          print('response: ${encResponse.body}');
                          final jsonResponse = jsonDecode(encResponse.body);
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return RavePaymentPage(
                                paymentPayload: jsonResponse,
                              );
                            },
                          ));
                        } catch (e) {
                          print('e $e');
                        }
                      },
                      string: 'Pay Now',
                    ), /*WebView(
                      initialUrl: initialUrl,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (controller) =>
                          _controller = controller,
                    ),*/
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Your Cart',
                            style:
                                TextStyle(color: Colors.black, fontSize: 21)),
                        Text('View all',
                            style: TextStyle(color: Colors.black38))
                      ],
                    ),
                    Container(
                      height: 150,
                      margin: EdgeInsets.symmetric(vertical: 14),
                      child: ListView.builder(
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.only(right: 12),
                              width: 180,
                              child: ProductPhotoContainer(
                                  image: 'images/trybae41.jpg'));
                        },
                      ),
                    ),
                    /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Your Address',
                        style: TextStyle(color: Colors.black, fontSize: 21)),
                    TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel')),
                                  TextButton(
                                      onPressed: () {
                                        if (_formkey.currentState.validate()) {
                                          _formkey.currentState.save();
                                          setState(() {});
                                          paymentPayload["customerFirstName"] =
                                              fname;
                                          paymentPayload["customerLastName"] =
                                              sname;
                                          paymentPayload["MSISDN"] =
                                              phoneController.text;
                                          paymentPayload["customerEmail"] = email;
                
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text('Save'))
                                ],
                                content: Form(
                                  key: _formkey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                          onSaved: (value) {
                                            email = value;
                                          },
                                          autovalidateMode:
                                              AutovalidateMode.onUserInteraction,
                                          keyboardType: TextInputType.phone,
                                          //focusNode: focusNode,
                                          controller: phoneController,
                                          decoration: InputDecoration(
                                            fillColor: Colors.grey,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            hintText: 'Enter Phone Number ',
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 42, vertical: 20),
                                            border: OutlineInputBorder(
                                              //borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            //labelText: 'Phone',
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(
                                                '(+26)',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                          ),
                                          autofocus: true,
                                          validator: validatePhone),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      buildEmailFormField(emailController,
                                          onSaved: (value) {
                                        email = value;
                                      }),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      buildTextFormField('First Name', false,
                                          (value) {
                                        fname = value;
                                      }, fnameController),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      buildTextFormField('Surname', false,
                                          (value) {
                                        sname = value;
                                      }, snameController),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      buildTextFormField('Address', false,
                                          (value) {
                                        deliveryAddress = value;
                                      }, addressController)
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text('Edit Address',
                            style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.normal))),
                  ],
                              ),
                              */
                    fname == null
                        ? Text('Elyumusa Njobvu +260955363160')
                        : Text('fname $sname'),
                    SizedBox(
                      height: 5,
                    ),
                    email == null ? Text('') : Text('$email'),
                    deliveryAddress == null
                        ? Text(
                            "David Kaunda Secondary Sch Teacher's compound Hse no 5")
                        : Text(
                            deliveryAddress,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                    SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery Details',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 21))
                        ],
                      ),
                    ),
                    Text(
                      'Will be received on 07 July 2021 at your doorstep, if more queries will be needed we shall contact you on the number you provided in the Address info section',
                      //maxLines: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                              onSaved: (value) {
                                phone = value;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.phone,
                              //focusNode: focusNode,
                              controller: phoneController,
                              decoration: InputDecoration(
                                fillColor: Colors.grey,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Enter Phone Number ',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 42, vertical: 20),
                                border: OutlineInputBorder(
                                  //borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                //labelText: 'Phone',
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    '(+26)',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              autofocus: true,
                              validator: validatePhone),
                          SizedBox(
                            height: 12,
                          ),
                          buildEmailFormField(emailController,
                              onSaved: (value) {
                            email = value;
                          }),
                          SizedBox(
                            height: 12,
                          ),
                          buildTextFormField('First Name', false, (value) {
                            fname = value;
                          }, fnameController),
                          SizedBox(
                            height: 12,
                          ),
                          buildTextFormField('Surname', false, (value) {
                            sname = value;
                          }, snameController),
                          SizedBox(
                            height: 12,
                          ),
                          buildTextFormField('Address', false, (value) {
                            deliveryAddress = value;
                          }, addressController)
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }

  String get initialUrl =>
      'data:text/html;base64,${base64Encode(Utf8Encoder().convert(tinggExpressCheckoutpage))}';
  String tinggExpressCheckoutpage =
      '''<script src="https://developer.tingg.africa/checkout/v2/tingg-checkout.js"></script>

<button class="awesome-checkout-button"></button>

<script type="text/javascript">
const payload= $paymentPayload
const checkoutType = 'redirect'; // or 'modal'

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
                    ""http://127.0.0.1:8000/trybaePaymentEncryption/"",
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
  String validatePhone(String value) {
    if (value.length < 10) {
      //setState(() {
      return 'Please Enter Valid Phone Number';
      //});
    } else if (value.isEmpty) {
      return 'Phone number field cannot be left empty';
    } else {
      return null;
    }
  }
}
