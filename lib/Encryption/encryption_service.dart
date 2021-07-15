
import 'package:encrypt/encrypt.dart';
import 'package:pigeon_flutter/utility/secret.dart';

class EncryptionService {
  static String _passwordMod(String pass) {
    if (pass.length > 32) {
      return pass.substring(0, 32);
    } else {
      return (pass + encryptionKey).substring(0, 32);
    }
  }

  static String _IVMod(String initialIV) {
    if (initialIV.length > 16) {
      return initialIV.substring(0, 16);
    } else {
      return (initialIV + encryptionKey).substring(0, 16);
    }
  }

  static String decrypt(String ivPassword, String password, String base64Data) {
    final decryptionPass = _passwordMod(password);
    final iv = IV.fromUtf8(_IVMod(ivPassword));

    final encrypter = Encrypter(
      AES(
        Key.fromUtf8(decryptionPass),
        mode: AESMode.cbc,
      ),
    );

    return encrypter.decrypt64(base64Data, iv: iv);
  }

  static String encrypt(String ivPassword, String password, String message) {
    final encryptionPassword = _passwordMod(password);
    assert(encryptionPassword.length == 32);
    final iv = IV.fromUtf8(_IVMod(ivPassword));
    
    final encrypter = Encrypter(
      AES(
        Key.fromUtf8(encryptionPassword),
        mode: AESMode.cbc,
      ),
    );

    return encrypter.encrypt(message, iv: iv).base64;
  }
}
