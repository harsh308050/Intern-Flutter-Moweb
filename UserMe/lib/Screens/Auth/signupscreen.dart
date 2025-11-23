import 'dart:io';
import 'package:flutter/material.dart';
import '../../Components/CM.dart';
import '../../Components/CustomAppBar.dart';
import '../../Components/CustomGenderButton.dart';
import '../../Components/CustomProfile.dart';
import '../../Routes/routes.dart';
import '../../components/CustomTile.dart';
import '../../utils/utils.dart';
import '../../components/CustomButton.dart';
import '../../components/CustomTextButton.dart';
import '../../components/CustomTextField.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  File? image;
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FocusNode fnameFocusNode = FocusNode();
  final FocusNode lnameFocusNode = FocusNode();
  final FocusNode ageFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool isMale = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColours.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(UISizes.appbarHeight),
        child: CustomAppBar(appbarTitle: UIStrings.signupTitle),
      ),
      body: SafeArea(
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
                            CustomProfile(
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
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomTile(
                                              leadingIcon: Icon(
                                                Icons.photo_library,
                                              ),
                                              title: "Choose From Gallery",
                                              onTap: () {
                                                Navigator.pop(context);
                                                CM
                                                    .pickImage(
                                                      ImageSource.gallery,
                                                      picker,
                                                    )
                                                    .then((file) async {
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
                                                Navigator.pop(context);
                                                CM
                                                    .pickImage(
                                                      ImageSource.camera,
                                                      picker,
                                                    )
                                                    .then((file) async {
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
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: image != null
                                    ? UIIcons.editIcon
                                    : UIIcons.addIcon,
                              ),
                            ),
                            Row(
                              spacing: UISizes.subSpacing,
                              children: [
                                Expanded(
                                  child: CustomTextfield(
                                    focusNode: fnameFocusNode,
                                    controller: fnameController,
                                    hintText: UIStrings.fnameHint,
                                    labelText: UIStrings.fname,
                                    validator: (value) {
                                      return CM.inputvalidator(
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
                                    hintText: UIStrings.lnameHint,
                                    labelText: UIStrings.lname,
                                    validator: (value) {
                                      return CM.inputvalidator(
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
                              validator: (value) {
                                return CM.inputvalidator(value, "Age");
                              },
                            ),
                            Column(
                              spacing: UISizes.minSpacing,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  UIStrings.gender,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),

                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: UIColours.grey.withOpacity(0.1),
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
                              focusNode: emailFocusNode,
                              controller: emailController,
                              hintText: UIStrings.emailHint,
                              labelText: UIStrings.emailLabel,
                              validator: (value) {
                                return CM.inputvalidator(value, "Email");
                              },
                            ),
                            CustomTextfield(
                              focusNode: passwordFocusNode,
                              controller: passwordController,
                              hintText: UIStrings.passwordHint,
                              labelText: UIStrings.passwordLabel,
                              validator: (value) {
                                return CM.inputvalidator(value, "Password");
                              },
                            ),
                          ],
                        ),
                      ),
                      CM.SbhMain(),
                      CM.SbhMain(),
                      CustomButton(
                        buttonText: UIStrings.signupButton,
                        onButtonPressed: () {
                          if (fnameController.text.isEmpty) {
                            focusNodeRoute(fnameFocusNode, context);
                            return;
                          }
                          if (lnameController.text.isEmpty) {
                            focusNodeRoute(lnameFocusNode, context);
                            return;
                          }
                          if (ageController.text.isEmpty) {
                            focusNodeRoute(ageFocusNode, context);
                            return;
                          }
                          if (emailController.text.isEmpty) {
                            focusNodeRoute(emailFocusNode, context);
                            return;
                          }
                          if (passwordController.text.isEmpty) {
                            focusNodeRoute(passwordFocusNode, context);
                            return;
                          }
                          if (formKey.currentState!.validate()) {}
                        },
                      ),
                      CM.SbhMin(),
                      Row(
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
                            onTextButtonPressed: () {
                              Routes.navigateToLoginScreen(context);
                            },
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
    );
  }
}
