import 'dart:developer';
import 'package:UserMe/Components/CustomTextButton.dart';
import 'package:UserMe/Components/CustomThemeMobile.dart';
import 'package:UserMe/Screens/Auth/AuthScreen.dart';
import 'package:UserMe/Screens/User/UserDetailsScreen.dart';
import 'package:UserMe/Utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:UserMe/main.dart';
import '../../Utils/utils.dart';
import '../../Components/CM.dart';
import '../../components/CustomAppBar.dart';
import '../../components/CustomTile.dart';

import '../../utils/SharedPrefHelper.dart';
import '../Theme/ThemeEvent.dart';
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
            isCenter: true,
            appbarTitle: UIStrings.appbarSettings,
          ),
        ),
        body: BlocBuilder<UserDetailsBloc, UserDetailsAppState>(
          bloc: userBloc,
          builder: (context, state) => state.status == UserDetailsStatus.busy
              ? Center(
                  child: CircularProgressIndicator(
                    color: UIColours.primaryColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(UISizes.aroundPadding),
                    child: Column(
                      spacing: UISizes.mainSpacing + 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          spacing: UISizes.minSpacing,

                          children: [
                            Container(
                              alignment: .center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: UIColours.grey,
                                border: Border.all(
                                  color: UIColours.grey,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: UIColours.white,
                                backgroundImage:
                                    (user?.image.isNotNullOrEmpty ?? false)
                                    ? NetworkImage(user!.image!)
                                    : null,
                                child:
                                    (user?.image == null ||
                                        user!.image!.isEmpty)
                                    ? Icon(
                                        Icons.person,
                                        size: 60,
                                        color: UIColours.grey,
                                      )
                                    : null,
                              ),
                            ),
                            Text(
                              '${user?.firstName} ${user?.lastName}',
                              style: TextStyle(
                                fontSize: UISizes.tileTitle + 5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user?.email ?? '',
                              style: TextStyle(
                                color: UIColours.grey,
                                fontSize: UISizes.inputFontSize,
                              ),
                            ),
                          ],
                        ).onTap(() {
                          callNextScreen(context, UserDetailsScreen());
                        }),

                        Column(
                          spacing: UISizes.subSpacing,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              UIStrings.tileTheme,
                              style: TextStyle(
                                fontSize: UISizes.tileTitle,
                                color: UIColours.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomThemeMobile(
                                  selectedColour:
                                      themeBloc.state.themeMode ==
                                          ThemeMode.light
                                      ? UIColours.primaryColor
                                      : UIColours.transparent,
                                  borderColor: UIColours.black.withValues(
                                    alpha: 0.7,
                                  ),
                                  inColour: UIColours.white,
                                  themeName: "Light",
                                ).onTap(() {
                                  themeBloc.add(
                                    ChangeThemeEvent(
                                      themeMode: ThemeMode.light,
                                    ),
                                  );
                                  setState(() {});
                                }),

                                CustomThemeMobile(
                                  selectedColour:
                                      themeBloc.state.themeMode ==
                                          ThemeMode.dark
                                      ? UIColours.primaryColor
                                      : UIColours.transparent,
                                  borderColor: UIColours.white.withValues(
                                    alpha: 0.9,
                                  ),
                                  inColour: UIColours.black,
                                  themeName: "Dark",
                                ).onTap(() {
                                  themeBloc.add(
                                    ChangeThemeEvent(themeMode: ThemeMode.dark),
                                  );
                                  setState(() {});
                                }),

                                CustomThemeMobile(
                                  selectedColour:
                                      themeBloc.state.themeMode ==
                                          ThemeMode.system
                                      ? UIColours.primaryColor
                                      : UIColours.transparent,
                                  borderColor: UIColours.black.withValues(
                                    alpha: 0.7,
                                  ),
                                  inColour: UIColours.grey.withValues(
                                    alpha: 0.5,
                                  ),
                                  themeName: "System",
                                ).onTap(() {
                                  themeBloc.add(
                                    ChangeThemeEvent(
                                      themeMode: ThemeMode.system,
                                    ),
                                  );
                                  setState(() {});
                                }),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          spacing: UISizes.subSpacing,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Column(
                                        spacing: 5,
                                        crossAxisAlignment: .start,
                                        mainAxisAlignment: .start,
                                        children: [
                                          Text(
                                            'Confirm Logout',
                                            style: TextStyle(
                                              color: UIColours.primaryColor,
                                              fontWeight: .bold,
                                            ),
                                          ),
                                          Text(
                                            'Are you sure you want to logout?',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        CustomTextButton(
                                          buttonText: 'Cancel',
                                          onTextButtonPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        CustomTextButton(
                                          buttonText: 'Logout',
                                          buttonColor: UIColours.errorColor,
                                          onTextButtonPressed: () {
                                            sharedPrefClearAllData();
                                            log("Logged out");
                                            callNextScreenAndClearStack(
                                              context,
                                              AuthScreen(),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              leadingIcon: UIIcons.logout,
                              title: UIStrings.tileLogout,
                            ),
                            CustomTile(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Column(
                                        spacing: 5,
                                        crossAxisAlignment: .start,
                                        mainAxisAlignment: .start,
                                        children: [
                                          Text(
                                            'Confirm Delete',
                                            style: TextStyle(
                                              color: UIColours.primaryColor,
                                              fontWeight: .bold,
                                            ),
                                          ),
                                          Text(
                                            'Are you sure you want to delete account?',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        CustomTextButton(
                                          buttonText: 'Cancel',
                                          onTextButtonPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        CustomTextButton(
                                          buttonText: 'Delete',
                                          buttonColor: UIColours.errorColor,
                                          onTextButtonPressed: () {
                                            sharedPrefClearAllData();
                                            log("Logged out");
                                            callNextScreenAndClearStack(
                                              context,
                                              AuthScreen(),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              textColor: UIColours.errorColor,
                              leadingIcon: UIIcons.dltBtnIcon,
                              title: UIStrings.tileDelete,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
