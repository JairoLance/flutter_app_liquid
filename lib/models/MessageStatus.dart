class MessageStatus{
  int    result;
  String message;
  String response;
  String type;
  int    numbererror;

  //{result: 0, response: false, message:  Ops Credenciales invalidas  , errors: [], type: error, list_cobros: }

  MessageStatus({this.result,this.message,this.response,this.type,this.numbererror});

  MessageStatus.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    response = json["response"];
    type = json["type"];
    numbererror = json["numbererror"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result']      = this.result;
    data['message']     = this.message;
    data['type']        = this.type;
    data['numbererror'] = this.numbererror;
    data["response"]    = this.response;
    return data;
  }
}