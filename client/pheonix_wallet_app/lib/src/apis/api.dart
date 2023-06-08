import 'dart:convert';

import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:http/http.dart' as http;

class Api {
  // SplashScreen -> Create Wallet Button
  Future<String> generateMnemonicForNewAccount() async {
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

  Future<List<String>> importWalletFromMnemonic(String mnemonic) async {
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

  Future<String> mnemonicToEntropy(String mnemonic) async {
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

  Future<String> getContractAddressByPublicAddress(
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
        if (contractAddress == "0x0000000000000000000000000000000000000000") {
          return "";
        }
        return contractAddress;
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
    return "";
  }

  Future<String> getUserName(
      String publicKey, String privateKey, String contractAddress) async {
    try {
      var uri = Uri.https(serverURL, 'node-contract/user-name');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['nodeContract'] = contractAddress;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        String entropy = json.decode(response.body)["result"];
        return entropy;
      }
    } catch (e) {
      print(e.toString());
    }
    return "";
  }

  // RegistrationScreen -> On register button press

  Future<bool> checkUserExists(
      String publicKey, String privateKey, String usename) async {
    try {
      var uri = Uri.https(serverURL, 'public-contract/check-user-exists');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['userName'] = usename;

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

  Future<String> deploy(String publicKey, String privateKey) async {
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

  Future<String> register(String publicKey, String privateKey, String username,
      String nodeContract) async {
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

  Future<int> addTemporaryShareHolder(String publicKey, String privateKey,
      String shareholder, String contractAddress) async {
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

  Future<int> makeHolderRequests(
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

  Future<dynamic> getHolderStatus(
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

  Future<dynamic> checkRequestsForBeAHolder(
      String publicKey, String privateKey, String contractAddress) async {
    try {
      var uri = Uri.https(serverURL, 'node-contract/be-holder-requests');

      var map = new Map<String, dynamic>();
      map['publicKey'] = publicKey;
      map['privateKey'] = privateKey;
      map['nodeContract'] = contractAddress;

      final response = await http.post(uri, body: map);

      if (response.statusCode == 200) {
        dynamic shareHolderList = json.decode(response.body)["result"];

        // [0xD4d37C895D9c4b183B1c5DAd2C56Ff3182D001D4]
        return shareHolderList;
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
    return [];
  }

  Future<dynamic> acceptInvitation(String publicKey, String privateKey,
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

  Future<int> distribute(
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
  Future<String> generateOTP(String email) async {
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

  Future<String> getOTPHash(String otp) async {
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

  // Future<dynamic> postUsers() async {
  //   try {
  //     var uri = Uri.https(serverURL, 'node-contract/deploy');

  //     var map = new Map<String, dynamic>();
  //     map['prv'] =
  //         '6261ced5f7996c96aac73be45487cbf2f95afead4931e27a6657b101bb823029';
  //     map['pub'] = '0x28e642748dcaec3e82ef9a7a145eca9c09227b82';

  //     final response = await http.post(uri, body: map);

  //     if (response.statusCode == 200) {
  //       var responseData = json.decode(response.body)["result"];
  //       return true;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     return false;
  //   }
  // }
}
