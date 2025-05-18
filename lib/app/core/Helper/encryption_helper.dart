import 'package:encrypt/encrypt.dart';
import 'package:password_manager/app/core/local_data/storage_helper.dart';


class EncryptionHelper {
  static late final Encrypter _encrypter;

  static Future<void> initialize() async {
    final key = await _getOrCreateKey();
    _encrypter = Encrypter(AES(Key.fromBase64(key)));
  }

  static Future<String> _getOrCreateKey() async {
    final existingKey = LocalStorageHelper.get<String>('aes_key_pm');
    if (existingKey != null) return existingKey;
    
    final newKey = Key.fromSecureRandom(32).base64;
    await LocalStorageHelper.save('aes_key_pm', newKey);
    return newKey;
  }

  static String encrypt(String plainText) {
    final iv = IV.fromSecureRandom(16);
    final encrypted = _encrypter.encrypt(plainText, iv: iv);
    return '${iv.base64}|${encrypted.base64}';
  }

  static String decrypt(String encryptedText) {
    final parts = encryptedText.split('|');
    final iv = IV.fromBase64(parts[0]);
    final encrypted = Encrypted.fromBase64(parts[1]);
    return _encrypter.decrypt(encrypted, iv: iv);
  }
}