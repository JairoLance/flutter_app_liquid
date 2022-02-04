class MemberLogin {
  String result;
  String message;
  bool response;
  String type;
  String numberError;
  //MemberLogin();
  //{result: 0, response: false, message:  Ops Credenciales invalidas  , errors: [], type: error, list_cobros: }

  MemberLogin({this.result,this.message,this.response,this.type,this.numberError});

  MemberLogin.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    response = json["response"];
    type = json["type"];
    numberError = json["numberError"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result']      = this.result;
    data['message']     = this.message;
    data['type']        = this.type;
    data['numberError'] = this.numberError;
    data["response"]    = this.response;
    return data;
  }
}