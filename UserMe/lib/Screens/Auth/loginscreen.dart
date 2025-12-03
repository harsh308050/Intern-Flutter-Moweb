import 'dart:convert';
import 'dart:developer';
import 'package:UserMe/Screens/Home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/CM.dart';
import '../../Components/CustomButton.dart';
import '../../Components/CustomTextButton.dart';
import '../../Components/CustomTextField.dart';

import '../../utils/SharedPrefHelper.dart';
import '../../utils/utils.dart';
import 'package:flutter/foundation.dart';

import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';
import 'data/datasource.dart';
import 'data/repository.dart';
import 'model/user_model.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onSwitchTab;
  const LoginScreen({super.key, this.onSwitchTab});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserBloc userBloc = UserBloc(repository: Repository(DataSource()));
  UserModel? model;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? "emilys" : "",
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? "emilyspass" : "",
  );

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, AppState>(
        bloc: userBloc,
        listener: (context, state) async {
          if (state.status == Status.success) {
            await sharedPrefsaveData(
              sharedPrefKeys.userDataKey,
              jsonEncode(state.user?.toJson()),
            );
            var token = await sharedPrefsaveData(
              sharedPrefKeys.accessTokenKey,
              state.user?.accessToken,
            );
            log('======================Token saved: $token');
            var refreshtoken = await sharedPrefsaveData(
              sharedPrefKeys.refreshTokenKey,
              state.user?.refreshToken,
            );
            log('======================Refresh Token saved: $refreshtoken');
            callNextScreenAndClearStack(context, Homepage());
          } else if (state.status == Status.failed) {
            showSnackBar(context, UIStrings.loginFailed, UIColours.errorColor);
          }
        },
        child: BlocBuilder<UserBloc, AppState>(
          bloc: userBloc,
          builder: (context, state) => SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: UISizes.aroundPadding,
                left: UISizes.aroundPadding,
                right: UISizes.aroundPadding,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        UIStrings.loginTitle,
                        style: TextStyle(
                          fontSize: UISizes.titleFontSize,
                          color: UIColours.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SbhMain(),
                      CustomTextfield(
                        focusNode: emailFocusNode,
                        controller: emailController,
                        hintText: UIStrings.emailHint,
                        labelText: UIStrings.emailLabel,
                        prefixIcon: UIIcons.emailIcon,
                        validator: (value) {
                          return inputvalidator(value, "Username");
                        },
                      ),
                      SbhSub(),
                      CustomTextfield(
                        focusNode: passwordFocusNode,
                        controller: passwordController,
                        hintText: UIStrings.passwordHint,
                        labelText: UIStrings.passwordLabel,
                        prefixIcon: UIIcons.passwordIcon,
                        onSuffixPressed: () {
                          setState(() {
                            obsecureText = !obsecureText;
                          });
                        },
                        obscureText: obsecureText,
                        suffixIcon: obsecureText == true
                            ? UIIcons.passwordEyeIcon.icon
                            : UIIcons.passwordEyeDisabledIcon.icon,
                        validator: (value) {
                          return inputvalidator(value, "Password");
                        },
                      ),
                      SbhSub(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextButton(
                            buttonText: UIStrings.forgotPassword,
                          ),
                        ],
                      ),

                      SbhMin(),
                      CustomButton(
                        isLoading: state.status == Status.busy ? true : false,
                        buttonText: UIStrings.loginButton,
                        onButtonPressed: () {
                          FocusScope.of(context).unfocus();

                          if (formKey.currentState!.validate()) {
                            userBloc.add(
                              UserEvent(
                                username: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          } else {
                            if (emailController.text.isEmpty ||
                                inputvalidator(emailController.text, "Email") !=
                                    null) {
                              focusNodeRoute(emailFocusNode, context);
                            } else if (passwordController.text.isEmpty ||
                                inputvalidator(
                                      passwordController.text,
                                      "Password",
                                    ) !=
                                    null) {
                              focusNodeRoute(passwordFocusNode, context);
                            }
                          }
                        },
                      ),
                      SbhSub(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            UIStrings.newOnApp,
                            style: TextStyle(
                              color: UIColours.greyShade,
                              fontSize: UISizes.inputFontSize,
                            ),
                          ),
                          CustomTextButton(
                            buttonText: UIStrings.signupButton,
                            onTextButtonPressed: () {
                              FocusScope.of(context).unfocus();
                              widget.onSwitchTab!();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
