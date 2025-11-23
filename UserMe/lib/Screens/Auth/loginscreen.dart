import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/CustomButton.dart';
import '../../Components/CustomTextButton.dart';
import '../../Components/CustomTextField.dart';
import '../../components/CM.dart';
import '../../routes/routes.dart';
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
  const LoginScreen({super.key});

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
      backgroundColor: UIColours.white,
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
            log('Token saved: $token');
            Routes.navigateToHomePage(context, user: state.user);
          } else if (state.status == Status.failed) {
            CM.showSnackBar(
              context,
              UIStrings.loginFailed,
              UIColours.errorColor,
            );
          }
        },
        child: BlocBuilder<UserBloc, AppState>(
          bloc: userBloc,
          builder: (context, state) => SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: UISizes.aroundPadding * 5,
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
                      CM.SbhMain(),
                      CustomTextfield(
                        focusNode: emailFocusNode,
                        controller: emailController,
                        hintText: UIStrings.emailHint,
                        labelText: UIStrings.emailLabel,
                        prefixIcon: UIIcons.emailIcon,
                        validator: (value) {
                          return CM.inputvalidator(value, "Email");
                        },
                      ),
                      CM.SbhSub(),
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
                          return CM.inputvalidator(value, "Password");
                        },
                      ),
                      CM.SbhSub(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextButton(
                            buttonText: UIStrings.forgotPassword,
                          ),
                        ],
                      ),

                      CM.SbhMin(),
                      CustomButton(
                        isLoading: state.status == Status.busy ? true : false,
                        buttonText: UIStrings.loginButton,
                        onButtonPressed: () {
                          FocusScope.of(context).unfocus();
                          if (emailController.text.isEmpty) {
                            focusNodeRoute(emailFocusNode, context);
                            return;
                          }
                          if (passwordController.text.isEmpty) {
                            focusNodeRoute(passwordFocusNode, context);
                            return;
                          }
                          if (formKey.currentState!.validate()) {
                            userBloc.add(
                              UserEvent(
                                username: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                      ),
                      CM.SbhSub(),
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
                              Routes.navigateToSignupScreen(context);
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
