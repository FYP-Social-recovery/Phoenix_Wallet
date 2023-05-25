import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pheonix_wallet_app/src/components/home_panel_button.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/wallet_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find();
  final WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            "assets/home header image.png",
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 15,
                right: 15,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      "assets/Phoenix logo mini circular.png",
                      width: 40,
                      height: 40,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Phoenix Wallet",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        "assets/user image.png",
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.15,
            ),
            Text(
              "Balance",
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  return Text(
                    walletController.currency.value,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }),
                SizedBox(
                  width: 3,
                ),
                Obx(() {
                  return Text(
                    walletController.balance.value.toStringAsFixed(5),
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: IconButton(
                    splashRadius: 10,
                    tooltip: "Refresh balance",
                    onPressed: () async {
                      await walletController.getBalance();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     walletController.getBalance();
                  //   },
                  //   child: Icon(
                  //     Icons.refresh,
                  //     color: Colors.white,
                  //     size: 15,
                  //   ),
                  // ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomePanelButton(
                    image: "assets/transactions image.png",
                    label: "Transactions",
                    onTap: () {},
                  ),
                  HomePanelButton(
                    image: "assets/gurdians  image.png",
                    label: "Gurdians",
                    onTap: () {},
                  ),
                  HomePanelButton(
                    image: "assets/social recovery image.png",
                    label: "Social Reovery",
                    onTap: () {},
                  ),
                  HomePanelButton(
                    image: "assets/settings image.png",
                    label: "Settings",
                    onTap: () {},
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundRed,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Image.asset(
                          "assets/Line.png",
                          width: 50,
                          height: 4,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Obx(() {
                            return Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Wallet Information",
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                        color: AppColors.mainBlue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                WalletInfoBox(
                                  title: "Public Key",
                                  data: authController.publicKey.value
                                          .substring(0, 6) +
                                      "..." +
                                      authController.publicKey.value.substring(
                                          authController
                                                  .publicKey.value.length -
                                              4),
                                  onCopyTap: () async {
                                    await Clipboard.setData(ClipboardData(
                                        text: authController.publicKey.value));
                                  },
                                  icon: Icons.copy,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                WalletInfoBox(
                                  title: "Social Recovery",
                                  data: walletController.registered.value
                                      ? walletController
                                              .nodeContractAddress.value
                                              .substring(0, 6) +
                                          "..." +
                                          walletController
                                              .nodeContractAddress.value
                                              .substring(walletController
                                                      .nodeContractAddress
                                                      .value
                                                      .length -
                                                  4) +
                                          "\n" +
                                          walletController.username.value
                                      : "Not Registered",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                WalletInfoBox(
                                  title: "Blockchain",
                                  data: walletController.blockchain.value,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                WalletInfoBox(
                                  title: "Network",
                                  data: walletController.network.value,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                WalletInfoBox(
                                  title: "Network type",
                                  data: walletController
                                      .selectedNetworkType.value,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                WalletInfoBox(
                                  title: "Network Layer",
                                  data: walletController
                                              .selectedNetworkLayer.value ==
                                          "L1"
                                      ? "Layer 1"
                                      : "Layer 2",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                WalletInfoBox(
                                  title: "Explorer URL",
                                  data: walletController.explorerURL.value,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Column(
            //     children: [
            //       Text(
            //         networks[authController.selectedNetwork.value]["Name"],
            //         style: TextStyle(
            //           color: Color(0xFF242424),
            //           fontSize: 30,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Container(
            //         decoration: BoxDecoration(
            //           color: Color(0xFFFF6D00).withOpacity(0.2),
            //           borderRadius: BorderRadius.all(
            //             Radius.circular(20),
            //           ),
            //           boxShadow: <BoxShadow>[
            //             BoxShadow(
            //               color: Color(0xFFFF6D00).withOpacity(0.1),
            //               spreadRadius: 5,
            //               blurRadius: 7,
            //               offset: Offset(0, 3), // changes position of shadow
            //             ),
            //           ],
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //             vertical: 7,
            //             horizontal: 15,
            //           ),
            //           child: Text(
            //             authController.selectedNetworkType.value,
            //             style: TextStyle(
            //               color: Color(0xFFFF6D00),
            //               fontSize: 25,
            //               fontWeight: FontWeight.w500,
            //             ),
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Container(
            //             decoration: BoxDecoration(
            //               color:
            //                   authController.selectedNetworkLayer.value == "L1"
            //                       ? Color(0xFFEDCB34).withOpacity(0.4)
            //                       : Color(0xFFEDCB34).withOpacity(0.2),
            //               borderRadius: BorderRadius.all(
            //                 Radius.circular(20),
            //               ),
            //               border: Border.all(
            //                 color: authController.selectedNetworkLayer.value ==
            //                         "L1"
            //                     ? Color(0xFFAF8F00)
            //                     : Color(0xFFEDCB34).withOpacity(0.2),
            //               ),
            //               boxShadow: <BoxShadow>[
            //                 BoxShadow(
            //                   color: Color(0xFFEDCB34).withOpacity(0.1),
            //                   spreadRadius: 5,
            //                   blurRadius: 7,
            //                   offset:
            //                       Offset(0, 3), // changes position of shadow
            //                 ),
            //               ],
            //             ),
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(
            //                 vertical: 10,
            //                 horizontal: 10,
            //               ),
            //               child: Center(
            //                 child: Text(
            //                   "L1",
            //                   style: TextStyle(
            //                     color: Color(0xFFAF8F00),
            //                     fontSize: 20,
            //                     fontWeight: FontWeight.w500,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Container(
            //             decoration: BoxDecoration(
            //               color: Color(0xFFEDCB34).withOpacity(0.2),
            //               borderRadius: BorderRadius.all(
            //                 Radius.circular(20),
            //               ),
            //               boxShadow: <BoxShadow>[
            //                 BoxShadow(
            //                   color: Color(0xFFEDCB34).withOpacity(0.1),
            //                   spreadRadius: 5,
            //                   blurRadius: 7,
            //                   offset:
            //                       Offset(0, 3), // changes position of shadow
            //                 ),
            //               ],
            //             ),
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(
            //                 vertical: 10,
            //                 horizontal: 10,
            //               ),
            //               child: Center(
            //                 child: Text(
            //                   "L2",
            //                   style: TextStyle(
            //                     color: Color(0xFFAF8F00),
            //                     fontSize: 20,
            //                     fontWeight: FontWeight.w500,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 30,
            //       ),
            //       Container(
            //         decoration: BoxDecoration(
            //           color: Color(0xFFFF6D00).withOpacity(0.2),
            //           borderRadius: BorderRadius.all(
            //             Radius.circular(20),
            //           ),
            //           boxShadow: <BoxShadow>[
            //             BoxShadow(
            //               color: Color(0xFFFF6D00).withOpacity(0.1),
            //               spreadRadius: 5,
            //               blurRadius: 7,
            //               offset: Offset(0, 3), // changes position of shadow
            //             ),
            //           ],
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //             vertical: 7,
            //             horizontal: 15,
            //           ),
            //           child: Column(
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: [
            //                   Icon(
            //                     Icons.circle,
            //                     color: Colors.black38,
            //                     size: 10,
            //                   ),
            //                   SizedBox(
            //                     width: 5,
            //                   ),
            //                   Text(
            //                     networks[authController.selectedNetwork.value][
            //                         authController.selectedNetworkType
            //                             .value][authController
            //                         .selectedNetworkLayer.value]["FullName"],
            //                     style: TextStyle(
            //                       color: Color(0xFF242424),
            //                       fontSize: 20,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: 30,
            //               ),
            //               Text(
            //                 "Balance",
            //                 style: TextStyle(
            //                   color: Color(0xFF000000),
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.w400,
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Text(
            //                 authController.balance.value.toString() +
            //                     " " +
            //                     authController.currency.value,
            //                 style: TextStyle(
            //                   color: Color(0xFF000000),
            //                   fontSize: 40,
            //                   fontWeight: FontWeight.w200,
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 5,
            //               ),
            //               Text(
            //                 "\$0.0 USD",
            //                 style: TextStyle(
            //                   color: Color(0xFF000000),
            //                   fontSize: 25,
            //                   fontWeight: FontWeight.w200,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 30,
            //       ),
            //       Container(
            //         decoration: BoxDecoration(
            //           color: Color(0xFFFF6D00).withOpacity(0.2),
            //           borderRadius: BorderRadius.all(
            //             Radius.circular(20),
            //           ),
            //           boxShadow: <BoxShadow>[
            //             BoxShadow(
            //               color: Color(0xFFFF6D00).withOpacity(0.1),
            //               spreadRadius: 5,
            //               blurRadius: 7,
            //               offset: Offset(0, 3), // changes position of shadow
            //             ),
            //           ],
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //             vertical: 7,
            //             horizontal: 15,
            //           ),
            //           child: Column(
            //             children: [
            //               Text(
            //                 "Public Key",
            //                 style: TextStyle(
            //                   color: Color(0xFF000000),
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.w400,
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Text(
            //                 authController.publicKey.value.substring(0, 4) +
            //                     "...." +
            //                     authController.publicKey.value.substring(
            //                         authController.publicKey.value.length - 4),
            //                 style: TextStyle(
            //                   color: Color(0xFF000000),
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.w200,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 50,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 30,
            //         ),
            //         child: Container(
            //           decoration: BoxDecoration(
            //             color: Color(0xFFFF6D00).withOpacity(0.2),
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(20),
            //             ),
            //             boxShadow: <BoxShadow>[
            //               BoxShadow(
            //                 color: Color(0xFFFF6D00).withOpacity(0.1),
            //                 spreadRadius: 5,
            //                 blurRadius: 7,
            //                 offset: Offset(0, 3), // changes position of shadow
            //               ),
            //             ],
            //           ),
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(
            //               vertical: 7,
            //               horizontal: 15,
            //             ),
            //             child: Column(
            //               children: [
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   mainAxisSize: MainAxisSize.min,
            //                   children: [
            //                     Icon(
            //                       Icons.circle,
            //                       color: Colors.black38,
            //                       size: 10,
            //                     ),
            //                     SizedBox(
            //                       width: 5,
            //                     ),
            //                     Text(
            //                       "Node contract status",
            //                       style: TextStyle(
            //                         color: Color(0xFF242424),
            //                         fontSize: 20,
            //                         fontWeight: FontWeight.w500,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 SizedBox(
            //                   height: 10,
            //                 ),
            //                 Text(
            //                   "Not yet registered. Please go to social recovery menu page and register a node contract to use social recovery feature.",
            //                   style: TextStyle(
            //                     color: Color(0xFF000000),
            //                     fontSize: 20,
            //                     fontWeight: FontWeight.w300,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}

class WalletInfoBox extends StatelessWidget {
  const WalletInfoBox({
    super.key,
    required this.title,
    required this.data,
    this.icon = null,
    this.onCopyTap,
  });

  final String title;
  final String data;
  final IconData? icon;
  final Function()? onCopyTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 120,
                  child: Text(
                    title,
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: AppColors.boxText,
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    data,
                    maxLines: 2,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: AppColors.mainBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                icon == null
                    ? Container()
                    : SizedBox(
                        width: 15,
                      ),
              ],
            ),
          ),
          icon == null
              ? Container()
              : Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    splashColor: AppColors.mainBlue,
                    splashRadius: 25,
                    onPressed: onCopyTap,
                    tooltip: "Copy to clipboard",
                    icon: Icon(
                      icon,
                      color: AppColors.mainBlue,
                      size: 15,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
