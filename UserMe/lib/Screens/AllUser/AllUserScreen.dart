import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/CustomAppBar.dart';
import '../../Components/CustomLoader.dart';
import '../../Utils/extensions.dart';
import '../../Utils/utils.dart';
import '../../components/CM.dart';
import '../../components/CustomSearchBar.dart';
import '../../components/CustomTile.dart';
import '../../routes/routes.dart';
import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';
import 'data/datasource.dart';
import 'data/repository.dart';
import 'model/allUser_model.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final AllUsersBloc getAllUsersBloc = AllUsersBloc(
    repository: Repository(DataSource()),
  );
  AllUsersModel? getAllUsersModel;

  TextEditingController searchController = TextEditingController();
  late List<Users> filteredUsers = getAllUsersModel?.users ?? [];

  @override
  void initState() {
    getAllUsersBloc.add(getAllUsersEvent());
    super.initState();
    searchController.addListener(() {
      filterUsers(searchController.text);
    });
  }

  void filterUsers(String query) {
    final allUsers = getAllUsersModel?.users ?? [];
    if (query.isEmpty) {
      setState(() {
        filteredUsers = allUsers;
      });
    } else {
      final filtered = allUsers
          .where(
            (user) =>
                user.firstName!.toLowerCase().contains(query.toLowerCase()) ||
                user.lastName!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      setState(() {
        filteredUsers = filtered;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColours.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          appbarTitle: UIStrings.appbarUsers,
          suffixIcon: IconButton(icon: UIIcons.filter, onPressed: () {}),
        ),
      ),
      body: BlocListener<AllUsersBloc, getAllUsersAppState>(
        bloc: getAllUsersBloc,
        listener: (context, state) => {
          if (state.status == Status.success)
            {getAllUsersModel = state.allusers},
          if (state.status == Status.failed) {print("error")},
        },
        child: SafeArea(
          child: Container(
            color: UIColours.white,
            child: Padding(
              padding: EdgeInsets.all(UISizes.aroundPadding),
              child: Column(
                children: [
                  CustomSearchBar(
                    hintText: UIStrings.searchbarHint,
                    controller: searchController,
                  ),
                  CM.SbhMain(),
                  BlocBuilder<AllUsersBloc, getAllUsersAppState>(
                    bloc: getAllUsersBloc,
                    builder: (context, state) {
                      if (state.status == Status.busy &&
                          getAllUsersModel == null) {
                        return CustomLoader();
                      }
                      if (getAllUsersModel != null) {
                        final list = getAllUsersModel!.users!;
                        return Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: filteredUsers.length,
                            itemBuilder: (context, index) {
                              return Column(
                                spacing: UISizes.subSpacing,
                                children: [
                                  CustomTile(
                                    leadingIcon: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: UIColours.primaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor: UIColours.white,
                                        backgroundImage: NetworkImage(
                                          filteredUsers[index].image.toString(),
                                        ),
                                      ),
                                    ),
                                    title:
                                        "${filteredUsers[index].firstName} ${filteredUsers[index].lastName.toString()}",
                                    subTitle: list[index].email.toString(),
                                    trailingIcon: UIIcons.arrowBtnIcon,
                                  ),
                                ],
                              ).onTap(() {
                                Routes.navigateToAllUsersDetailsScreen(
                                  context,
                                  id: filteredUsers[index].id!,
                                );
                              });
                            },
                          ),
                        );
                      }
                      return Center(child: Text('No Data Found'));
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

//
