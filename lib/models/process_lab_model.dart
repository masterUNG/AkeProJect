import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProcessLabModel {
  final String resultText;
  final String resultFlag;
  ProcessLabModel({
    required this.resultText,
    required this.resultFlag,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resultText': resultText,
      'resultFlag': resultFlag,
    };
  }

  factory ProcessLabModel.fromMap(Map<String, dynamic> map) {
    return ProcessLabModel(
      resultText: (map['resultText'] ?? '') as String,
      resultFlag: (map['resultFlag'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProcessLabModel.fromJson(String source) => ProcessLabModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
