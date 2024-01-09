import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CheckUpModel {
  final String visittime;
  final String? checkupsummarytime;
  final String? createtime;
  final String hospitalCode;
  final String appointmentdate;
  final String objective;
  final String doctorname;
  final String remark;
  final double bmi;
  final String? systolic;
  final String? diastolic;
  final String? birthday;
  final double? weight;
  final double? height;
  final String? waistline;
  final String? fname;
  final String? lname;
  final String? pname;
  final String? vn;

  CheckUpModel({
    required this.visittime,
    this.checkupsummarytime,
    this.createtime,
    required this.hospitalCode,
    required this.appointmentdate,
    required this.objective,
    required this.doctorname,
    required this.remark,
    required this.bmi,
    required this.systolic,
    this.diastolic,
    this.birthday,
    this.weight,
    this.height,
    this.waistline,
    this.fname,
    this.lname,
    this.pname,
    this.vn,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visittime': visittime,
      'checkupsummarytime': checkupsummarytime,
      'createtime': createtime,
      'hospitalCode': hospitalCode,
      'appointmentdate': appointmentdate,
      'objective': objective,
      'doctorname': doctorname,
      'remark': remark,
      'bmi': bmi,
      'systolic': systolic,
      'diastolic': diastolic,
      'birthday': birthday,
      'weight': weight,
      'height': height,
      'waistline': waistline,
      'fname': fname,
      'lname': lname,
      'pname': pname,
      'vn': vn,
    };
  }

  factory CheckUpModel.fromMap(Map<String, dynamic> map) {
    return CheckUpModel(
      visittime: (map['visittime'] ?? '') as String,
      checkupsummarytime: map['checkupsummarytime'] != null ? map['checkupsummarytime'] as String : null,
      createtime: map['createtime'] != null ? map['createtime'] as String : null,
      hospitalCode: (map['hospitalCode'] ?? '') as String,
      appointmentdate: (map['appointmentdate'] ?? '') as String,
      objective: (map['objective'] ?? '') as String,
      doctorname: (map['doctorname'] ?? '') as String,
      remark: (map['remark'] ?? '') as String,
      bmi: (map['bmi'] ?? 0.0) as double,
      systolic: map['systolic'] != null ? map['systolic'] as String : null,
      diastolic: map['diastolic'] != null ? map['diastolic'] as String : null,
      birthday: map['birthday'] != null ? map['birthday'] as String : null,
      weight: map['weight'] != null ? map['weight'] as double : null,
      height: map['height'] != null ? map['height'] as double : null,
      waistline: map['waistline'] != null ? map['waistline'] as String : null,
      fname: map['fname'] != null ? map['fname'] as String : null,
      lname: map['lname'] != null ? map['lname'] as String : null,
      pname: map['pname'] != null ? map['pname'] as String : null,
      vn: map['vn'] != null ? map['vn'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckUpModel.fromJson(String source) =>
      CheckUpModel.fromMap(json.decode(source) as Map<String, dynamic>);
}



