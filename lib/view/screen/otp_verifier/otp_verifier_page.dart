import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

import 'otp_verifier_controller.dart';

class OTPVerifierPage extends GetView<OTPVerifierController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OTPVerifierController>(
        init: OTPVerifierController(),
        builder: (OTPVerifierController value) {
          return Scaffold(
            body: Stack(children: [
              // background
              Positioned.fill(
                child: Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(Images.login_background),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  ),
                )),
              ),

              // Card
              Positioned(
                width: DeviceUtils.getScaledWidth(context, 0.9),
                height: 393,
                top: DeviceUtils.getScaledWidth(context, 0.4),
                left: DeviceUtils.getScaledWidth(context, 0.05),
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Color(0xa0ffffff),
                  ),
                  child: Column(
                    children: [
                      // logo
                      _logoWidget(context),

                      // title verifier OTP
                      _verifierOTPWidget(context),

                      // input username
                      _usernameEnterWidget(context),

                      // login button
                      _onBtnLoginTap(context),
                    ],
                  ),
                ),
              )
            ]),
          );
        });
  }

  ///
  /// _logo Widget
  ///
  Widget _logoWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
      width: DeviceUtils.getScaledWidth(context, 1),
      height: 79,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 96,
              height: 79,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.logo_app),
                  fit: BoxFit.cover,
                ),
              )),
        ],
      ),
    );
  }

  ///
  /// _verifier OTP Widget
  ///
  Widget _verifierOTPWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_DEFAULT),
      width: DeviceUtils.getScaledWidth(context, 0.7),
      height: 89,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Xác thực tài khoản",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff2A3547),
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              fontFamily: "Nunito Sans",
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: DeviceUtils.getScaledWidth(context, 0.7),
            height: 58,
            child: const Text(
              "Mã xác thực sẽ được gửi đến số điện thoại của bạn",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff2A3547),
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// _usernameEnterWidget
  ///
  Widget _usernameEnterWidget(BuildContext context) {
    return SizedBox(
        width: DeviceUtils.getScaledWidth(context, 0.7),
        height: 58,
        child: Form(
          key: controller.formKey,
          child: PinCodeTextField(
            validator: (val){
              if (val!.length < 6) {
                return "";
              } else {
                return null;
              }
            },
            appContext: context,
            pastedTextStyle: TextStyle(
              color: Colors.green.shade600,
              fontWeight: FontWeight.bold,
            ),
            length: 6,
            obscureText: true,
            obscuringCharacter: '*',
            // obscuringWidget: FlutterLogo(
            //   size: 24,
            // ),
            blinkWhenObscuring: true,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
            ),
            cursorColor: Colors.black,
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            errorAnimationController: controller.errorController,
            controller: controller.textEditingController,
            keyboardType: TextInputType.number,
            // ignore: prefer_const_literals_to_create_immutables
            boxShadows: [
              const BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
                blurRadius: 10,
              )
            ],
            onCompleted: (v) {
              // print("Completed $v");
              controller.onBtnCompleteTap();
            }, 
            onChanged: (value) {
            },
            beforeTextPaste: (text) {
              // print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
          ),
        ));
  }

  ///
  /// _on Btn Login Tap
  ///
  Widget _onBtnLoginTap(BuildContext context) {
    return GestureDetector(
      // onLoginBtnClick
      onTap: () => controller.onBtnCompleteTap(),
      child: Container(
        margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_LARGE),
        width: DeviceUtils.getScaledWidth(context, 0.7),
        height: 48,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: DeviceUtils.getScaledWidth(context, 0.7),
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(
                top: 12,
                bottom: 9,
              ),
              child: const Text(
                "Tiếp tục",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff0d5da0),
                  fontSize: 20,
                  fontFamily: "Nunito Sans",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
