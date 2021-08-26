import 'dart:convert';

Token tokenFromMap(String str) => Token.fromMap(json.decode(str));

String tokenToMap(Token data) => json.encode(data.toMap());

class Token {
    Token({
        this.finish,
        this.id,
        this.initial,
        this.token,
        this.type,
    });

    String finish;
    int id;
    String initial;
    String token;
    String type;

    factory Token.fromMap(Map<String, dynamic> json) => Token(
        finish: json["finish"],
        id: json["id"],
        initial: json["initial"],
        token: json["token"],
        type: json["type"],
    );

    Map<String, dynamic> toMap() => {
        "finish": finish,
        "id": id,
        "initial": initial,
        "token": token,
        "type": type,
    };
}