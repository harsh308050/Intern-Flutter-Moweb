import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/CustomAppBar.dart';
import '../../Components/CustomLoader.dart';
import '../../Utils/extensions.dart';
import '../../Utils/utils.dart';
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
  String? selectedOrder;

  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getAllUsersBloc.add(getAllUsersEvent());
    searchFocusNode.unfocus();
  }

  void clearSearch() {
    searchController.clear();
    searchFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColours.white,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 15, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            searchFocusNode.unfocus();
            Routes.navigateToSignupScreen(context, true);
          },
          backgroundColor: UIColours.primaryColor,
          child: Icon(Icons.add, color: UIColours.white),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          appbarTitle: UIStrings.appbarUsers,
          suffixIcon: Stack(
            children: [
              if (selectedOrder != null)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: UIColours.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              PopupMenuButton<String>(
                color: UIColours.white,
                icon: UIIcons.filter,

                onSelected: (String value) {
                  selectedOrder = value;
                  clearSearch();
                  setState(() {});
                  if (value != 'asc' && value != 'desc') {
                    getAllUsersBloc.add(getAllUsersEvent());
                  } else {
                    getAllUsersBloc.add(getAllUsersEvent(order: value));
                  }
                },

                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    enabled: false,
                    child: Text(
                      "Sort by",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: UIColours.primaryColor,
                      ),
                    ),
                  ),

                  PopupMenuItem<String>(
                    value: 'asc',
                    child: Text(
                      'A-Z',
                      style: TextStyle(
                        color: selectedOrder == 'asc'
                            ? UIColours.primaryColor
                            : UIColours.black,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'desc',
                    child: Text(
                      'Z-A',
                      style: TextStyle(
                        color: selectedOrder == 'desc'
                            ? UIColours.primaryColor
                            : UIColours.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: BlocListener<AllUsersBloc, getAllUsersAppState>(
        bloc: getAllUsersBloc,
        listener: (context, state) => {
          if (state.status == Status.success)
            {getAllUsersModel = state.allusers},

          if (state.status == Status.failed) {log("Failed to fetch users")},
        },
        child: SafeArea(
          child: Container(
            color: UIColours.white,
            padding: EdgeInsets.only(
              top: UISizes.aroundPadding,
              left: UISizes.aroundPadding,
              right: UISizes.aroundPadding,
            ),
            child: Column(
              spacing: UISizes.subSpacing,
              children: [
                CustomSearchBar(
                  focusNode: searchFocusNode,
                  hintText: UIStrings.searchbarHint,
                  controller: searchController,
                  onClear: () {
                    clearSearch();
                    getAllUsersBloc.add(getAllUsersEvent());
                  },
                  onChanged: (value) {
                    selectedOrder = null;
                    if (value.isEmpty || value == "") {
                      getAllUsersBloc.add(getAllUsersEvent());
                    } else {
                      getAllUsersBloc.add(getAllUsersEvent(query: value));
                    }
                    setState(() {});
                  },
                ),
                BlocBuilder<AllUsersBloc, getAllUsersAppState>(
                  bloc: getAllUsersBloc,
                  builder: (context, state) {
                    if (state.status == Status.busy) {
                      return Expanded(child: CustomLoader());
                    }
                    if (getAllUsersModel != null) {
                      final list = getAllUsersModel!.users!;
                      if (list.isEmpty || list.length == 0) {
                        return Expanded(
                          child: Center(child: Text("No users found")),
                        );
                      }
                      return Expanded(
                        child: RefreshIndicator(
                          color: UIColours.white,
                          backgroundColor: UIColours.primaryColor,
                          elevation: 4.0,

                          onRefresh: () {
                            clearSearch();
                            getAllUsersBloc.add(getAllUsersEvent());
                            selectedOrder = null;
                            setState(() {});
                            return Future.value();
                          },
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: list.length,
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
                                          list[index].image.toString(),
                                        ),
                                      ),
                                    ),
                                    title:
                                        "${list[index].firstName} ${list[index].lastName.toString()}",
                                    subTitle: list[index].email.toString(),
                                    trailingIcon: UIIcons.arrowBtnIcon,
                                  ),
                                ],
                              ).onTap(() {
                                searchFocusNode.unfocus();
                                Routes.navigateToAllUsersDetailsScreen(
                                  context,
                                  id: list[index].id!,
                                );
                              });
                            },
                          ),
                        ),
                      );
                    }
                    if (getAllUsersModel?.users == []) {
                      return Expanded(
                        child: Center(child: Text("No users found")),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
