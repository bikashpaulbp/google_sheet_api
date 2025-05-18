import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/face_auth_controller.dart';

class FaceAuthView extends GetView<FaceAuthController> {
  FaceAuthView({super.key});

  final FaceAuthController controller = Get.put(FaceAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.status.value) {
          case 'checking':
            return _buildLoading();
          case 'authenticating':
            return _buildAuthInProgress();
          case 'error':
            return _buildError();
          default:
            return _buildAuthInProgress(); // Fallback
        }
      }),
    );
  }

  Widget _buildLoading() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Checking biometric availability...')
          ],
        ),
      );

  Widget _buildAuthInProgress() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.lock, size: 80),
            SizedBox(height: 20),
            Text('Authenticating...', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Please authenticate using Face ID or Fingerprint'),
          ],
        ),
      );

  Widget _buildError() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Authentication Error', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text(controller.errorMessage.value),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.initializeBiometricAuth,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
}
