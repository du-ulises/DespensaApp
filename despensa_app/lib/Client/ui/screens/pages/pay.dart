import 'package:despensaapp/Client/ui/screens/pages/existing-cards.dart';
import 'package:flutter/material.dart';
import 'package:despensaapp/Client/services/payment-service.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Pay extends StatefulWidget {
  Pay({Key key}) : super(key: key);

  @override
  PayState createState() => PayState();
}

class PayState extends State<Pay> {
  onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        payViaNewCard(context);
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return ExistingCardsPage();
          }),
        );
        break;
    }
  }

  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Por favor espera...');
    await dialog.show();
    var response =
        await StripeService.payWithNewCard(amount: '300', currency: 'USD');
    await dialog.hide();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration:
          new Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return ExistingCardsPage();
          }),
        );
      },
      child: ListTile(
        title: Text(
          'Pagar con tarjeta existente.',
          style: TextStyle(
              fontSize: 18.0,
              fontFamily: "Poppins-Medium",
              color: Colors.white
          ),
          textAlign: TextAlign.center,
        ),
        leading: Icon(Icons.credit_card, color: Colors.white),
      ),
    );
  }
}
