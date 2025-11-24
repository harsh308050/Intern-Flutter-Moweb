import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/CustomAppBar.dart';
import '../../Routes/routes.dart';
import '../../Utils/utils.dart';
import '../../components/CM.dart';
import '../../components/CustomButton.dart';
import '../../components/CustomTextField.dart';
import '../../utils/SharedPrefHelper.dart';
import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';
import 'data/datasource.dart';
import 'data/repository.dart';
import 'model/user_res_model.dart';

// ignore: must_be_immutable
class EditUserDetailsScreen extends StatefulWidget {
  String userid = sharedPrefGetUser()?.id.toString() ?? '';
  EditUserDetailsScreen({super.key, required this.userid});

  @override
  State<EditUserDetailsScreen> createState() => _EditUserDetailsScreenState();
}

class _EditUserDetailsScreenState extends State<EditUserDetailsScreen> {
  final UserDetailsBloc editUserBloc = UserDetailsBloc(
    repository: Repository(DataSource()),
  );

  final formKey = GlobalKey<FormState>();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final FocusNode fnameFocusNode = FocusNode();
  final FocusNode lnameFocusNode = FocusNode();
  final FocusNode genderFocusNode = FocusNode();
  final FocusNode ageFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    UserResModel? user = sharedPrefGetUser();
    fnameController.text = user?.firstName ?? '';
    lnameController.text = user?.lastName ?? '';
    genderController.text = user?.gender?.toString() ?? '';
    emailController.text = user?.email ?? '';
    ageController.text = user?.age?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(appbarTitle: UIStrings.appbarEditProfile),
      ),
      body: BlocListener<UserDetailsBloc, UserDetailsAppState>(
        bloc: editUserBloc,
        listener: (context, state) async {
          if (state.status == UserDetailsStatus.success) {
            await sharedPrefsaveData(
              sharedPrefKeys.userDataKey,
              jsonEncode(state.userdetails?.toJson()),
            );
            Routes.popScreen(context);
            CM.showSnackBar(
              context,
              "User details edited successfully",
              UIColours.successColor,
            );
          }
          if (state.status == UserDetailsStatus.failed) {
            CM.showSnackBar(
              context,
              "Failed to edit user details",
              UIColours.errorColor,
            );
          }
        },
        child: BlocBuilder<UserDetailsBloc, UserDetailsAppState>(
          bloc: editUserBloc,
          builder: (context, state) => SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(UISizes.aroundPadding),
                      child: Form(
                        key: formKey,
                        child: Column(
                          spacing: UISizes.subSpacing,
                          children: [
                            CustomTextfield(
                              focusNode: fnameFocusNode,
                              controller: fnameController,
                              hintText: UIStrings.fnameHint,
                              labelText: UIStrings.fname,
                              validator: (value) {
                                return CM.inputvalidator(value, "First Name");
                              },
                            ),
                            CustomTextfield(
                              focusNode: lnameFocusNode,
                              controller: lnameController,
                              hintText: UIStrings.lnameHint,
                              labelText: UIStrings.lname,
                              validator: (value) {
                                return CM.inputvalidator(value, "Last Name");
                              },
                            ),
                            CustomTextfield(
                              focusNode: genderFocusNode,
                              controller: genderController,
                              hintText: UIStrings.gender,
                              labelText: UIStrings.gender,
                              validator: (value) {
                                return CM.inputvalidator(value, "Gender");
                              },
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
                            CustomTextfield(
                              focusNode: emailFocusNode,
                              controller: emailController,
                              hintText: UIStrings.emailHint,
                              suffixIcon: Icons.lock_outline,
                              labelText: UIStrings.emailLabel,
                              validator: (value) {
                                return CM.inputvalidator(value, "Email");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(UISizes.aroundPadding),
                  child: CustomButton(
                    buttonText: UIStrings.editprofileButton,
                    onButtonPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (fnameController.text.isEmpty) {
                        focusNodeRoute(fnameFocusNode, context);
                        return;
                      }
                      if (lnameController.text.isEmpty) {
                        focusNodeRoute(lnameFocusNode, context);
                        return;
                      }
                      if (emailController.text.isEmpty) {
                        focusNodeRoute(emailFocusNode, context);
                        return;
                      }
                      if (genderController.text.isEmpty) {
                        focusNodeRoute(genderFocusNode, context);
                        return;
                      }
                      if (formKey.currentState!.validate()) {
                        editUserBloc.add(
                          EditUserDetailsEvent(
                            id: widget.userid.toString(),
                            params: {
                              "firstName": fnameController.text.trim(),
                              "lastName": lnameController.text.trim(),
                              "gender": genderController.text.trim(),
                              "age": ageController.text.trim(),
                            },
                          ),
                        );
                      }
                    },
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
