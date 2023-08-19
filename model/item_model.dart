// To parse this JSON data, do
//
//     final items = itemsFromJson(jsonString);

import 'dart:convert';

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));

String itemsToJson(Items data) => json.encode(data.toJson());

class Items {
    String appTitle;
    String versiyon;
    Header header;
    List<Item> items;

    Items({
        required this.appTitle,
        required this.versiyon,
        required this.header,
        required this.items,
    });

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        appTitle: json["app_title"],
        versiyon: json["versiyon"],
        header: Header.fromJson(json["header"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "app_title": appTitle,
        "versiyon": versiyon,
        "header": header.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Header {
    Header();

    factory Header.fromJson(Map<String, dynamic> json) => Header(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Item {
    String imdbId;
    String title;
    String ltitle;
    String otitle;
    String kind;
    String year;
    String time;
    String rating;
    String cover;
    String fscover;
    String ititle;
    String iid;
    String isSeries;

    Item({
        required this.imdbId,
        required this.title,
        required this.ltitle,
        required this.otitle,
        required this.kind,
        required this.year,
        required this.time,
        required this.rating,
        required this.cover,
        required this.fscover,
        required this.ititle,
        required this.iid,
        required this.isSeries,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        imdbId: json["imdb_id"],
        title: json["title"],
        ltitle: json["ltitle"],
        otitle:  json["otitle"] ,
        kind: json["kind"],
        year: json["year"],
        time: json["time"],
        rating: json["rating"],
        cover: json["cover"],
        fscover: json["fscover"],
        ititle: json["ititle"],
        iid: json["iid"],
        isSeries: json["is_series"],
    );

    Map<String, dynamic> toJson() => {
        "imdb_id": imdbId,
        "title": title,
        "ltitle": ltitle,
        "otitle":  otitle  ,
        "kind": kind,
        "year": year,
        "time": time,
        "rating": rating,
        "cover": cover,
        "fscover": fscover,
        "ititle": ititle,
        "iid": iid,
        "is_series": isSeries,
    };
}

 
