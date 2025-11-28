import 'dart:developer';
import 'package:UserMe/Components/CM.dart';
import 'package:UserMe/Screens/AllUser/AllUsersDetailsScreen.dart';
import 'package:UserMe/Screens/Auth/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/CustomAppBar.dart';
import '../../Components/CustomLoader.dart';
import '../../Utils/extensions.dart';
import '../../Utils/utils.dart';
import '../../components/CustomSearchBar.dart';
import '../../components/CustomTile.dart';

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

  ValueNotifier<int> scrollNotifier = ValueNotifier<int>(-1);

  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getAllUsersBloc.add(getAllUsersEvent());
    searchFocusNode.unfocus();
    scrollController.addListener(scrollPosition);
  }

  scrollPosition() {
    final max = scrollController.position.maxScrollExtent;
    final min = scrollController.position.minScrollExtent;
    final current = scrollController.position.pixels;
    final mid = max / 2;
    if (current == max || current == min) {
      scrollNotifier.value = -1;
    } else if (current > mid) {
      scrollNotifier.value = 1;
    } else if (current < mid) {
      scrollNotifier.value = 0;
    }
  }

  String? username = "";

  void handleChildCallback(String? firstName) {
    setState(() {
      username = firstName;
    });
  }

  void clearSearch() {
    searchController.clear();
    searchFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColours.white,
      floatingActionButton: Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .end,

        children: [
          ValueListenableBuilder(
            valueListenable: scrollNotifier,
            builder: (context, value, child) {
              return Container(
                margin: EdgeInsets.only(left: UISizes.aroundPadding * 2),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: UIColours.grey.withOpacity(0.4)),
                  ),
                ),
                child: AnimatedOpacity(
                  opacity: value == -1 ? 0 : 1,
                  duration: Duration(milliseconds: 200),
                  child: FloatingActionButton.small(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    onPressed: () {
                      if (value == 1) {
                        scrollController.animateTo(
                          scrollController.position.minScrollExtent,
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                        );
                      } else if (value == 0) {
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                        );
                      }
                    },

                    heroTag: "btn1",
                    backgroundColor: UIColours.primaryColor,
                    child: Icon(
                      value == 1 ? Icons.arrow_upward : Icons.arrow_downward,
                      color: UIColours.white,
                    ),
                  ),
                ),
              );
            },
          ),

          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              searchFocusNode.unfocus();
              callNextScreen(context, SignupScreen(isFromAddUser: true));
            },
            backgroundColor: UIColours.primaryColor,
            child: Icon(Icons.add, color: UIColours.white),
          ),
        ],
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          appbarTitle: UIStrings.appbarUsers,
          suffixIcon: Stack(
            children: [
              if (selectedOrder.isNotNull)
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

          if (state.status == Status.failed) {log("Failed to Fetch Users")},
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
                    if (value.isEmpty) {
                      getAllUsersBloc.add(getAllUsersEvent());
                    } else {
                      getAllUsersBloc.add(getAllUsersEvent(query: value));
                    }
                    setState(() {});
                  },
                ),
                AnimatedSize(
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 600),
                  child: username.isNotEmpty
                      ? Text(
                          "You added $username to Favorite users",
                          style: TextStyle(
                            fontSize: UISizes.tileSubtitle,
                            color: UIColours.grey,
                          ),
                        )
                      : SizedBox(),
                ),
                BlocBuilder<AllUsersBloc, getAllUsersAppState>(
                  bloc: getAllUsersBloc,
                  builder: (context, state) {
                    if (state.status == Status.busy) {
                      return Expanded(child: CustomLoader());
                    }
                    if (state.status == Status.failed) {
                      return Expanded(
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              getAllUsersBloc.add(getAllUsersEvent());
                            },
                            icon: Icon(
                              Icons.refresh_outlined,
                              color: UIColours.primaryColor,
                            ),
                          ),
                        ),
                      );
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
                          child: ReorderableListView.builder(
                            onReorder: (oldIndex, newIndex) {
                              setState(() {
                                if (oldIndex < newIndex) {
                                  newIndex -= 1;
                                }
                                final item = list.removeAt(oldIndex);
                                ;
                                list.insert(newIndex, item);
                              });
                            },
                            scrollController: scrollController,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: UIColours.white,
                                ),
                                key: ValueKey(list[index].id),
                                child:
                                    Column(
                                      spacing: UISizes.subSpacing,
                                      children: [
                                        CustomTile(
                                          showTrailingIcon: true,
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
                                          subTitle: list[index].email
                                              .toString(),
                                          trailingIconTap: () {
                                            username = list[index].firstName;
                                            Future.delayed(
                                              Duration(seconds: 3),
                                              () {
                                                setState(() {
                                                  username = "";
                                                });
                                              },
                                            );
                                            setState(() {});
                                          },
                                          isFav:
                                              username == list[index].firstName
                                              ? true
                                              : false,
                                        ),
                                      ],
                                    ).onTap(() {
                                      searchFocusNode.unfocus();
                                      callNextScreenWithResult(
                                        context,
                                        AllUsersDetailsScreen(
                                          id: list[index].id!,
                                        ),
                                      ).then((fname) {
                                        if (fname != null) {
                                          username = fname;
                                          Future.delayed(
                                            Duration(seconds: 3),
                                            () {
                                              setState(() {
                                                username = "";
                                              });
                                            },
                                          );
                                          setState(() {});
                                          showSnackBar(
                                            context,
                                            "Added $fname to favorites",
                                            UIColours.successColor,
                                          );
                                          getAllUsersBloc.add(
                                            getAllUsersEvent(),
                                          );
                                        }
                                      });
                                    }),
                              );
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
