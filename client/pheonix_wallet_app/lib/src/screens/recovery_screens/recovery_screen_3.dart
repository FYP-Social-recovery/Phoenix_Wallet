import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/controller_home.dart';
import '../../components/component_home.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pheonix_wallet_app/src/apis/api_home.dart';

class RecoveryScreen3 extends StatefulWidget {
  static const routeName = recoveryScreen3;

  @override
  _RecoveryScreen3State createState() => _RecoveryScreen3State();
}

class _RecoveryScreen3State extends State<RecoveryScreen3> {
  final WalletController walletController = Get.find();
  final AuthController authController = Get.find();

  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image

  int capturState = 0;

  String recoverdPublicKey = "";
  String recoverdPrivateKey = "";

  @override
  void initState() {
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("NO any camera found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBlue,
      body:
          // Container(
          //     child: Column(children: [
          //   Container(
          //       height: 300,
          //       width: 400,
          //       child: controller == null
          //           ? Center(child: Text("Loading Camera..."))
          //           : !controller!.value.isInitialized
          //               ? Center(
          //                   child: CircularProgressIndicator(),
          //                 )
          //               : CameraPreview(controller!)),
          //   ElevatedButton.icon(
          //     //image capture button
          //     onPressed: () async {
          //       try {
          //         if (controller != null) {
          //           //check if contrller is not null
          //           if (controller!.value.isInitialized) {
          //             //check if controller is initialized
          //             image = await controller!.takePicture(); //capture image
          //             setState(() {
          //               //update UI
          //             });
          //           }
          //         }
          //       } catch (e) {
          //         print(e); //show error
          //       }
          //     },
          //     icon: Icon(Icons.camera),
          //     label: Text("Capture"),
          //   ),
          //   Container(
          //     //show captured image
          //     padding: EdgeInsets.all(30),
          //     child: image == null
          //         ? Text("No image captured")
          //         : Image.file(
          //             File(image!.path),
          //             height: 300,
          //           ),
          //     //display captured image
          //   )
          // ])),

          SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          alignment: Alignment.center,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.white.withOpacity(0.7),
                                blurRadius: 1,
                                blurStyle: BlurStyle.outer,
                                offset: Offset(2, 2),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppColors.mainBlue,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      capturState == 3 ? "Recovered keys" : "Fingerprint Scan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //if capture state == 0
                          capturState == 0
                              ? Image.asset(
                                  "assets/fingerprint block image.png",
                                  width: 166,
                                  height: 150,
                                )
                              : Container(),
                          capturState == 0
                              ? SizedBox(
                                  height: 35,
                                )
                              : Container(),
                          capturState == 0
                              ? Text(
                                  "Please take a\nimage of your thumb.\nThis will generate a\nfingerprint for you.",
                                  style: TextStyle(
                                    color: AppColors.mainBlueLight,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Container(),

                          //if capture state == 1

                          // Display Camera

                          capturState == 1
                              ? Container(
                                  height: 300,
                                  child: controller == null
                                      ? Center(
                                          child: Text(
                                            "Loading Camera ...",
                                            style: TextStyle(
                                              color: AppColors.mainBlueLight,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      : !controller!.value.isInitialized
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : CameraPreview(controller!))
                              : Container(),

                          //if capture state == 2

                          // Display Captured image

                          capturState == 2
                              ? image == null
                                  ? Text(
                                      "No image captured",
                                      style: TextStyle(
                                        color: AppColors.mainBlueLight,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Image.file(
                                      File(image!.path),
                                      height: 300,
                                    )
                              : Container(),

                          //if capture state == 3

                          // Display Recoverd Key

                          capturState == 3
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Private Key :",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      recoverdPrivateKey,
                                      style: TextStyle(
                                        color: AppColors.mainBlueLight,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              : Container(),
                          capturState == 3
                              ? SizedBox(
                                  height: 15,
                                )
                              : Container(),
                          capturState == 3
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Public Key :",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      recoverdPublicKey,
                                      style: TextStyle(
                                        color: AppColors.mainBlueLight,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              : Container(),

                          SizedBox(
                            height: capturState == 0
                                ? 60
                                : capturState == 3
                                    ? 60
                                    : 30,
                          ),
                          PrimaryButton(
                            buttonText: capturState == 0
                                ? "Proceed"
                                : capturState == 1
                                    ? "Capture"
                                    : capturState == 2
                                        ? "Recover"
                                        : "Finish",
                            onPressed: () async {
                              // Get.toNamed(distributeSharesScreen2);
                              if (capturState == 0) {
                                setState(() {
                                  capturState = 1;
                                  loadCamera();
                                });
                              } else if (capturState == 1) {
                                try {
                                  if (controller != null) {
                                    //check if contrller is not null
                                    if (controller!.value.isInitialized) {
                                      //check if controller is initialized
                                      image = await controller!
                                          .takePicture(); //capture image
                                      setState(() {
                                        capturState = 2;
                                      });
                                    }
                                  }
                                } catch (e) {
                                  print(e); //show error
                                }
                              } else if (capturState == 2) {
                                walletController.loading.value = true;

                                dynamic result = await Api.recover(
                                  true,
                                  authController.publicKey.value,
                                  authController.privateKey.value,
                                  walletController.nodeContractAddress.value,
                                  walletController.username.value,
                                  walletController.generatedSigendOTP.value,
                                  walletController.otp.value,
                                );

                                if (result > 3) {
                                  authController.entrophy.value = result;
                                  String mnemonic =
                                      await Api.entrophyToMnemonic(result);

                                  List<String> keyList =
                                      await Api.importWalletFromMnemonic(
                                          mnemonic);

                                  setState(() {
                                    recoverdPublicKey = keyList[1];
                                    recoverdPublicKey = keyList[0];
                                  });

                                  Get.snackbar(
                                    "Successful!",
                                    "Successfully recovered the wallet.",
                                    colorText: AppColors.mainBlue,
                                    backgroundColor: Colors.white70,
                                  );
                                  setState(() {
                                    capturState = 3;
                                  });
                                } else {
                                  Get.snackbar(
                                    "Failed!",
                                    "Something is wrong. Please try again.",
                                    colorText: AppColors.mainRed,
                                    backgroundColor: Colors.white70,
                                  );
                                }

                                walletController.loading.value = false;
                              } else if (capturState == 3) {
                                Get.back();
                                Get.back();
                                Get.back();
                              }
                            },
                            color: Color(0xFF007CFF).withOpacity(0.5),
                          ),
                          capturState == 2
                              ? SizedBox(
                                  height: 30,
                                )
                              : Container(),
                          capturState == 2
                              ? PrimaryButton(
                                  buttonText: "Re-Capture",
                                  onPressed: () {
                                    setState(() {
                                      capturState = 1;
                                      loadCamera();
                                    });
                                  },
                                  color: Color(0xFF007CFF).withOpacity(0.5),
                                )
                              : Container(),

                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
              walletController.loading.value
                  ? Container(
                      color: Colors.black54,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    )
                  : Container(),
              walletController.loading.value
                  ? Align(
                      alignment: Alignment.center,
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white,
                        size: 70,
                      ),
                    )
                  : Container(),
            ],
          );
        }),
      ),
    );
  }
}
