import 'widgets/custom_auth_btns.dart';
import 'widgets/custom_auth_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_text.dart';
import '../../../const/const.dart';
import '../../../controller/auth_controller.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with TickerProviderStateMixin {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    // AuthController authController = Get.find();
    print('AuthView ===========');

    return Scaffold(
              resizeToAvoidBottomInset: false,

      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: GetBuilder<AuthController>(
          builder: (authController) => Container(
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/burger_bg.jpg'),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: TabBar(
                    splashBorderRadius: BorderRadius.circular(8),
                    indicatorColor: colorIconDM,
                    controller: tabController,
                    tabs: [
                      CustomText(text: 'Sign In', fontSize: 18),
                      CustomText(text: 'Sign Up', fontSize: 18),
                    ],
                  ),
                ),
                Form(
                  key: formkey,
                  child: Container(
                    width: 300,
                    height: 320,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        //sign in
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomAuthTextFiled(
                              isEmail: true,
                              controller:
                                  authController.signINemailTextController,
                            ),
                            const SizedBox(height: 10),
                            CustomAuthTextFiled(
                              controller:
                                  authController.signINpasswordTextController,
                              isEmail: false,
                              isVisible: false,
                            ),
                            const Spacer(),
                            CustomAuthBtns(
                              onTapGoogle: () {
                                authController.googleSign(context);
                              },
                              onTapSign: () {
                                if (formkey.currentState!.validate()) {
                                  authController
                                      .signINwithEmailANDpassword(context);
                                }
                              },
                            )
                          ],
                        ),
                        //sign up
                        Column(
                          children: [
                            CustomAuthTextFiled(
                              controller:
                                  authController.signUPemailTextController,
                            ),
                            const SizedBox(height: 10),
                            CustomAuthTextFiled(
                              controller:
                                  authController.signUPpasswordTextController,
                              isEmail: false,
                              isVisible: false,
                            ),
                            const SizedBox(height: 10),
                            CustomAuthTextFiled(
                              controller:
                                  authController.confirmPasswordController,
                              isEmail: false,
                              isVisible: false,
                              isConfirmPassword: true,
                            ),
                            const Spacer(),
                            CustomAuthBtns(
                              isLogIn: false,
                              onTapGoogle: () {
                                authController.googleSign(context);
                              },
                              onTapSign: () {
                                if (formkey.currentState!.validate()) {
                                  authController
                                      .signUPwithEmailANDpassword(context);
                                }
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
