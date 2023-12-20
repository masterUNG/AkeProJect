import 'package:get/get.dart';
import 'package:gocheckproj/models/checkup_model.dart';

class AppController extends GetxController {
  RxBool redEye = true.obs;

  RxInt timePincode = 1.obs;

  RxMap<String, dynamic> mapUser = <String, dynamic>{}.obs;

  RxInt indexBody = 0.obs;

  RxList<CheckUpModel> checkUpModel = <CheckUpModel>[].obs;
}
