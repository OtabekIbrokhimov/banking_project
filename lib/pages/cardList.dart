
import 'package:banking_project/models/model.dart';
import 'package:banking_project/pages/addCardPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../servises/http_servise.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key}) : super(key: key);
  static const String id = "/cardlist";

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList>  {
  List <CardModel>list = [];
@override
void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }
  void _apiPostList() async {
    await NoteServise.GET(NoteServise.API_LIST, NoteServise.paramsEmpty())
        .then((response) => {
      print(response!),
      _showResponse(response),
    });
  }

  void _showResponse(String response) {
    setState(() {

      list = NoteServise.parsePostList(response);

    });
  }
void apiDelete(int i){
  CardModel note = CardModel(id: i.toString());
NoteServise.DELETE(NoteServise.API_DELETE+ note.id.toString(),NoteServise.paramsEmpty()).then((value) => {
if(value != null) {

  _apiPostList()}
});
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Morning ",
                        style: TextStyle(fontSize: 22),
                      ),
                      Text(
                        "Eguene",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/images.jpg"),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child:SingleChildScrollView(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                     height: MediaQuery.of(context).size.height-250,
                  width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index){
                      return Column(children:[ _buildCreditCard(
                          color: Color(0xFF090943),
                          cardExpiration: list[index].createdTime!,
                          cardHolder: list[index].name!,
                          cardNumber: list[index].cardNumber!,index: index),

                        SizedBox(
                          height: 15,
                        ),
                      ]);
              }),),
                    _buildAddCardButton(),
                  ],
                ),
              ),
            )
            )],

        ),
      ),

    );
  }

  Column _buildTitleSection({@required title, @required subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0),
          child: Text(
            '$title',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
          child: Text(
            '$subTitle',
            style: TextStyle(fontSize: 21, color: Colors.black45),
          ),
        )
      ],

    );
  }

  // Build the credit card widget
  Widget _buildCreditCard(
      { required int index,
        required Color color,
      required String cardNumber,
      required String cardHolder,
      required String cardExpiration}) {
    return Dismissible(
        key: const ValueKey(0),
    onDismissed: (DismissDirection){apiDelete(index);},
    background: Container(
    color: Colors.red,
    child:  const Icon(Icons.delete,color: Colors.white,size: 100,),

    ),
    child:Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
           Container(
        height: 40,
        child: _buildLogosBlock(),),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                '$cardNumber',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'CARDHOLDER',
                  value: cardHolder,
                ),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }

  // Build the top row containing logos
  Row _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/gold-emv-chip-icon-bank-260nw-1401984860.webp",
          height: 40,
          width: 18,
        ),
        Image.asset(
          "assets/images/Visa_Inc._logo.svg.png",
          height: 50,
          width: 50,
        ),
      ],
    );
  }

// Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '',
          style: TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

// Build the FloatingActionButton
  Widget _buildAddCardButton() {
    return  Container(
        width: MediaQuery.of(context).size.width,
        child:Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
      Container(
      height: 40,
      width: 40,
        child: IconButton(
          onPressed: (){Navigator.pushNamed(context, AddCardPage.id);},
          icon: Icon(Icons.add_box_outlined,size: 40,),
        ),
      ),
    SizedBox(height: 10,),
      Text("   Add new card",style: TextStyle(fontSize: 18),)
    ]  )));
  }
}

