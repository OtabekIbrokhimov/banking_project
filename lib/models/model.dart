import 'dart:convert';

List<CardModel> pictureFromJson(String str) => List<CardModel>.from(json.decode(str).map((x) => CardModel.fromJson(x)));
String pictureToJson(List<CardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class CardModel {
  String? createdTime;
  String? cardNumber;
  String? name;
  String? sv;
  String? id;

  CardModel({this.createdTime, this.cardNumber, this.name,
    this.id,this.sv});

  CardModel.fromJson(Map<String, dynamic> json)
    :id = json['id'],
    createdTime= json['createdTime'],
    cardNumber = json["cardNumber"],
    name = json["name"],
    sv = json['sv'];


 Map <String,dynamic> toJson() =>{
   "id":id,
   "createdTime":createdTime,
   "cardNumber":cardNumber,
   "name":name,
   "sv":sv,
  };
}