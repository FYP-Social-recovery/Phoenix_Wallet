import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
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
  var selectedNetworkLayer = networkLayers[0].obs;

  var network = "".obs;
  var currency = "".obs;
  var rpcUrl = "".obs;
  var chainId = 0.obs;
  var explorerURL = "".obs;

  //Recovery info
  var registered = false.obs;
  var nodeContractAddress = "".obs;
  var username = "".obs;
  var shareholderRequests = [""].obs;
  var shareholderRequestStatus = [{}].obs;

  var usernameExists = false.obs;

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
    print(balance.value);
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

  Future<String> checkNodeExistWithPublicKey() async {
    print("checkNodeExistWithPublicKey");
    AuthController authController = Get.find();
    PublicService publicService = PublicService();
    await publicService.initMethod();

    var result = await publicService.ask("getContractAddressByPublicAddress",
        [EthereumAddress.fromHex(authController.publicKey.value)]);
    print(result);

    return result[0].toString();
    // [0x0000000000000000000000000000000000000000]
  }

  Future<void> registerNode(String username) async {
    registered.value = false;
    print("registerNode");
    bool isRegistered = await checkNodeExistWithUsername(username);
    if (!isRegistered) {
      await deployNodeContract();
    }
  }

  Future<bool> checkNodeExistWithUsername(String username) async {
    print("checkNodeExistWithUsername");
    PublicService publicService = PublicService();
    await publicService.initMethod();

    var result = await publicService.ask("isExists", [username]);
    registered.value = result[0];

    print(registered.value);

    return result[0];
  }

  Future<void> deployNodeContract() async {
    AuthController authController = Get.find();
    print(authController.privateKey.value);
    print(authController.publicKey.value);

    var map = new Map<String, dynamic>();
    map['prv'] =
        '6261ced5f7996c96aac73be45487cbf2f95afead4931e27a6657b101bb823029';
    // map['prv'] =
    //     '58d0efedba9a8a61b2ac3f188dd079782e07aed904cdbc0e3340e073e85c7655';
    map['pub'] = '0x28e642748dcaec3e82ef9a7a145eca9c09227b82'.toUpperCase();
    // map['pub'] = '0x20543FD8D854d500121215Abc542531987f6bc2e';

    var uri = Uri.https(serverURL, 'node-contract/deploy');
    final response = await http.post(uri, body: map);
    print(response);
    var responseData = json.decode(response.body);
    print(responseData);
    //0xdBe31A0F6d5Aac9F4CF88FcCf9F04C1Cc88dBE53
    return;
  }

  Future<void> usernameRegistration(String username) async {
    print("usernameRegistration");

    NodeService nodeService = NodeService();
    await nodeService.initMethod();
    AuthController authController = Get.find();

    var result = await nodeService.callFunction(
        "registerToPublicContract",
        [username],
        '58d0efedba9a8a61b2ac3f188dd079782e07aed904cdbc0e3340e073e85c7655'); //authController.privateKey.value
    print(result);

    return;
  }

  Future<void> addShareholders(List<String> shareHolders) async {
    shareHolders = ["0x28e642748dcaec3e82ef9a7a145eca9c09227b82"];
    print("addShareholders");

    AuthController authController = Get.find();
    NodeService nodeService = NodeService();
    await nodeService.initMethod();

    for (String shareHolder in shareHolders) {
      var result = await nodeService.callFunction(
          "addTemporaryShareHolders",
          [EthereumAddress.fromHex(shareHolder)],
          authController.privateKey.value);
      print(result);
    }

    // [0x0000000000000000000000000000000000000000]
  }

  Future<void> addGurdians(List<String> shareHolders) async {
    shareHolders = ["0x28e642748dcaec3e82ef9a7a145eca9c09227b82"];
    print("addGurdians");

    NodeService nodeService = NodeService();
    await nodeService.initMethod();
    AuthController authController = Get.find();

    for (String shareHolder in shareHolders) {
      var result = await nodeService.callFunction(
          "addTemporaryShareHolders",
          [EthereumAddress.fromHex(shareHolder)],
          authController.privateKey
              .value); //'58d0efedba9a8a61b2ac3f188dd079782e07aed904cdbc0e3340e073e85c7655'
      print(result);
    }
  }

  Future<void> refreshContractState() async {
    print("refreshContractState");
    NodeService nodeService = NodeService();
    await nodeService.initMethod();
    AuthController authController = Get.find();

    var result = await nodeService.callFunction(
        "refreshState", [], authController.privateKey.value);

    print(result);
  }

  Future<void> gurdianStatus() async {
    print("gurdianStatus");

    await refreshContractState();
    NodeService nodeService = NodeService();
    await nodeService.initMethod();
    AuthController authController = Get.find();

    var result = await nodeService.ask("getMyState", []);
    print(result);
  }
}
