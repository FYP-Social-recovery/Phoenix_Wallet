import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/services/nodeService.dart';
import 'package:web3dart/web3dart.dart';

import 'controller_home.dart';

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
    var httpClient = Client();
    var ethClient = Web3Client(rpcUrl.value, httpClient);

    AuthController authController = Get.find();
    var credentials = EthPrivateKey.fromHex(authController.privateKey.value);
    var address = await credentials.extractAddress();

    EtherAmount balanceLocal = await ethClient.getBalance(address);
    balance.value = balanceLocal.getValueInUnit(EtherUnit.ether);
    print(balance.value);
  }

  Future<void> checkNodeExistWithUsername(String username) async {
    NodeService nodeService = NodeService();
    await nodeService.init2();
    var result = await nodeService.ask("isExists", [username]);
    registered.value = result[0];
    print(registered.value);
  }

  Future<void> checkNodeExistWithPublicKey() async {
    // NodeService nodeService = NodeService();
    // await nodeService.init2();

    // AuthController authController = Get.find();

    // var result = await nodeService.ask(
    //     "getContractAddressByPublicAddress", [authController.publicKey.value]);

    // if (result[0] == null) {
    //   registered.value = false;
    // } else {
    //   registered.value = result[0];
    // }

    // print(registered.value);
  }
}
