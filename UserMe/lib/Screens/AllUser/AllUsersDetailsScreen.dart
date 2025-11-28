import 'package:UserMe/Components/CustomButton.dart';
import 'package:UserMe/Utils/extensions.dart';

import '../../Components/CustomLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';
import '../../Components/CM.dart';
import '../../components/CustomAppBar.dart';

import '../../Components/CustomUserDetailsTile.dart';
import '../../utils/utils.dart';
import 'data/datasource.dart';
import 'data/repository.dart';
import 'model/allUser_model.dart';

class AllUsersDetailsScreen extends StatefulWidget {
  final num id;

  const AllUsersDetailsScreen({super.key, required this.id});

  @override
  State<AllUsersDetailsScreen> createState() => _AllUsersDetailsScreenState();
}

class _AllUsersDetailsScreenState extends State<AllUsersDetailsScreen> {
  final AllUsersBloc userDetailsBloc = AllUsersBloc(
    repository: Repository(DataSource()),
  );
  Users? user;

  @override
  void initState() {
    super.initState();
    userDetailsBloc.add(getAllUsersDetailsEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AllUsersBloc, getAllUsersAppState>(
      bloc: userDetailsBloc,
      listener: (context, state) {
        if (state.status == Status.success) {
          user = state.allusers?.users?.first;
          ;
        } else if (state.status == Status.failed) {
          print("Error fetching user details");
        }
      },
      child: Scaffold(
        backgroundColor: UIColours.white,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, UISizes.appbarHeight),
          child: CustomAppBar(appbarTitle: UIStrings.appbarUserDetails),
        ),

        body: BlocBuilder<AllUsersBloc, getAllUsersAppState>(
          bloc: userDetailsBloc,
          builder: (context, state) => state.status == Status.busy
              ? Center(child: CustomLoader())
              : SingleChildScrollView(
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
                                  border: Border.all(
                                    color: UIColours.grey,
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: UIColours.white,
                                  backgroundImage:
                                      (user?.image.isNotNullOrEmpty ?? false)
                                      ? NetworkImage(user!.image!)
                                      : null,
                                ),
                              ),
                              SizedBox(height: UISizes.mainSpacing * 2),
                              Text(
                                '${user?.firstName ?? "harsh"} ${user?.lastName ?? "parmar"}',
                                style: TextStyle(
                                  fontSize: UISizes.tileTitle + 5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SbhMin(),
                              Text(
                                user?.email ?? 'harsh308050@gmail.com',
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
                                value: user?.firstName ?? 'Harsh',
                              ),
                              userInfoTile(
                                icon: Icons.tag_outlined,
                                title: UIStrings.username,
                                value: user?.username ?? 'harsh308050',
                              ),
                              userInfoTile(
                                icon: Icons.wc_outlined,
                                title: UIStrings.gender,
                                value: user?.gender ?? 'Male',
                              ),
                              userInfoTile(
                                icon: Icons.email_outlined,
                                title: UIStrings.emailLabel,
                                value: user?.email ?? 'harsh308050@gmail.com',
                              ),
                              userInfoTile(
                                icon: Icons.phone_outlined,
                                title: UIStrings.phoneLabel,
                                value: user?.phone ?? '123-456-7890',
                              ),

                              userInfoTile(
                                icon: Icons.cake_outlined,
                                title: UIStrings.birthDate,
                                value: user?.birthDate ?? '01/01/2000',
                              ),
                              userInfoTile(
                                icon: Icons.flag_outlined,
                                title: UIStrings.country,
                                value: user?.address?.country ?? 'India',
                              ),
                              userInfoTile(
                                icon: Icons.height_outlined,
                                title: "Height",
                                value: user?.height.toString() ?? '01/01/2000',
                              ),
                              userInfoTile(
                                icon: Icons.monitor_weight_outlined,
                                title: "Weight",
                                value: user?.weight.toString() ?? '01/01/2000',
                              ),
                            ],
                          ),
                        ),
                        CustomButton(
                          buttonText: "Add to Favorites",
                          onButtonPressed: () {
                            Navigator.pop(context, user?.firstName);
                          },
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
