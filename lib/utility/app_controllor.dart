import 'package:get/get.dart';
import 'package:gocheckproj/models/checkup_model.dart';
import 'package:gocheckproj/models/drug_model.dart';
import 'package:gocheckproj/models/lab_model.dart';

import 'package:gocheckproj/models/medicaltreat_model.dart';

class AppController extends GetxController {
  RxBool redEye = true.obs;

  RxInt timePincode = 1.obs;

  RxInt age = 0.obs;

  RxMap<String, dynamic> mapUser = <String, dynamic>{}.obs;

  RxInt indexBody = 0.obs;

  RxList<CheckUpModel> checkUpModel = <CheckUpModel>[].obs;

  RxList<MedicalTreatModel> medicalTreatModel = <MedicalTreatModel>[].obs;

  RxList<DrugModel> drugModel = <DrugModel>[].obs;

  RxList<LabModel> labModel = <LabModel>[].obs;


  
}
