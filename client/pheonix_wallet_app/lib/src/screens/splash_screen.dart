import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pheonix_wallet_app/src/apis/api.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import '../components/component_home.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  static const routeName = splashScreen;

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/waves upside.png",
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: 500,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(
                          flex: 2,
                        ),
                        Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  width: 150,
                                  height: 150,
                                ),
                                Image.asset(
                                  "assets/Phoenix logo.png",
                                  width: 122,
                                  height: 120,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Phoenix Wallet",
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: AppColors.mainBlue,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        Obx(
                          () => authController.splashScreenLoading.value
                              ? LoadingAnimationWidget.staggeredDotsWave(
                                  color: AppColors.mainBlue,
                                  size: 70,
                                )
                              : authController.loading.value
                                  ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: AppColors.mainBlue,
                                      size: 70,
                                    )
                                  : Column(
                                      children: [
                                        PrimaryButton(
                                          buttonText: "Create Wallet",
                                          onPressed: () async {
                                            Api api = Api();
                                            String m =
                                                "march swing weasel doctor post govern settle cake pig sad flame used";
                                            String pk =
                                                "0x20543FD8D854d500121215Abc542531987f6bc2e";
                                            String sk =
                                                "58d0efedba9a8a61b2ac3f188dd079782e07aed904cdbc0e3340e073e85c7655";
                                            // String en =
                                            //     "b'\x87\xdb\x83\xe2 *\x8a\xca1\x19\x02\xa4\x97\xb5aw'";
                                            String ca =
                                                "0xAE784d6BF8A718B7a166E4CacC50Dcb54474e22A";

                                            dynamic secretOwner = {
                                              "m":
                                                  "explain kingdom make magic page carpet initial birth filter exercise stadium gun",
                                              "sk":
                                                  "372172e68ad058d5e07ae9ea13d412b36f6e25593ea9d8e00c3cbf93ecccfadc",
                                              "pk":
                                                  "0xD4d37C895D9c4b183B1c5DAd2C56Ff3182D001D4",
                                              "c":
                                                  "0xc2b2904A2E8Dad66e1CeC642CAb2E73C527BA6b6",
                                              "u": "Bob"
                                            };

                                            dynamic shareholder1 = {
                                              "m":
                                                  "march swing weasel doctor post govern settle cake pig sad flame used",
                                              "sk":
                                                  "58d0efedba9a8a61b2ac3f188dd079782e07aed904cdbc0e3340e073e85c7655",
                                              "pk":
                                                  "0x20543FD8D854d500121215Abc542531987f6bc2e",
                                              "c":
                                                  "0xAE784d6BF8A718B7a166E4CacC50Dcb54474e22A",
                                              "u": "Alice"
                                            };

                                            dynamic shareholder2 = {
                                              "m":
                                                  "foot grass express lake sweet battle absurd marriage leisure ask adjust replace",
                                              "sk":
                                                  "75fa0bb3ae072458b0a42fe3f395620c09652d36cc0a53a775738ed45b89d716",
                                              "pk":
                                                  "0x4562D1cb11E4B3d885e4cB8A0574Bb18c7e5fBeC",
                                              "c":
                                                  "0x2A16c9190272Fc0B45400E567418BA44cF8f1FC8",
                                              "u": "Charlie"
                                            };

                                            dynamic shareholder3 = {
                                              "m":
                                                  "nuclear sausage habit symptom term connect spice skin seek beauty uncle destroy",
                                              "sk":
                                                  "31f5fa3dba4117af74862e52cfd6392538475ae7691915905d58ead6745fb1bc",
                                              "pk":
                                                  "0xd9626a4eF44Ea8cab83798668b90C74A76F6f6DB",
                                              "c":
                                                  "0x5a2F9e9c4c36Ac1cA6E485c9235b7B532cB6C09f",
                                              "u": "David"
                                            };

                                            String byteString =
                                                "b'P\x8fV\x1aB\xe9\xeeE\x9c\xf8\xb5Vi\xebO\xb3'";
                                            String en =
                                                "107082484481430705169251899735211200435";

                                            // dynamic result3 =
                                            //     await api.mnemonicToEntropy(
                                            //   secretOwner["m"],
                                            // );
                                            // print(result3.toString());

                                            // dynamic result =
                                            //     await api.distribute(
                                            //   true,
                                            //   secretOwner["pk"],
                                            //   secretOwner["sk"],
                                            //   secretOwner["c"],
                                            //   "mailavishka@gail.com",
                                            //   en,
                                            // );
                                            // print(result);

                                            // String otpHash =
                                            //     "4332cd76590d0efdbd8d067acf531546da2ba0a67c538440e7defedbea48d1dc";

                                            // dynamic result =
                                            //     await api.getOTPHash(
                                            //   "1907",
                                            // );
                                            // print(result);

                                            // print(otpHash == result);

                                            // dynamic result = await api
                                            //     .checkRequestsForBeAHolder(
                                            //   shareholder1["pk"],
                                            //   shareholder1["sk"],
                                            //   shareholder1["c"],
                                            // );
                                            // print(result);

                                            // dynamic result =
                                            //     await api.acceptInvitation(
                                            //   shareholder3["pk"],
                                            //   shareholder3["sk"],
                                            //   shareholder3["c"],
                                            //   secretOwner["pk"],
                                            // );
                                            // print(result);

                                            // dynamic result =
                                            //     await api.getHolderStatus(
                                            //   secretOwner["pk"],
                                            //   secretOwner["sk"],
                                            //   secretOwner["c"],
                                            // );
                                            // print(result);

                                            // Create new account -> deplly -> register

                                            // dynamic result1 = await api
                                            //     .generateMnemonicForNewAccount();
                                            // print(result1);

                                            // dynamic result2 = await api
                                            //     .importWalletFromMnemonic(
                                            //         result1);
                                            // print(result2);

                                            // dynamic result3 = await api.deploy(
                                            //   shareholder3["pk"],
                                            //   shareholder3["sk"],
                                            // );
                                            // print(result3);
                                            // shareholder3["c"] = result3;

                                            // dynamic result4 =
                                            //     await api.register(
                                            //         shareholder3["pk"],
                                            //         shareholder3["sk"],
                                            //         shareholder3["u"],
                                            //         shareholder3["c"]);
                                            // print(result4);

                                            ///////////////////////////////////////////////////////////////////
                                            authController.loading.value = true;

                                            await authController.createWallet();

                                            authController.loading.value =
                                                false;
                                          },
                                          color: AppColors.mainBlue,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        OutlineButton(
                                          buttonText: "Import Wallet",
                                          onPressed: () {
                                            Get.toNamed(importWalletScreen);
                                          },
                                          color: AppColors.mainBlue,
                                        ),
                                      ],
                                    ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
