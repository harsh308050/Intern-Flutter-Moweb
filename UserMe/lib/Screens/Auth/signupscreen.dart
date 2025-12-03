import 'dart:io';
import 'package:UserMe/Screens/Auth/AuthScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/CM.dart';
import '../../Components/CustomAppBar.dart';
import '../../Components/CustomGenderButton.dart';
import '../../Components/CustomProfile.dart';

import '../../components/CustomTile.dart';
import '../../utils/utils.dart';
import '../../components/CustomButton.dart';
import '../../components/CustomTextButton.dart';
import '../../components/CustomTextField.dart';
import 'package:image_picker/image_picker.dart';

import '../User/bloc/bloc.dart';
import '../User/bloc/event.dart';
import '../User/bloc/state.dart';
import '../User/data/datasource.dart';
import '../User/data/repository.dart';
import '../User/model/user_res_model.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback? onSwitchTab;
  final bool? isFromAddUser;
  SignupScreen({super.key, this.isFromAddUser = false, this.onSwitchTab});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with RouteAware {
  final UserDetailsBloc addUsersBloc = UserDetailsBloc(
    repository: Repository(DataSource()),
  );

  UserResModel? addUserModel;

  final formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  File? image;
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FocusNode fnameFocusNode = FocusNode();
  final FocusNode lnameFocusNode = FocusNode();
  final FocusNode ageFocusNode = FocusNode();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool isMale = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(UISizes.appbarHeight),
        child: CustomAppBar(
          appbarTitle: widget.isFromAddUser!
              ? UIStrings.addUserTitle
              : UIStrings.signupTitle,
        ),
      ),
      body: BlocListener<UserDetailsBloc, UserDetailsAppState>(
        bloc: addUsersBloc,
        listener: (context, state) {
          if (state.status == UserDetailsStatus.success) {
            showSnackBar(
              context,
              widget.isFromAddUser!
                  ? "User added successfully"
                  : "Signup successful",
              UIColours.successColor,
            );
            widget.isFromAddUser!
                ? Navigator.pop(context)
                : callNextScreenAndClearStack(context, AuthScreen());
          } else {
            if (state.status == UserDetailsStatus.failed) {
              showSnackBar(
                context,
                "An error occurred. Please try again.",
                UIColours.errorColor,
              );
            }
          }
        },
        child: BlocBuilder<UserDetailsBloc, UserDetailsAppState>(
          bloc: addUsersBloc,
          builder: (context, state) => SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(UISizes.aroundPadding),
                  child: Center(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Column(
                              spacing: UISizes.subSpacing,
                              children: [
                                widget.isFromAddUser!
                                    ? SizedBox.shrink()
                                    : CustomProfile(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ListView(
                                                shrinkWrap: true,
                                                padding: EdgeInsets.all(
                                                  UISizes.aroundPadding,
                                                ),
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      CustomTile(
                                                        leadingIcon: Icon(
                                                          Icons.photo_library,
                                                        ),
                                                        title:
                                                            "Choose From Gallery",
                                                        onTap: () {
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                          pickImage(
                                                            ImageSource.gallery,
                                                            picker,
                                                          ).then((file) async {
                                                            if (file != null) {
                                                              setState(() {
                                                                image = file;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                      CustomTile(
                                                        leadingIcon: Icon(
                                                          Icons.camera_alt,
                                                        ),
                                                        title: "Take a Photo",
                                                        onTap: () {
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                          pickImage(
                                                            ImageSource.camera,
                                                            picker,
                                                          ).then((file) async {
                                                            if (file != null) {
                                                              setState(() {
                                                                image = file;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        imagePath: image != null
                                            ? image!.path
                                            : AssetsPath.profile,
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: UIColours.white,
                                              width: 2,
                                            ),
                                            color: UIColours.primaryColor,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: image != null
                                              ? UIIcons.editIcon
                                              : UIIcons.addIcon,
                                        ),
                                      ),
                                Row(
                                  crossAxisAlignment: .start,
                                  spacing: UISizes.subSpacing,
                                  children: [
                                    Expanded(
                                      child: CustomTextfield(
                                        focusNode: fnameFocusNode,
                                        controller: fnameController,
                                        hintText: UIStrings.typehereHint,
                                        labelText: UIStrings.fname,
                                        validator: (value) {
                                          return inputvalidator(
                                            value,
                                            "First Name",
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomTextfield(
                                        focusNode: lnameFocusNode,
                                        controller: lnameController,
                                        hintText: UIStrings.typehereHint,
                                        labelText: UIStrings.lname,
                                        validator: (value) {
                                          return inputvalidator(
                                            value,
                                            "Last Name",
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                CustomTextfield(
                                  focusNode: ageFocusNode,
                                  controller: ageController,
                                  hintText: UIStrings.ageHint,
                                  labelText: UIStrings.age,
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                  validator: (value) {
                                    return inputvalidator(value, "Age");
                                  },
                                ),
                                Column(
                                  spacing: UISizes.minSpacing,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      UIStrings.gender,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    Container(
                                      height: 60,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: UIColours.grey.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        spacing: 5,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Genderbutton(
                                            onGenderChanged: () {
                                              setState(() {
                                                isMale = true;
                                              });
                                            },
                                            label: "Male",
                                            isMale: isMale,
                                          ),
                                          Genderbutton(
                                            onGenderChanged: () {
                                              setState(() {
                                                isMale = false;
                                              });
                                            },
                                            label: "Female",
                                            isMale: !isMale,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                CustomTextfield(
                                  focusNode: usernameFocusNode,
                                  controller: usernameController,
                                  hintText: UIStrings.usernameHint,
                                  labelText: UIStrings.username,
                                  validator: (value) {
                                    return inputvalidator(value, "Username");
                                  },
                                ),
                                CustomTextfield(
                                  focusNode: emailFocusNode,
                                  controller: emailController,
                                  hintText: UIStrings.emailHint,
                                  labelText: UIStrings.emailLabel,
                                  validator: (value) {
                                    return inputvalidator(value, "Email");
                                  },
                                ),
                                CustomTextfield(
                                  focusNode: passwordFocusNode,
                                  controller: passwordController,
                                  hintText: UIStrings.passwordHint,
                                  labelText: UIStrings.passwordLabel,
                                  validator: (value) {
                                    return inputvalidator(value, "Password");
                                  },
                                ),
                              ],
                            ),
                          ),
                          SbhMain(),
                          SbhMain(),

                          CustomButton(
                            isLoading: state.status == UserDetailsStatus.busy
                                ? true
                                : false,
                            buttonText: widget.isFromAddUser!
                                ? UIStrings.addUserBtn
                                : UIStrings.signupButton,
                            onButtonPressed: () {
                              if (formKey.currentState!.validate()) {
                                widget.isFromAddUser!
                                    ? addUsersBloc.add(
                                        AddUserEvent(
                                          params: {
                                            "firstName": fnameController.text
                                                .trim(),
                                            "lastName": lnameController.text
                                                .trim(),
                                            "username": usernameController.text
                                                .trim(),
                                            "email": emailController.text
                                                .trim(),
                                            "password": passwordController.text
                                                .trim(),
                                            "age": ageController.text.trim(),
                                            "gender": isMale
                                                ? "Male"
                                                : "Female",
                                          },
                                        ),
                                      )
                                    : showSnackBar(
                                        context,
                                        "SignUp later",
                                        UIColours.successColor,
                                      );
                              } else {
                                if (fnameController.text.isEmpty) {
                                  focusNodeRoute(fnameFocusNode, context);
                                } else if (lnameController.text.isEmpty) {
                                  focusNodeRoute(lnameFocusNode, context);
                                } else if (ageController.text.isEmpty) {
                                  focusNodeRoute(ageFocusNode, context);
                                } else if (usernameController.text.isEmpty) {
                                  focusNodeRoute(usernameFocusNode, context);
                                } else if (emailController.text.isEmpty ||
                                    inputvalidator(
                                          emailController.text,
                                          "Email",
                                        ) !=
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

                          SbhMin(),
                          widget.isFromAddUser!
                              ? SizedBox.shrink()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      UIStrings.haveAccount,
                                      style: TextStyle(
                                        color: UIColours.greyShade,
                                        fontSize: UISizes.inputFontSize,
                                      ),
                                    ),
                                    CustomTextButton(
                                      buttonText: UIStrings.loginButton,
                                      onTextButtonPressed: widget.onSwitchTab,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
