import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CheckUpModel {
  final String visittime;
  final String hospitalCode;
  final String appointmentdate;
  final String objective;
  final String doctorname;
  final String remark;
  final double bmi;
  final String? systolic;
  final String? diastolic;
  CheckUpModel({
    required this.visittime,
    required this.hospitalCode,
    required this.appointmentdate,
    required this.objective,
    required this.doctorname,
    required this.remark,
    required this.bmi,
    required this.systolic,
    this.diastolic,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visittime': visittime,
      'hospitalCode': hospitalCode,
      'appointmentdate': appointmentdate,
      'objective': objective,
      'doctorname': doctorname,
      'remark': remark,
      'bmi': bmi,
      'systolic': systolic,
      'diastolic': diastolic,
    };
  }

  factory CheckUpModel.fromMap(Map<String, dynamic> map) {
    return CheckUpModel(
      visittime: (map['visittime'] ?? '') as String,
      hospitalCode: (map['hospitalCode'] ?? '') as String,
      appointmentdate: (map['appointmentdate'] ?? '') as String,
      objective: (map['objective'] ?? '') as String,
      doctorname: (map['doctorname'] ?? '') as String,
      remark: (map['remark'] ?? '') as String,
      bmi: (map['bmi'] ?? 0.0) as double,
      systolic: map['systolic'] != null ? map['systolic'] as String : null,
      diastolic: map['diastolic'] != null ? map['diastolic'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckUpModel.fromJson(String source) =>
      CheckUpModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
