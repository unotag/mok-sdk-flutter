// To parse this JSON data, do
//
//     final carouselData = carouselDataFromJson(jsonString);

import 'dart:convert';

CarouselData carouselDataFromJson(String str) => CarouselData.fromJson(json.decode(str));

String carouselDataToJson(CarouselData data) => json.encode(data.toJson());

class CarouselData {
  String? message;
  List<Data>? data;

  CarouselData({
    this.message,
    this.data,
  });

  factory CarouselData.fromJson(Map<String, dynamic> json) => CarouselData(
    message: json["message"],
    data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Data {
  String? carouselId;
  String? orgId;
  String? createdAt;
  String? updatedAt;
  String? clientId;
  List<CarouselContent>? carouselContent;

  Data({
    this.carouselId,
    this.orgId,
    this.createdAt,
    this.updatedAt,
    this.clientId,
    this.carouselContent,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    carouselId: json["caraousel_id"],
    orgId: json["org_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    clientId: json["ClientId"],
    carouselContent: json["caraousel_content"] == null ? [] : List<CarouselContent>.from(json["caraousel_content"]!.map((x) => CarouselContent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "caraousel_id": carouselId,
    "org_id": orgId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "ClientId": clientId,
    "caraousel_content": carouselContent == null ? [] : List<dynamic>.from(carouselContent!.map((x) => x.toJson())),
  };
}

class CarouselContent {
  int? id;
  String? type;
  String? url;

  CarouselContent({
    this.id,
    this.type,
    this.url,
  });

  factory CarouselContent.fromJson(Map<String, dynamic> json) => CarouselContent(
    id: json["id"],
    type: json["type"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "url": url,
  };
}
