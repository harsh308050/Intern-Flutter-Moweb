import 'dart:developer';
import 'package:UserMe/Screens/Auth/AuthScreen.dart';
import 'package:UserMe/Screens/User/UserDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Utils/utils.dart';
import '../../Components/CM.dart';
import '../../components/CustomAppBar.dart';
import '../../components/CustomTile.dart';
import '../../main.dart';

import '../../utils/SharedPrefHelper.dart';
import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';
import 'data/datasource.dart';
import 'data/repository.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final UserDetailsBloc userBloc = UserDetailsBloc(
    repository: Repository(DataSource()),
  );

  @override
  void initState() {
    log(
      " Settings Screen Initialized================================= ${user}",
    );
    if (user == null) {
      userBloc.add(UserDetailsEvent());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDetailsBloc, UserDetailsAppState>(
      bloc: userBloc,
      listener: (context, state) {
        if (state.status == UserDetailsStatus.success) {
          sharedPrefsaveData(sharedPrefKeys.userDataKey, state.userdetails);
          user = state.userdetails;
          log("User details loaded from API");
        } else if (state.status == UserDetailsStatus.failed) {
          showSnackBar(
            context,
            "Failed to load user details",
            UIColours.errorColor,
          );
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(UISizes.appbarHeight),
          child: CustomAppBar(
            isCenter: false,
            appbarTitle: UIStrings.appbarSettings,
          ),
        ),
        backgroundColor: UIColours.white,
        body: BlocBuilder<UserDetailsBloc, UserDetailsAppState>(
          bloc: userBloc,
          builder: (context, state) => state.status == UserDetailsStatus.busy
              ? Center(
                  child: CircularProgressIndicator(
                    color: UIColours.primaryColor,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(UISizes.aroundPadding),
                  child: Column(
                    spacing: UISizes.mainSpacing,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTile(
                        leadingIcon: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: UIColours.grey,
                              width: 1.5,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: UIColours.white,
                            radius: 30,
                            backgroundImage: NetworkImage('${user?.image}'),
                          ),
                        ),
                        title: '${user?.firstName} ${user?.lastName}',
                        subTitle: user?.email,
                      ),
                      Text(
                        UIStrings.settingsGeneral,
                        style: TextStyle(
                          fontSize: UISizes.tileTitle,
                          color: UIColours.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomTile(
                        leadingIcon: UIIcons.fnameIcon,
                        title: UIStrings.tileProfile,
                        // trailingIcon: UIIcons.arrowBtnIcon,
                        onTap: () {
                          callNextScreen(context, UserDetailsScreen());
                        },
                      ),
                      CustomTile(
                        leadingIcon: UIIcons.tileThemeIcon,
                        title: UIStrings.tileTheme,
                        // trailingIcon: UIIcons.arrowBtnIcon,
                      ),
                      Text(
                        UIStrings.settingsAccount,
                        style: TextStyle(
                          fontSize: UISizes.tileTitle,
                          color: UIColours.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomTile(
                        onTap: () {
                          sharedPrefClearAllData();
                          log("Logged out");
                          callNextScreenAndClearStack(context, AuthScreen());
                        },
                        leadingIcon: UIIcons.logout,
                        title: UIStrings.tileLogout,
                      ),
                      CustomTile(
                        textColor: UIColours.errorColor,
                        leadingIcon: UIIcons.dltBtnIcon,
                        title: UIStrings.tileDelete,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
