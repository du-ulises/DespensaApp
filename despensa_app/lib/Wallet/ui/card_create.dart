import 'package:despensaapp/Wallet/ui/app.dart';
import 'package:flutter/material.dart';
import '../ui/widgets/navbar.dart';
import '../ui/widgets/flip_card.dart';
import '../ui/widgets/card_front.dart';
import '../ui/widgets/card_back.dart';
import '../helpers/card_colors.dart';
import '../helpers/formatters.dart';
import '../blocs/card_bloc.dart';
import '../blocs/bloc_provider.dart';
import '../models/card_color_model.dart';

class CardCreate extends StatefulWidget {
  @override
  _CardCreateState createState() => _CardCreateState();
}

class _CardCreateState extends State<CardCreate> {
  final GlobalKey<FlipCardState> animatedStateKey = GlobalKey<FlipCardState>();

  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    animatedStateKey.currentState.toggleCard();
  }

  @override
  Widget build(BuildContext context) {
    final CardBloc bloc = BlocProvider.of<CardBloc>(context);

    final _creditCard = Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Card(
        color: Colors.grey[100],
        elevation: 0.0,
        margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
        child: FlipCard(
          key: animatedStateKey,
          front: CardFront(rotatedTurnsValue: 0),
          back: CardBack(),
        ),
      ),
    );
    final style = TextStyle(fontFamily: "Poppins-Light",
        fontWeight: FontWeight.bold);
    final _name = StreamBuilder(
        stream: bloc.name,
        builder: (context, snapshot) {
          return TextField(
            textCapitalization: TextCapitalization.characters,
            onChanged: bloc.changeName,
            keyboardType: TextInputType.text,
            style: TextStyle(
                fontSize: 15.0,
                fontFamily: "Gilroy-Light",
                color: Color(0xFF2E3748),
                fontWeight: FontWeight.bold,
                letterSpacing: 2
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 18, top: 10),
              hintText: 'Nombre del titular',
              fillColor: Color(0xFFFFFFFF),
              filled: true,
              border: InputBorder.none,
              errorText: snapshot.error,
              errorStyle: style,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC42036),width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
            ),
          );
        });

    final _number = Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: StreamBuilder(
          stream: bloc.number,
          builder: (context, snapshot) {
            return TextField(
              onChanged: bloc.changeNumber,
              keyboardType: TextInputType.number,
              maxLength: 19,
              maxLengthEnforced: true,
              inputFormatters: [
                MaskedTextInputFormatter(
                  mask: 'xxxx xxxx xxxx xxxx',
                  separator: ' ',
                ),
              ],
              style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "Gilroy-Light",
                  color: Color(0xFF2E3748),
                  fontWeight: FontWeight.bold,
                letterSpacing: 2
              ),
              decoration: InputDecoration(

                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Número de tarjeta',
                  counterText: '',
                  errorText: snapshot.error,
                errorStyle: style,
                contentPadding: EdgeInsets.only(left: 18, top: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC42036),width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),),
            );
          }),
    );

    final _month = StreamBuilder(
      stream: bloc.month,
      builder: (context, snapshot) {
        return Container(
          width: 85.0,
          child: TextField(
            onChanged: bloc.changeMonth,
            keyboardType: TextInputType.number,
            maxLength: 2,
            maxLengthEnforced: true,

            style: TextStyle(
                fontSize: 15.0,
                fontFamily: "Gilroy-Light",
                color: Color(0xFF2E3748),
                fontWeight: FontWeight.bold,
                letterSpacing: 2
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hintText: 'MM',
                counterText: '',
                errorText: snapshot.error,
              errorStyle: style,
              contentPadding: EdgeInsets.only(left: 18, top: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC42036),width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),),
          ),
        );
      },
    );

    final _year = StreamBuilder(
        stream: bloc.year,
        builder: (context, snapshot) {
          return Container(
            width: 120.0,
            child: TextField(
              onChanged: bloc.changeYear,
              keyboardType: TextInputType.number,
              maxLength: 4,
              maxLengthEnforced: true,

              style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "Gilroy-Light",
                  color: Color(0xFF2E3748),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'YYYY',
                  counterText: '',
                  errorText: snapshot.error,
                errorStyle: style,
                contentPadding: EdgeInsets.only(left: 18, top: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC42036),width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),),
            ),
          );
        });

    final _cvv = StreamBuilder(
        stream: bloc.cvv,
        builder: (context, snapshot) {
          return Container(
            width: 85.0,
            child: TextField(
              focusNode: _focusNode,
              onChanged: bloc.changeCvv,
              keyboardType: TextInputType.number,
              maxLength: 3,
              maxLengthEnforced: true,

              style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "Gilroy-Light",
                  color: Color(0xFF2E3748),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  counterText: '',
                  hintText: 'CVV',
                  errorText: snapshot.error,
                errorStyle: style,
                contentPadding: EdgeInsets.only(left: 18, top: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC42036),width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),),
            ),
          );
        });

    final _saveCard = StreamBuilder(
      stream: bloc.saveCardValid,
      builder: (context, snapshot) {
        return Container(
          width: MediaQuery.of(context).size.width - 40,
          child: RaisedButton(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'Guardar Tarjeta',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins-SemiBold",
              ),
            ),
            color: Color(0xFFC42036),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            highlightElevation: 10,
            splashColor: Colors.white70,
            onPressed: snapshot.hasData
                ? () {
                    print("SAVED - SNAPSHOT HAS DATA");
                    var blocProviderCardWallet = BlocProvider(
                      bloc: bloc,
                      child: Container(), // CardWallet()
                    );
                    /*
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => blocProviderCardWallet));*/
                    bloc.saveCard();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                : null,
          ),
        );
      },
    );

    return new Scaffold(
        appBar: Navbar(
          appBarTitle: 'Crear tarjeta',
          leading: Icons.arrow_back,
          context: context,
        ),
        backgroundColor: Colors.grey[100],
        body: ListView(
          itemExtent: 750.0,
          padding: EdgeInsets.only(top: 10.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: _creditCard,
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 8.0),
                        _name,
                        _number,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _month,
                            SizedBox(width: 12.0),
                            _year,
                            SizedBox(width: 12.0),
                            _cvv,
                          ],
                        ),
                        SizedBox(height: 30.0),
                        cardColors(bloc),
                        SizedBox(height: 30.0),
                        _saveCard,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget cardColors(CardBloc bloc) {
    final dotSize =
        (MediaQuery.of(context).size.width - 150) / CardColor.baseColors.length;

    List<Widget> dotList = new List<Widget>();

    for (var i = 0; i < CardColor.baseColors.length; i++) {
      dotList.add(
        StreamBuilder<List<CardColorModel>>(
          stream: bloc.cardColorsList,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: GestureDetector(
                onTap: () => bloc.selectCardColor(i),
                child: Container(
                  child: snapshot.hasData
                      ? snapshot.data[i].isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12.0,
                            )
                          : Container()
                      : Container(),
                  width: dotSize,
                  height: dotSize,
                  decoration: new BoxDecoration(
                    color: CardColor.baseColors[i],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: dotList,
    );
  }
}
