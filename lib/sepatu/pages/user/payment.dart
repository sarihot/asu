
import 'package:asu/sepatu/pages/user/success.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int value = 0;
  final paymentLabels = [
    'Credit card / Debit card',
    'Cash on delivery',
    'Paypal',
    'Google Wallet'
  ];
  final paymentIcons = [
    Icons.credit_card,
    Icons.money_off,
    Icons.payment,
    Icons.account_balance_wallet
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          HeaderLabel(
            headerText: 'Choose your payment method',
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Radio(
                      activeColor: Colors.red,
                      value: index,
                      groupValue: value,
                      onChanged: (i) => setState(() => value = i!),
                    ),
                    title: Text(
                      paymentLabels[index],
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: Icon(
                      paymentIcons[index],
                      color: Colors.red,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: paymentLabels.length),
          ),
          ButtonTheme(
            minWidth: 100.0,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Success()));
              },
              child: Text("Pay"),
            ),
          )
        ],
      ),
    );
  }
}

class HeaderLabel extends StatelessWidget {
  final String headerText;
  const HeaderLabel({Key? key, required this.headerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Text(
        headerText,
        style: TextStyle(color: Colors.grey, fontSize: 28),
      ),
    );
  }
}
