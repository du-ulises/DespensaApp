import 'package:despensaapp/Client/repository/firebase_auth_api.dart';
import 'package:despensaapp/Product/model/product.dart';
import 'package:despensaapp/Wallet/ui/widgets/card/chip.dart';
import 'package:despensaapp/Wallet/ui/widgets/card/last_number.dart';
import 'package:despensaapp/Wallet/ui/widgets/card/logo.dart';
import 'package:despensaapp/Wallet/ui/widgets/card/number.dart';
import 'package:despensaapp/Wallet/ui/widgets/card/owner.dart';
import 'package:despensaapp/Wallet/ui/widgets/card/valid_thru.dart';
import 'package:despensaapp/Wallet/ui/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:despensaapp/Client/services/payment-service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:despensaapp/Wallet/models/card_model.dart';
import 'package:despensaapp/Wallet/blocs/card_list_bloc.dart';

class ExistingCardsPage extends StatefulWidget {
  double total;
  String uid;
  List<Product> productsInShoppingCart;
  ExistingCardsPage({Key key, this.total, this.uid, this.productsInShoppingCart}) : super(key: key);


  ExistingCardsPageState createState() => ExistingCardsPageState();
}

class ExistingCardsPageState extends State<ExistingCardsPage> {
  final FirebaseAuthAPI _userRepository = FirebaseAuthAPI();
  bool _isElegance = false;
  final Color darkColor =  Color(0xFF212121);
  final Color lightColor = Color(0xFFF4F8FF);

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
    getSharedPrefs();
  }

  List cards = [
    {
      'cardNumber': '4242424242424242',
      'expiryDate': '04/24',
      'cardHolderName': 'Diego Ulises Martínez',
      'cvvCode': '424',
      'showBackView': false,
    },
    {
      'cardNumber': '5555555566554444',
      'expiryDate': '04/23',
      'cardHolderName': 'Tracer',
      'cvvCode': '123',
      'showBackView': false,
    }
  ];

  payViaExistingCard(BuildContext context, card) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Por favor espera...', messageTextStyle: TextStyle(
        fontFamily: 'Poppins-Medium'),);
    await dialog.show();
    var expiryArr = card['expiryDate'].split('/');
    CreditCard stripeCard = CreditCard(
      number: card['cardNumber'],
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]),
    );
    var totalAmount = ((widget.total*100).toInt()).toString();
    print("TOTAL AMOUNT: "+totalAmount);
    var response = await StripeService.payViaExistingCard(
        amount: totalAmount, currency: 'MXN', card: stripeCard);
    print(response.success);
    if(response.success){
      _userRepository.clearShoppingCart(widget.uid, widget.productsInShoppingCart);
    }
    await dialog.hide();
    Scaffold.of(context)
        .showSnackBar(SnackBar(
          content: Text(response.message),
          duration: new Duration(milliseconds: 1200),
        ))
        .closed
        .then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: Navbar(
        appBarTitle: 'Seleccione una tarjeta',
        leading: Icons.clear,
        context: context,
        isElegance: _isElegance,
      ),
      body: StreamBuilder<List<CardResults>>(
        stream: cardListBloc.cardList,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              !snapshot.hasData
                  ? Expanded(child: Center(child: CircularProgressIndicator()))
                  : Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      SizedBox(
                        height: _screenSize.height * 0.75,
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: <Widget>[
                                Container(
                                  width: screenWidth,
                                  height: screenHeight,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      gradient: LinearGradient(
                                          colors: [
                                            snapshot.data[index].color,
                                            snapshot.data[index].color
                                          ],
                                          begin: FractionalOffset(0.2, 0.0),
                                          end: FractionalOffset(1.0, 0.6),
                                          stops: [0.0, 0.6],
                                          tileMode: TileMode.clamp)),
                                  child: FittedBox(
                                    fit: BoxFit.none,
                                    alignment: Alignment(-1.5, -0.8),
                                    child: Container(
                                      width: screenHeight,
                                      height: screenHeight,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(0, 0, 0, 0.05),
                                          borderRadius: BorderRadius.circular(
                                              screenHeight / 2)),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    payViaExistingCard(context, {
                                      'cardNumber': snapshot.data[index].number,
                                      'expiryDate': snapshot.data[index].month +
                                          '/' +
                                          snapshot.data[index].year,
                                      'cardHolderName':
                                          snapshot.data[index].name,
                                      'cvvCode': snapshot.data[index].cvv,
                                      'showBackView': false,
                                    });
                                  },
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        CardLogo(
                                            type: snapshot.data[index].type),
                                        CardChip(),
                                        CardNumber(
                                            number:
                                                snapshot.data[index].number),
                                        CardLastNumber(
                                            number:
                                                snapshot.data[index].number),
                                        CardValidThru(
                                            month: snapshot.data[index].month,
                                            year: snapshot.data[index].year),
                                        CardOwner(
                                            name: snapshot.data[index].name),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: snapshot.data.length,
                          itemWidth: _screenSize.width * 0.65,
                          itemHeight: _screenSize.height * 0.5,
                          layout: SwiperLayout.STACK,
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        child: Text(
                          'Métodos de pago seguros y convenientes con Stripe.',
                          style: TextStyle(
                              fontFamily: 'Poppins-Medium', fontSize: 15),textAlign: TextAlign.center,
                        ),
                      )
                    ]),
            ],
          );
        },
      ),
      /*child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (BuildContext context, int index) {
                  var card = cards[index];
                  return InkWell(
                    onTap: () {
                      payViaExistingCard(context, card);
                    },
                    child: CreditCardWidget(
                      cardNumber: card['cardNumber'],
                      expiryDate: card['expiryDate'],
                      cardHolderName: card['cardHolderName'],
                      cvvCode: card['cvvCode'],
                      showBackView: false,
                      cardBgColor: Colors.black,
                    ),
                  );
                },
              ),*/
    );
  }
}
