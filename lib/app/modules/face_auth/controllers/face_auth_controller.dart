import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_manager/app/modules/home/views/home_view.dart';

class FaceAuthController extends GetxController {
  final LocalAuthentication _auth = LocalAuthentication();
  var status = 'checking'.obs;
  var errorMessage = ''.obs;
  var retryCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initializeBiometricAuth();
  }

  Future<void> initializeBiometricAuth() async {
    status.value = 'checking';

    try {
      final bool isDeviceSupported = await _auth.isDeviceSupported();
      final bool canCheckBiometrics = await _auth.canCheckBiometrics;

      if (!isDeviceSupported || !canCheckBiometrics) {
        status.value = 'error';
        errorMessage.value = 'Biometric authentication is not supported on this device.';
        return;
      }

      // We skip getAvailableBiometrics() because it's unreliable on Android
      status.value = 'authenticating';

      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Authenticate using Face ID or Fingerprint',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      if (didAuthenticate) {
        Get.offAll(() => HomeView()); // Navigate to your home screen
      } else {
        if (retryCount.value < 3) {
          retryCount.value++;
          initializeBiometricAuth(); // Retry
        } else {
          status.value = 'error';
          errorMessage.value = 'Authentication failed after 3 attempts.';
        }
      }
    } on PlatformException catch (e) {
      status.value = 'error';
      errorMessage.value = 'Authentication error: ${e.message}';
    } catch (e) {
      status.value = 'error';
      errorMessage.value = 'Unexpected error: $e';
    }
  }
}
