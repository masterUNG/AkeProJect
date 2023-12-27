import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LabModel {
  final int? roworder;
  final String? cid;
  final String? hn;
  final String? vn;
  final String? lab_items_code;
  final int? lab_order_number;
  final String? form_name;
  final String? report_date;
  final String? lab_items_name;
  final String? lab_order_result;
  final String? lab_items_unit;
  final String? lab_items_normal_value;
  final String? sub_group_list;
  final dynamic? lab_items_sub_group_name;
  final String? hospitalCode;
  final dynamic? hospitalName;
  LabModel({
    this.roworder,
    this.cid,
    this.hn,
    this.vn,
    this.lab_items_code,
    this.lab_order_number,
    this.form_name,
    this.report_date,
    this.lab_items_name,
    this.lab_order_result,
    this.lab_items_unit,
    this.lab_items_normal_value,
    this.sub_group_list,
    this.lab_items_sub_group_name,
    this.hospitalCode,
    this.hospitalName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roworder': roworder,
      'cid': cid,
      'hn': hn,
      'vn': vn,
      'lab_items_code': lab_items_code,
      'lab_order_number': lab_order_number,
      'form_name': form_name,
      'report_date': report_date,
      'lab_items_name': lab_items_name,
      'lab_order_result': lab_order_result,
      'lab_items_unit': lab_items_unit,
      'lab_items_normal_value': lab_items_normal_value,
      'sub_group_list': sub_group_list,
      'lab_items_sub_group_name': lab_items_sub_group_name,
      'hospitalCode': hospitalCode,
      'hospitalName': hospitalName,
    };
  }

  factory LabModel.fromMap(Map<String, dynamic> map) {
    return LabModel(
      roworder: map['roworder'] != null ? map['roworder'] as int : null,
      cid: map['cid'] != null ? map['cid'] as String : null,
      hn: map['hn'] != null ? map['hn'] as String : null,
      vn: map['vn'] != null ? map['vn'] as String : null,
      lab_items_code: map['lab_items_code'] != null
          ? map['lab_items_code'] as String
          : null,
      lab_order_number: map['lab_order_number'] != null
          ? map['lab_order_number'] as int
          : null,
      form_name: map['form_name'] != null ? map['form_name'] as String : null,
      report_date:
          map['report_date'] != null ? map['report_date'] as String : null,
      lab_items_name: map['lab_items_name'] != null
          ? map['lab_items_name'] as String
          : null,
      lab_order_result: map['lab_order_result'] != null
          ? map['lab_order_result'] as String
          : null,
      lab_items_unit: map['lab_items_unit'] != null
          ? map['lab_items_unit'] as String
          : null,
      lab_items_normal_value: map['lab_items_normal_value'] != null
          ? map['lab_items_normal_value'] as String
          : null,
      sub_group_list: map['sub_group_list'] != null
          ? map['sub_group_list'] as String
          : null,
      lab_items_sub_group_name: map['lab_items_sub_group_name'] != null
          ? map['lab_items_sub_group_name'] as dynamic
          : null,
      hospitalCode:
          map['hospitalCode'] != null ? map['hospitalCode'] as String : null,
      hospitalName:
          map['hospitalName'] != null ? map['hospitalName'] as dynamic : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LabModel.fromJson(String source) =>
      LabModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
