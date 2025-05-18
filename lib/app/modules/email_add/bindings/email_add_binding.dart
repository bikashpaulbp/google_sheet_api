import 'package:get/get.dart';

import '../controllers/email_add_controller.dart';

class EmailAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailAddController>(
      () => EmailAddController(),
    );
  }
}
