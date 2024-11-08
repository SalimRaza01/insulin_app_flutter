import 'package:flutter/material.dart';
import 'package:newproject/utils/Drawer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BuySubscription extends StatefulWidget {
  const BuySubscription({super.key});

  @override
  State<BuySubscription> createState() => BuySubscriptionState();
}

class BuySubscriptionState extends State<BuySubscription> {
  late Razorpay razorpay;
  TextEditingController discountController = TextEditingController();

  String? discount;
  String subscriptionPrice = '25000';
  String totalValue = '25000';

  @override
  void initState() {
    razorpay = Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);

    super.initState();
  }

void openCheckout() {
    var options = {
      "key": "rzp_test_X7gVsWi07TXZ35",
      "amount": num.parse(totalValue) * 100,
      "name": "InsuLink",
      "description": "Payment for some random product",
      "prefill": {"contact": "2222222222", "email": "sssdd@gmail.com"},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    // print("Payment success");
    // Toast.show("Payment success", context);
  }

  void handlerErrorFailure() {
    // print("Payment error");
    // Toast.show("Payment error", context);
  }

  void handlerExternalWallet() {
    // print("External Wallet");
    // Toast.show("External Wallet", context);
  }


  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }


  void totalAmount() {
    if (discountController.text == 'FIRSTORDER') {
      discount = '50';
    } else if (discountController.text == 'AGVA30') {
      discount = '30';
    } else if (discountController.text == 'AGVA15') {
      discount = '15';
    } else if (discountController.text.isEmpty) {
      discount = null;
    } else if (discountController.text.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Invalid Coupon'),
                ],
              ),
            ),
            actions: [],
          );
        },
      );
    }

    setState(() {
      double subscription = double.parse(subscriptionPrice);
      double discountPercentage =
          (discount != null) ? double.parse(discount.toString()) : 0;
      double discountAmount = subscription * (discountPercentage / 100);
      double total = subscription - discountAmount;
      totalValue = total.toStringAsFixed(2);

      print('discounted amount $discountAmount');
    });
  }

  bool show = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        
  drawer: AppDrawerNavigation('PAYMENT'),

        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
                   iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'BUY',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
          
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border:
                        Border.all(color: Theme.of(context).colorScheme.secondaryContainer, width: 0.2)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Image.asset('assets/images/Insulin.png', height: height * 0.04,),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Insulin Subscription',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primaryContainer,
                                fontWeight: FontWeight.w500,
                                fontSize: height * 0.018),
                          ),
                          Text(
                            'Rs. $subscriptionPrice',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: height * 0.015,
                                color: Theme.of(context).colorScheme.primaryContainer),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //payment box
            Container(
              height: height * 0.35,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Have you any Discount?',
                     
                      style: TextStyle(fontSize: height * 0.015,color:  Theme.of(context).colorScheme.primaryContainer,),
                    ),
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Theme.of(context).colorScheme.onPrimary),
                          width: width,
                          height: height * 0.05,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextField(
                              controller: discountController,
                              style: TextStyle(
                                  fontSize: height * 0.015,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                border: InputBorder.none,
                                hintText: 'Enter Coupon',
                                hintStyle: TextStyle(
                                    fontSize: height * 0.015,
                                    fontWeight: FontWeight.w400),
                              ),
                              // Set the keyboard type to number
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                                       totalAmount();
                            },
                            child: Container(
                                              
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Theme.of(context).colorScheme.secondary),
                              child: Padding(
                                padding:  EdgeInsets.all(10),
                                child: Text(
                                  'Apply',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height * 0.014,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Color.fromARGB(97, 158, 158, 158),
                      height: height * 0.001,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  fontSize: height * 0.015),
                            ),
                            if (discount == null)
                              SizedBox(
                                height: 1,
                              )
                            else
                              Text(
                                'Discount',
                                style: TextStyle(
                                    color: Colors.green[800],
                                    fontSize: height * 0.015),
                              ),
                            Text(
                              'Total',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                     color: Theme.of(context).colorScheme.primaryContainer,
                                  fontSize: height * 0.015),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Rs.$subscriptionPrice',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  fontSize: height * 0.015),
                            ),
                            if (discount == null)
                              SizedBox(
                                height: 1,
                              )
                            else
                              Text(
                                '-$discount%',
                                style: TextStyle(
                                    color: Colors.green[800],
                                    fontSize: height * 0.015),
                              ),
                            Text(
                              'Rs.$totalValue',
                              style: TextStyle(
                                color: Colors.green[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.015),
                            ),
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                                     openCheckout();
                        },
                        child: Container(
                                        
                          decoration: BoxDecoration(
                              borderRadius:
                                  new BorderRadius.all(new Radius.circular(5)),
                              color:Theme.of(context).colorScheme.onSecondary),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'CONTINUE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
