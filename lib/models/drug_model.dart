import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DrugModel {
  final int roworder;
    final String cid;
    final String hn;
    final String vn;
    final String vstdate;
    final String icode;
    final String name;
    final String strength;
    final String units;
    final int qty;
    final String dosageform;
    final String rxdate;
    final String rxtime;
    final String doctorname;
    final String hospitalCode;
    final dynamic hospitalName;
  DrugModel({
    required this.roworder,
    required this.cid,
    required this.hn,
    required this.vn,
    required this.vstdate,
    required this.icode,
    required this.name,
    required this.strength,
    required this.units,
    required this.qty,
    required this.dosageform,
    required this.rxdate,
    required this.rxtime,
    required this.doctorname,
    required this.hospitalCode,
    required this.hospitalName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roworder': roworder,
      'cid': cid,
      'hn': hn,
      'vn': vn,
      'vstdate': vstdate,
      'icode': icode,
      'name': name,
      'strength': strength,
      'units': units,
      'qty': qty,
      'dosageform': dosageform,
      'rxdate': rxdate,
      'rxtime': rxtime,
      'doctorname': doctorname,
      'hospitalCode': hospitalCode,
      'hospitalName': hospitalName,
    };
  }

  factory DrugModel.fromMap(Map<String, dynamic> map) {
    return DrugModel(
      roworder: (map['roworder'] ?? 0) as int,
      cid: (map['cid'] ?? '') as String,
      hn: (map['hn'] ?? '') as String,
      vn: (map['vn'] ?? '') as String,
      vstdate: (map['vstdate'] ?? '') as String,
      icode: (map['icode'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      strength: (map['strength'] ?? '') as String,
      units: (map['units'] ?? '') as String,
      qty: (map['qty'] ?? 0) as int,
      dosageform: (map['dosageform'] ?? '') as String,
      rxdate: (map['rxdate'] ?? '') as String,
      rxtime: (map['rxtime'] ?? '') as String,
      doctorname: (map['doctorname'] ?? '') as String,
      hospitalCode: (map['hospitalCode'] ?? '') as String,
      hospitalName: map['hospitalName'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory DrugModel.fromJson(String source) => DrugModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
