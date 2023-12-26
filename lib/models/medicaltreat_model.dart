import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MedicalTreatModel {
  final int roworder;
    final String cid;
    final String hn;
    final String vn;
    final String an;
    final String vstdate;
    final String vsttime;
    final String ovstist;
    final String ovstistname;
    final String spclty;
    final String spcltyname;
    final String doctorname;
    final String ovstostname;
    final String pttypename;
    final String rcptDisease;
    final String hospitalCode;
    final dynamic hospitalName;
  MedicalTreatModel({
    required this.roworder,
    required this.cid,
    required this.hn,
    required this.vn,
    required this.an,
    required this.vstdate,
    required this.vsttime,
    required this.ovstist,
    required this.ovstistname,
    required this.spclty,
    required this.spcltyname,
    required this.doctorname,
    required this.ovstostname,
    required this.pttypename,
    required this.rcptDisease,
    required this.hospitalCode,
    required this.hospitalName,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roworder': roworder,
      'cid': cid,
      'hn': hn,
      'vn': vn,
      'an': an,
      'vstdate': vstdate,
      'vsttime': vsttime,
      'ovstist': ovstist,
      'ovstistname': ovstistname,
      'spclty': spclty,
      'spcltyname': spcltyname,
      'doctorname': doctorname,
      'ovstostname': ovstostname,
      'pttypename': pttypename,
      'rcptDisease': rcptDisease,
      'hospitalCode': hospitalCode,
      'hospitalName': hospitalName,
    };
  }

  factory MedicalTreatModel.fromMap(Map<String, dynamic> map) {
    return MedicalTreatModel(
      roworder: (map['roworder'] ?? 0) as int,
      cid: (map['cid'] ?? '') as String,
      hn: (map['hn'] ?? '') as String,
      vn: (map['vn'] ?? '') as String,
      an: (map['an'] ?? '') as String,
      vstdate: (map['vstdate'] ?? '') as String,
      vsttime: (map['vsttime'] ?? '') as String,
      ovstist: (map['ovstist'] ?? '') as String,
      ovstistname: (map['ovstistname'] ?? '') as String,
      spclty: (map['spclty'] ?? '') as String,
      spcltyname: (map['spcltyname'] ?? '') as String,
      doctorname: (map['doctorname'] ?? '') as String,
      ovstostname: (map['ovstostname'] ?? '') as String,
      pttypename: (map['pttypename'] ?? '') as String,
      rcptDisease: (map['rcptDisease'] ?? '') as String,
      hospitalCode: (map['hospitalCode'] ?? '') as String,
      hospitalName: map['hospitalName'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicalTreatModel.fromJson(String source) => MedicalTreatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
