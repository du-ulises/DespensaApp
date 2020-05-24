import 'package:despensaapp/Ticket/pages/delivery.dart';
import 'package:flutter/material.dart';
import 'package:despensaapp/Ticket/common/app_bar.dart';
import 'package:despensaapp/Ticket/common/ticket_card.dart';
import 'package:despensaapp/Ticket/common/toggle_widget.dart';
import 'package:despensaapp/Ticket/model/ticket.dart';

class PlaneTicketListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Ticket ticket = Ticket();
    ticket.id = "1";
    ticket.sourceStation = "A";
    ticket.sourceCity = "Salida";
    ticket.departureTime = "15:00pm";
    ticket.destinationStation = "B";
    ticket.destinationCity = "Llegada";
    ticket.arrivalTime = "16:30pm";
    ticket.terminal = "\$1200";
    ticket.game = "F62";
    ticket.boardingTime = "MiniSuper";

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              Hero(tag: ticket.id, child: TicketCardWidget(ticket: ticket)),
              Order()
            ],
          ),
        ],
      ),
    );
  }
}
