import 'package:UserMe/Screens/User/EditUserDetailsScreen.dart';
import 'package:UserMe/Utils/extensions.dart';
import 'package:flutter/material.dart';
import '../../Components/CM.dart';
import '../../Components/CustomTextButton.dart';
import '../../Components/CustomUserDetailsTile.dart';
import '../../Utils/utils.dart';
import '../../utils/SharedPrefHelper.dart';
import '../../components/CustomAppBar.dart';

import 'model/user_res_model.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  UserResModel? user = sharedPrefGetUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(UISizes.appbarHeight),
        child: CustomAppBar(
          isCenter: true,
          suffixIcon: CustomTextButton(
            buttonText: UIStrings.editBtn,
            onTextButtonPressed: () {
              callNextScreen(
                context,
                EditUserDetailsScreen(userid: user?.id.toString() ?? ''),
              );
            },
          ),
          appbarTitle: UIStrings.appbarUserDetails,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(UISizes.aroundPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UIColours.grey,
                        border: Border.all(color: UIColours.grey, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: UIColours.white,
                        backgroundImage: (user?.image.isNotNullOrEmpty ?? false)
                            ? NetworkImage(user!.image!)
                            : null,
                        child: (user?.image == null || user!.image!.isEmpty)
                            ? Icon(
                                Icons.person,
                                size: 60,
                                color: UIColours.grey,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(height: UISizes.mainSpacing * 2),
                    Text(
                      '${user?.firstName} ${user?.lastName}',
                      style: TextStyle(
                        fontSize: UISizes.tileTitle + 5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SbhMin(),
                    Text(
                      user?.email ?? '',
                      style: TextStyle(
                        color: UIColours.grey,
                        fontSize: UISizes.inputFontSize,
                      ),
                    ),
                  ],
                ),
              ),
              SbhMain(),
              SbhMain(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: UISizes.subSpacing + 5,
                ),
                child: Column(
                  children: [
                    userInfoTile(
                      icon: Icons.person_outline,
                      title: UIStrings.fname,
                      value: user?.firstName ?? '',
                    ),
                    userInfoTile(
                      icon: Icons.tag_outlined,
                      title: UIStrings.username,
                      value: user?.username ?? '',
                    ),
                    userInfoTile(
                      icon: Icons.wc_outlined,
                      title: UIStrings.gender,
                      value: user?.gender ?? '',
                    ),
                    userInfoTile(
                      icon: Icons.email_outlined,
                      title: UIStrings.emailLabel,
                      value: user?.email ?? '',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
