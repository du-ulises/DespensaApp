import 'package:despensaapp/Client/ui/screens/pages/existing-cards.dart';
import 'package:despensaapp/widgets/button_outline.dart';
import 'package:despensaapp/widgets/button_purple.dart';
import 'package:flutter/material.dart';
import 'package:despensaapp/Client/services/payment-service.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        await StripeService.payWithNewCard(amount: '750', currency: 'MXN');
    await dialog.hide();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration:
          new Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
  }

  final Color darkColor = Color(0xFF212121);
  final Color lightColor = Color(0xFFF4F8FF);

  bool _isElegance = false;

  Future<Null> getSharedPrefs() async {
    SharedPreferences theme = await SharedPreferences.getInstance();
    bool isElegance = (theme.getBool("Elegance") ?? false);
    setState(() {
      _isElegance = isElegance;
    });
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return _isElegance
        ? ButtonOutline(
            buttonText: "Pagar con tarjeta existente.",
            iconText: Icon(Icons.credit_card, color: Colors.white),
            widthButton: 300.0,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return ExistingCardsPage();
                }),
              );
            })
        : ButtonPurple(
            buttonText: "Pagar con tarjeta existente.",
            iconText: Icon(Icons.credit_card, color: Colors.white),
            widthButton: 300.0,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return ExistingCardsPage();
                }),
              );
            });
  }
}
