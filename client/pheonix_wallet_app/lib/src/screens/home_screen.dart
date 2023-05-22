import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find();

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
              height: 60,
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
                Text(
                  "Eth",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "1.234.567,90",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
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
                      Text(
                        "Wallet Information",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColors.mainBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      WalletInfoBox(
                        title: "Public Key",
                        data: "0x25R65...45B",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      WalletInfoBox(
                        title: "Social Recovery",
                        data: "Not Registered",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      WalletInfoBox(
                        title: "Blockchain",
                        data: "Ethereum",
                      ),
                      SizedBox(
                        height: 10,
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
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
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
            Text(
              data,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: AppColors.mainBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePanelButton extends StatelessWidget {
  const HomePanelButton({
    super.key,
    required this.onTap,
    required this.image,
    required this.label,
  });

  final Function()? onTap;
  final String image;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.mainBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Image.asset(
                image,
                width: 35,
                height: 35,
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: AppColors.mainBlue,
                fontSize: 10,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
