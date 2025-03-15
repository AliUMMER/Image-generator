class Generatormodel {
  Message? message;

  Generatormodel({this.message});

  Generatormodel.fromJson(Map<String, dynamic> json) {
    if (json["message"] is Map) {
      message =
          json["message"] == null ? null : Message.fromJson(json["message"]);
    }
  }

  static List<Generatormodel> fromList(List<Map<String, dynamic>> list) {
    return list.map(Generatormodel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (message != null) {
      _data["message"] = message?.toJson();
    }
    return _data;
  }
}

class Message {
  String? status;
  String? outputPng;

  Message({this.status, this.outputPng});

  Message.fromJson(Map<String, dynamic> json) {
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["output_png"] is String) {
      outputPng = json["output_png"];
    }
  }

  static List<Message> fromList(List<Map<String, dynamic>> list) {
    return list.map(Message.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["output_png"] = outputPng;
    return _data;
  }
}
