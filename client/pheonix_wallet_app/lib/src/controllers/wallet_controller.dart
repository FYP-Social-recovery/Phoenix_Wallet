import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pheonix_wallet_app/src/apis/api.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/services/nodeService.dart';
import 'package:pheonix_wallet_app/src/services/publicService.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import 'controller_home.dart';

import 'package:http/http.dart' as http;

class WalletController extends GetxController {
  var loading = false.obs;

  //General details
  var balance = 0.0.obs;

  var selectedNetwork = 0.obs;
  var blockchain = networks[0]["Name"].toString().obs;
  var selectedNetworkType = networkTypes[1].obs;
  var selectedNetworkLayer = networkLayers[1].obs;

  var network = "".obs;
  var currency = "".obs;
  var rpcUrl = "".obs;
  var chainId = 0.obs;
  var explorerURL = "".obs;

  //Recovery info
  var registered = false.obs;
  var nodeContractAddress = "".obs;
  var username = "".obs;
  var email = "".obs;

  var beShareholderRequests = [""].obs;
  var shareholderRequestStatus = [].obs;
  var shareRecoveryRequests = [""].obs;

  var usernameExists = false.obs;

  var otpHash = "".obs;
  var otp = "".obs;
  var generatedSigendOTP = "".obs;

  @override
  void onInit() {
    changeBlockchainData();
    super.onInit();
  }

  void changeBlockchainData() {
    network.value = networks[0][selectedNetworkType.value]
        [selectedNetworkLayer.value]["FullName"];
    currency.value = networks[0][selectedNetworkType.value]
        [selectedNetworkLayer.value]["Currency"];
    rpcUrl.value = networks[0][selectedNetworkType.value]
        [selectedNetworkLayer.value]["RpcUrl"];
    chainId.value = networks[0][selectedNetworkType.value]
        [selectedNetworkLayer.value]["ChainId"];
    explorerURL.value = networks[0][selectedNetworkType.value]
        [selectedNetworkLayer.value]["ExplorerURL"];
  }

  Future<void> getBalance() async {
    print("getBalance");
    var httpClient = Client();
    var web3Client = Web3Client(rpcUrl.value, httpClient);

    AuthController authController = Get.find();

    var credentials = EthPrivateKey.fromHex(authController.privateKey.value);
    var address = await credentials.extractAddress();

    EtherAmount balanceLocal = await web3Client.getBalance(address);
    balance.value = balanceLocal.getValueInUnit(EtherUnit.ether);
  }

  Future<void> sendEth() async {
    // TODO

    // var apiUrl =
    //     "https://arb-goerli.g.alchemy.com/v2/kmaQkTzL0jVfzpP6t9J1R04Y0hr9GGJE";
    // var httpClient = Client();
    // var ethClient = Web3Client(apiUrl, httpClient);
    // AuthController authController = Get.find();
    // var credentials = EthPrivateKey.fromHex(authController.privateKey.value);

    // var res = await ethClient.sendTransaction(
    //   credentials,
    //   Transaction(
    //     to: EthereumAddress.fromHex(authController.publicKey.value),
    //     gasPrice: EtherAmount.inWei(BigInt.one),
    //     // maxGas: 100000,
    //     value: EtherAmount.fromUnitAndValue(EtherUnit.ether,
    //         EtherAmount.inWei(BigInt.one)), //* 1000000000000000000
    //   ),
    // );

    // print("object");
    // print(res);
    var apiUrl =
        "https://eth-goerli.g.alchemy.com/v2/8L-St1WDAiIktazEqEolQfntGghuPR94";

    String _wsUrl =
        "ws://eth-goerli.g.alchemy.com/v2/8L-St1WDAiIktazEqEolQfntGghuPR94";

    var _client = Web3Client(apiUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    AuthController authController = Get.find();

    var _credentials = await _client
        .credentialsFromPrivateKey(authController.privateKey.value);

    await _client.sendTransaction(
        _credentials,
        Transaction(
          to: EthereumAddress.fromHex(authController.publicKey.value),
          gasPrice: EtherAmount.inWei(BigInt.one),
          maxGas: 100000,
          value: EtherAmount.fromUnitAndValue(
            EtherUnit.wei,
            100000000000000000,
          ),
        ),
        chainId: 5);
  }

  Future<void> registerNode(String usernameLocal) async {
    loading.value = true;
    registered.value = false;
    usernameExists.value = false;

    AuthController authController = Get.find();

    bool isRegistered = await Api.checkUserExists(
      authController.publicKey.value,
      authController.privateKey.value,
      usernameLocal,
    );
    if (!isRegistered) {
      String contractAddress = await Api.deploy(
        authController.publicKey.value,
        authController.privateKey.value,
      );
      print(contractAddress);
      if (contractAddress == "") {
        Get.snackbar(
          "Contract Creation Failed!",
          "Something is wrong. Please try again.",
          colorText: AppColors.mainRed,
          backgroundColor: Colors.white70,
        );
      } else {
        nodeContractAddress.value = contractAddress;
        String state = await Api.register(
          authController.publicKey.value,
          authController.privateKey.value,
          usernameLocal,
          contractAddress,
        );
        print(state);
        if (state == "") {
          Get.snackbar(
            "Contract Creation Failed!",
            "Something is wrong. Please try again.",
            colorText: AppColors.mainRed,
            backgroundColor: Colors.white70,
          );
        } else {
          registered.value = true;
          username.value = usernameLocal;
          Get.back();
          Get.snackbar(
            "Contract Creation Successful!",
            "Successfully created the contract.",
            colorText: AppColors.mainBlue,
            backgroundColor: Colors.white70,
          );
        }
      }
    } else {
      usernameExists.value = true;
    }

    loading.value = false;
  }
}
