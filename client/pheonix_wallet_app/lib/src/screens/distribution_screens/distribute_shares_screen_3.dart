import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/controller_home.dart';
import '../../components/component_home.dart';

class DistributeSharesScreen3 extends StatefulWidget {
  static const routeName = distributeSharesScreen3;

  @override
  _DistributeSharesScreen3State createState() =>
      _DistributeSharesScreen3State();
}

class _DistributeSharesScreen3State extends State<DistributeSharesScreen3> {
  final WalletController walletController = Get.find();

  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image

  int capturState = 0;

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
        child: Padding(
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
                "Fingerprint Scan",
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
                                        child: CircularProgressIndicator(),
                                      )
                                    : CameraPreview(controller!))
                        : Container(),

                    //if capture state == 1

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

                    SizedBox(
                      height: capturState == 0 ? 60 : 30,
                    ),
                    PrimaryButton(
                      buttonText: capturState == 0
                          ? "Proceed"
                          : capturState == 1
                              ? "Capture"
                              : "Distribute",
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
                        } else {
                          setState(() {
                            capturState = 0;
                          });
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
                    Text(
                      "*This will require to recover the wallet",
                      style: TextStyle(
                        color: AppColors.mainBlueLight,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
      ),
    );
  }
}
