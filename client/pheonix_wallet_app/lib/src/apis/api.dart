import 'dart:convert';

import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:http/http.dart' as http;

class Api {
  // SplashScreen -> Create Wallet Button
  static Future<String> generateMnemonicForNewAccount() async {
    try {
      var uri =
          Uri.https(serverURL, 'key-generation/generateMnemonicForNewAccount');

      var response = await http.get(uri);

      if (response.statusCode == 200) {
        String mnemonic = json.decode(response.body)["result"];
        return mnemonic;
      }
    } catch (e) {
      print(e.toString());
      return "";
    }

    return "";
  }

  static Future<List<String>> importWalletFromMnemonic(String mnemonic) async {
    try {
      var uri =
          Uri.https(serverURL, 'key-generation/import-wallet-from-mnemonic');

      var map = new Map<String, dynamic>();
      map['mnemonic'] = mnemonic;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        String privateKey = json.decode(response.body)["result"][0];
        String publicKey = json.decode(response.body)["result"][1];
        return [privateKey, publicKey];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
    return [];
  }

  static Future<String> mnemonicToEntropy(String mnemonic) async {
    try {
      var uri = Uri.https(serverURL, 'key-generation/mnemonic-to-entropy');

      var map = new Map<String, dynamic>();
      map['mnemonic'] = mnemonic;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        String entrophy = json.decode(response.body)["result"];
        //107082484481430705169251899735211200435
        return entrophy;
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
    return "";
  }

  // MnemonicPhraseScreen -> On import wallet button press

  // importWalletFromMnemonic(String mnemonic) -> Developed in Splash Screen -> Create Wallet Button
  // mnemonicToEntropy(String mnemonic) -> Developed in Splash Screen -> Create Wallet Button

  static Future<String> getContractAddressByPublicAddress(
      String publicKey, String privateKey) async {
    try {
      var uri = Uri.https(
          serverURL, 'public-contract/get-contract-address-by-public-address');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey.toString();
      map['privateKey'] = privateKey.toString();

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        String contractAddress = json.decode(response.body)["result"];

        return contractAddress;
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
    return "";
  }

  static Future<String> getUserName(
      String publicKey, String privateKey, String contractAddress) async {
    try {
      var uri = Uri.https(serverURL, 'node-contract/user-name');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['nodeContract'] = contractAddress;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        String username = json.decode(response.body)["result"];
        return username;
      }
    } catch (e) {
      print(e.toString());
    }
    return "";
  }

  // RegistrationScreen -> On register button press

  static Future<bool> checkUserExists(
      String publicKey, String privateKey, String username) async {
    try {
      var uri = Uri.https(serverURL, 'public-contract/check-user-exists');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['userName'] = username;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        bool existance = json.decode(response.body)["result"];
        return existance;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  static Future<String> deploy(String publicKey, String privateKey) async {
    try {
      var uri = Uri.https(serverURL, 'node-contract/deploy');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        String contractAddress = json.decode(response.body)["result"];
        return contractAddress;
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
    return "";
  }

  static Future<String> register(String publicKey, String privateKey,
      String username, String nodeContract) async {
    try {
      var uri = Uri.https(serverURL, 'node-contract/register');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['userName'] = username;
      map['nodeContract'] = nodeContract;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        String state = json.decode(response.body)["result"];
        return state;
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
    return "";
  }

  // AddShareHoldersScreen -> On submit button press

  static Future<int> addTemporaryShareHolder(String publicKey,
      String privateKey, String shareholder, String contractAddress) async {
    try {
      var uri = Uri.https(serverURL, 'node-contract/add-temp-share-holder');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['shareHolder'] = shareholder;
      map['nodeContract'] = contractAddress;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        int result = json.decode(response.body)["result"];
        return result;
      }
    } catch (e) {
      print(e.toString());
      return 0;
    }
    return 0;
  }

  static Future<int> makeHolderRequests(
      String publicKey, String privateKey, String contractAddress) async {
    try {
      var uri = Uri.https(serverURL, 'node-contract/make-shareholder-requests');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['nodeContract'] = contractAddress;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        int result = json.decode(response.body)["result"];
        return result;
      }
    } catch (e) {
      print(e.toString());
      return 0;
    }
    return 0;
  }

  // ShareholderStatusScreen -> On page loading

  static Future<dynamic> getHolderStatus(
      String publicKey, String privateKey, String contractAddress) async {
    try {
      var uri = Uri.https(serverURL, 'node-contract/holder-status');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['nodeContract'] = contractAddress;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        dynamic shareHolderList = json.decode(response.body)["result"];
        print(shareHolderList);
        // [[0xc2b2904A2E8Dad66e1CeC642CAb2E73C527BA6b6, Pending], [0x2A16c9190272Fc0B45400E567418BA44cF8f1FC8, Pending], [0x5a2F9e9c4c36Ac1cA6E485c9235b7B532cB6C09f, Pending]]
        // PENDING = "Pending"
        // ACCEPTED = "Accepted"
        // REJECTED = "Rejected"
        return shareHolderList;
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
    return "";
  }

  // ShareholderRequstScreen -> On page loading

  static Future<List<String>> checkRequestsForBeAHolder(
      String publicKey, String privateKey, String contractAddress) async {
    try {
      var uri = Uri.https(serverURL, 'node-contract/be-holder-requests');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['nodeContract'] = contractAddress;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        dynamic result = json.decode(response.body)["result"];
        print(result);
        List<String> shareHolderList = [];
        for (var element in result) {
          shareHolderList.add(element);
        }

        print(shareHolderList);
        // [0xD4d37C895D9c4b183B1c5DAd2C56Ff3182D001D4]
        return shareHolderList;
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
    return [];
  }

  static Future<dynamic> acceptInvitation(String publicKey, String privateKey,
      String contractAddress, String shareOwner) async {
    try {
      var uri = Uri.https(serverURL, 'node-contract/accept-invitation');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['address'] = shareOwner;
      map['nodeContract'] = contractAddress;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        dynamic result = json.decode(response.body)["result"];

        return result;
      }
    } catch (e) {
      print(e.toString());
      return 0;
    }
    return 0;
  }

  // DistributeShares -> On distribute button press

  static Future<int> distribute(
    bool isVerifying,
    String publicKey,
    String privateKey,
    String contractAddress,
    String email,
    String entropy,
    //107082484481430705169251899735211200435
  ) async {
    // default isVerifying true
    if (!isVerifying) {
      return 3;
    }

    try {
      var uri = Uri.https(serverURL, 'node-contract/distribute');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['nodeContract'] = contractAddress;
      map['email'] = email;
      map['entropy'] = entropy;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        // 1 - Not goood fingerprint
        int result = json.decode(response.body)["result"];

        return result;
      }
    } catch (e) {
      print(e.toString());
      return 0;
    }
    return 0;
  }

  // Generate OTP for email
  static Future<String> generateOTP(String email) async {
    try {
      var uri = Uri.https(serverURL, 'otp/generate-otp');

      var map = new Map<String, dynamic>();
      map['email'] = email;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        String result = json.decode(response.body)["result"];

        return result;
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
    return "";
  }

  static Future<String> getOTPHash(String otp) async {
    try {
      var uri = Uri.https(serverURL, 'otp/get-otp-hash');

      var map = new Map<String, dynamic>();
      map['otp'] = otp;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        String result = json.decode(response.body)["result"];

        return result;
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
    return "";
  }

  // RecoveryRequestScreen1 -> On Preceed
  static Future<List<String>> getEmailByUserName(
    String publicKey,
    String privateKey,
    String contractAddress,
    String username,
  ) async {
    try {
      var uri = Uri.https(serverURL, 'node-contract/email-by-user-name');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['nodeContract'] = contractAddress;
      map['userName'] = username;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        List<String> result =
            json.decode(response.body)["result"]; //[email, generatedSigendOTP]

        return result;
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
    return [];
  }

  // RecoveryRequestScreen2 -> On Preceed
  static Future<dynamic> requestShares(
      String publicKey,
      String privateKey,
      String contractAddress,
      String username,
      String generatedSigendOTP,
      String OTP) async {
    try {
      var uri = Uri.https(serverURL, 'node-contract/request-shares');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['nodeContract'] = contractAddress;
      map['userName'] = username;
      map['generatedSigendOTP'] = generatedSigendOTP;
      map['OTP'] = OTP;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        dynamic result = json.decode(response.body)["result"];

        return result;
      }
    } catch (e) {
      print(e.toString());
      return 0;
    }
    return 0;
  }

  // RecoveryRequestsScreen -> On page load
  static Future<List<String>> checkRequestsForShare(
    String publicKey,
    String privateKey,
    String contractAddress,
  ) async {
    try {
      var uri = Uri.https(serverURL, 'node-contract/share-requests');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['nodeContract'] = contractAddress;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        List<String> recoveryRequestsList =
            json.decode(response.body)["result"];

        return recoveryRequestsList;
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
    return [];
  }

  // On accept button press
  static Future<dynamic> releaseShare(
    String publicKey,
    String privateKey,
    String contractAddress,
    String address,
  ) async {
    try {
      var uri = Uri.https(serverURL, 'node-contract/release-share');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['nodeContract'] = contractAddress;
      map['address'] = address;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        dynamic result = json.decode(response.body)["result"];

        return result;
      }
    } catch (e) {
      print(e.toString());
      return 0;
    }
    return 0;
  }

  // RecoveryScreen1 -> On Preceed

  // getEmailByUserName

  // RecoveryScreen3 -> On Preceed
  static Future<int> recover(
    bool isVerifying,
    String publicKey,
    String privateKey,
    String contractAddress,
    String username,
    String generatedSigendOTP,
    String OTP,
  ) async {
    // default isVerifying true
    if (!isVerifying) {
      return 3;
    }
    try {
      var uri = Uri.https(serverURL, 'node-contract/request-shares');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['nodeContract'] = contractAddress;
      map['userName'] = username;
      map['generatedSigendOTP'] = generatedSigendOTP;
      map['OTP'] = OTP;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        int result = json.decode(response.body)["result"];

        // 1 - error
        // 2 - not good fp
        // 3 - not verifying
        // else secret (entrophy)

        return result;
      }
    } catch (e) {
      print(e.toString());
      return 0;
    }
    return 0;
  }

  // after recovering
  static Future<String> entrophyToMnemonic(
    String entrophy,
  ) async {
    try {
      var uri = Uri.https(serverURL, 'key-generation/entropy-to-mnemonic');

      var map = new Map<String, dynamic>();
      map['entrophy'] = entrophy;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        String mnemonic = json.decode(response.body)["result"];

        return mnemonic;
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
    return "";
  }
}
