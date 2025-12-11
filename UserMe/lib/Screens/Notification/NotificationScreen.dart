import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:UserMe/Components/CM.dart';
import 'package:UserMe/Components/CustomButton.dart';
import 'package:UserMe/Components/CustomFloatingButton.dart';
import 'package:UserMe/Components/CustomTextField.dart';
import 'package:UserMe/Screens/Notification/model/NotificationModel.dart';
import 'package:UserMe/Utils/extensions.dart';
import 'package:UserMe/components/CustomTile.dart';
import 'package:flutter/cupertino.dart' hide Size;
import 'package:flutter/material.dart' hide Size;
import 'notification_service.dart';

import '../../Components/CustomAppBar.dart';
import '../../Utils/SharedPrefHelper.dart';
import '../../Utils/utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool showNotificationSelector = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(this.context).size.width;
    final height = MediaQuery.of(this.context).size.height;
    final FocusNode titleFocusNode = FocusNode();
    final FocusNode descriptionFocusNode = FocusNode();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final BuildContext parentcontext = this.context;
    DateTime dateTime = DateTime.now();
    AllNotifications allNotifications =
        sharedPrefGetData(sharedPrefKeys.notifications) != null
        ? AllNotifications.fromJson(
            jsonDecode(sharedPrefGetData(sharedPrefKeys.notifications)),
          )
        : AllNotifications(notifications: [], total: 0, skip: 0, limit: 0);
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(UISizes.appbarHeight),
            child: CustomAppBar(
              isPassingData: false,
              appbarTitle: UIStrings.appbarNotification,
            ),
          ),
          body: RefreshIndicator(
            color: UIColours.primaryColor,
            onRefresh: () async {
              allNotifications = AllNotifications.fromJson(
                jsonDecode(sharedPrefGetData(sharedPrefKeys.notifications)),
              );
              setState(() {});
            },
            child:
                allNotifications.notifications == null ||
                    allNotifications.notifications?.length == 0 ||
                    allNotifications.notifications!.isEmpty ||
                    allNotifications.notifications!
                        .where(
                          (n) =>
                              n.type == "direct" ||
                              (n.type == "scheduled" &&
                                  DateTime.parse(
                                    n.dateTime!,
                                  ).isBefore(DateTime.now())),
                        )
                        .isEmpty
                ? ListView(
                    padding: EdgeInsets.only(top: height / 2),
                    children: [
                      Center(
                        child: Text(
                          UIStrings.noNotificationsAvailable,
                          style: TextStyle(
                            fontSize: UISizes.mainSpacing,
                            fontWeight: FontWeight.w600,
                            color: UIColours.grey,
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: allNotifications.notifications?.length,
                    itemBuilder: (context, index) {
                      return allNotifications.notifications?[index].type ==
                                      "scheduled" &&
                                  DateTime.parse(
                                    allNotifications
                                        .notifications![index]
                                        .dateTime!,
                                  ).isBefore(DateTime.now()) ||
                              allNotifications.notifications?[index].type ==
                                  "direct"
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomTile(
                                leadingIcon:
                                    allNotifications
                                            .notifications?[index]
                                            .type ==
                                        "scheduled"
                                    ? UIIcons.calender
                                    : UIIcons.send,
                                title:
                                    allNotifications
                                        .notifications?[index]
                                        .title ??
                                    UIStrings.noNotificationsAvailable,
                                subTitle:
                                    allNotifications
                                        .notifications?[index]
                                        .description ??
                                    UIStrings.noNotificationsAvailable,
                              ),
                            )
                          : SizedBox.shrink();
                    },
                  ),
          ),
        ).onTap(() {
          showNotificationSelector = false;
          setState(() {});
        }),
        if (showNotificationSelector)
          Container(color: UIColours.primaryColor.withValues(alpha: 0.7)).onTap(
            () {
              showNotificationSelector = false;
              setState(() {});
            },
          ),
        if (showNotificationSelector)
          Positioned(
            right: 15,
            bottom: 90,
            child: Material(
              color: UIColours.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: UISizes.tileSubtitle,
                children: [
                  buildNotificationTile(
                    title: "Schedule Notification",
                    heroTag: "scheduled",
                    icon: Icon(
                      Icons.schedule,
                      size: 20,
                      color: UIColours.primaryColor,
                    ),
                    onTap: () {
                      showDateModalBottomSheet(
                        context,
                        height,
                        dateTime,
                        width,
                        parentcontext,
                        titleFocusNode,
                        descriptionFocusNode,
                        titleController,
                        descriptionController,
                      );
                    },
                  ),
                  buildNotificationTile(
                    title: "Direct Notification",
                    heroTag: "direct",
                    icon: Icon(
                      Icons.send_rounded,
                      size: 22,
                      color: UIColours.primaryColor,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => buildAlertDialog(
                          isScheduled: false,
                          titleFocusNode: titleFocusNode,
                          descriptionFocusNode: descriptionFocusNode,
                          context: context,
                          titleController: titleController,
                          descriptionController: descriptionController,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        Positioned(
          bottom: 20,
          right: 20,
          child: CustomFloatingButton(
            shape: CircleBorder(),
            heroTag: "notification_fab",
            color: UIColours.primaryColor,
            icon: showNotificationSelector ? UIIcons.close : UIIcons.addIcon,
            onTap: () {
              setState(
                () => showNotificationSelector = !showNotificationSelector,
              );
            },
          ),
        ),
      ],
    );
  }

  Future<dynamic> showDateModalBottomSheet(
    BuildContext context,
    double height,
    DateTime dateTime,
    double width,
    BuildContext parentcontext,
    FocusNode titleFocusNode,
    FocusNode descriptionFocusNode,
    TextEditingController titleController,
    TextEditingController descriptionController,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Container(
        height: height / 2,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Text(
              "Select Date",
              style: TextStyle(
                fontSize: UISizes.mainSpacing,
                fontWeight: FontWeight.w600,
              ),
            ),
            Divider(),
            SizedBox(
              height: height / 3,
              child: CupertinoDatePicker(
                initialDateTime: dateTime,
                mode: CupertinoDatePickerMode.date,
                minimumDate: dateTime,
                onDateTimeChanged: (value) {
                  dateTime = DateTime(
                    value.year,
                    value.month,
                    value.day,
                    dateTime.hour,
                    dateTime.minute,
                    0,
                  );
                  setState(() {});
                },
              ),
            ),
            CustomButton(
              btnWidth: width - 40,
              onButtonPressed: () {
                Future.delayed(
                  const Duration(milliseconds: 300),
                  () => showTimeModalBottomSheet(
                    context,
                    height,
                    dateTime,
                    width,
                    parentcontext,
                    titleFocusNode,
                    descriptionFocusNode,
                    titleController,
                    descriptionController,
                  ),
                );
                Navigator.pop(context);
              },
              buttonText: UIStrings.setDateBtn,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showTimeModalBottomSheet(
    BuildContext context,
    double height,
    DateTime dateTime,
    double width,
    BuildContext parentcontext,
    FocusNode titleFocusNode,
    FocusNode descriptionFocusNode,
    TextEditingController titleController,
    TextEditingController descriptionController,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) {
          bool isValidTime = dateTime.isAfter(DateTime.now());

          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                height: height / 1.8,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    Text(
                      "Select Time",
                      style: TextStyle(
                        fontSize: UISizes.mainSpacing,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: height / 3,
                      child: CupertinoDatePicker(
                        initialDateTime: dateTime,
                        mode: CupertinoDatePickerMode.time,
                        showTimeSeparator: true,
                        onDateTimeChanged: (value) {
                          dateTime = DateTime(
                            dateTime.year,
                            dateTime.month,
                            dateTime.day,
                            value.hour,
                            value.minute,
                            0,
                          );
                          setModalState(() {
                            isValidTime = dateTime.isAfter(DateTime.now());
                          });
                        },
                      ),
                    ),
                    if (!isValidTime)
                      Text(
                        "Please select a future time",
                        style: TextStyle(
                          fontSize: UISizes.labelFontSize,
                          fontWeight: FontWeight.w600,
                          color: UIColours.errorColor,
                        ),
                      ),
                    SbhSub(),
                    CustomButton(
                      btnWidth: width - 40,
                      backgroundColor: isValidTime
                          ? UIColours.primaryColor
                          : UIColours.grey,
                      onButtonPressed: isValidTime
                          ? () {
                              Navigator.pop(context);
                              Future.delayed(
                                Duration(milliseconds: 300),
                                () => showDialog(
                                  context: parentcontext,
                                  builder: (context) => buildAlertDialog(
                                    isScheduled: true,
                                    dateTime: dateTime,
                                    titleFocusNode: titleFocusNode,
                                    descriptionFocusNode: descriptionFocusNode,
                                    context: context,
                                    titleController: titleController,
                                    descriptionController:
                                        descriptionController,
                                  ),
                                ),
                              );
                            }
                          : () {},
                      buttonText: UIStrings.setTimeBtn,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildNotificationTile({
    required String title,
    required String heroTag,
    required Icon icon,
    required VoidCallback onTap,
  }) {
    return Row(
      spacing: UISizes.minSpacing,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: UISizes.tileSubtitle,
            color: UIColours.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        FloatingActionButton.small(
          shape: const CircleBorder(),
          heroTag: heroTag,
          onPressed: onTap,
          child: icon,
        ),
      ],
    ).onTap(onTap);
  }

  Widget buildAlertDialog({
    required FocusNode titleFocusNode,
    required FocusNode descriptionFocusNode,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required BuildContext context,
    required bool isScheduled,
    DateTime? dateTime,
    Notifications? allNotifications,
  }) {
    final width = MediaQuery.of(context).size.width;

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.only(
        left: UISizes.mainSpacing,
        right: UISizes.mainSpacing,
        top: UISizes.mainSpacing,
      ),
      actionsPadding: EdgeInsets.only(
        bottom: UISizes.aroundPadding,
        right: UISizes.aroundPadding,
        left: UISizes.aroundPadding,
        top: UISizes.mainSpacing + UISizes.aroundPadding,
      ),
      actionsAlignment: .spaceBetween,
      title: Center(
        child: Text(
          "Notification",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: UIColours.primaryColor,
          ),
        ),
      ),
      content: Container(
        width: width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: .start,
          spacing: UISizes.minSpacing,
          children: [
            Column(
              spacing: UISizes.midSpacing,
              children: [
                CustomTextfield(
                  focusNode: titleFocusNode,
                  hintText: UIStrings.titleHint,
                  labelText: UIStrings.titleLabel,
                  controller: titleController,
                ),
                CustomTextfield(
                  focusNode: descriptionFocusNode,
                  hintText: UIStrings.descriptionHint,
                  maxLine: 2,
                  labelText: UIStrings.descriptionLabel,
                  controller: descriptionController,
                ),
              ],
            ),
            isScheduled
                ? Text(
                    "Scheduled on: ${dateTime!.toLongDate()}, ${dateTime.toTimeOnly()}",
                    style: TextStyle(
                      fontSize: UISizes.labelFontSize,
                      fontWeight: FontWeight.w700,
                      color: UIColours.successColor,
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
      actions: [
        CustomButton(
          btnWidth: 100,
          onButtonPressed: () {
            dateTime = null;
            Navigator.pop(context);
            showNotificationSelector = false;
            setState(() {});
          },
          buttonText: "Cancel",
          backgroundColor: UIColours.grey,
        ),
        CustomButton(
          btnWidth: 100,
          onButtonPressed: () async {
            Navigator.pop(context);
            showNotificationSelector = false;
            saveNotification(
              titleController,
              descriptionController,
              isScheduled,
              dateTime,
            );

            if (isScheduled && dateTime != null) {
              final savedData = sharedPrefGetData(sharedPrefKeys.notifications);
              if (savedData != null) {
                final AllNotifications savedNotifications =
                    AllNotifications.fromJson(jsonDecode(savedData));
                final lastNotification = savedNotifications.notifications?.last;

                if (lastNotification != null) {
                  await NotificationService().scheduleNotification(
                    Notifications(
                      id: lastNotification.id,
                      title: lastNotification.title,
                      description: lastNotification.description,
                      type: "scheduled",
                      dateTime: lastNotification.dateTime,
                    ),
                  );
                }
              }
              showSnackBar(
                context,
                "Notification Scheduled successfully on ${dateTime?.toLongDate()}, ${dateTime?.toTimeOnly()}",
                UIColours.successColor,
              );
            } else {
              final savedData = sharedPrefGetData(sharedPrefKeys.notifications);
              if (savedData != null) {
                final AllNotifications savedNotifications =
                    AllNotifications.fromJson(jsonDecode(savedData));
                final lastNotification = savedNotifications.notifications?.last;

                if (lastNotification != null) {
                  await NotificationService().showInstantNotification(
                    Notifications(
                      id: lastNotification.id,
                      title: lastNotification.title,
                      description: lastNotification.description,
                      type: "direct",
                      dateTime: lastNotification.dateTime,
                    ),
                  );
                }
              }

              showSnackBar(
                context,
                "Notification sent successfully",
                UIColours.successColor,
              );
            }
            setState(() {});
          },
          buttonText: "Send",
        ),
      ],
    );
  }

  Future<void> saveNotification(
    TextEditingController titleController,
    TextEditingController descriptionController,
    bool isScheduled,
    DateTime? dateTime,
  ) async {
    final AllNotifications allNotifications =
        sharedPrefGetData(sharedPrefKeys.notifications) != null
        ? AllNotifications.fromJson(
            jsonDecode(sharedPrefGetData(sharedPrefKeys.notifications)),
          )
        : AllNotifications(notifications: [], total: 0, skip: 0, limit: 0);

    allNotifications.notifications ?? [];

    allNotifications.notifications!.add(
      Notifications(
        id: allNotifications.notifications!.length + 1,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        type: isScheduled ? "scheduled" : "direct",
        dateTime: (isScheduled ? dateTime : DateTime.now()).toString(),
      ),
    );

    allNotifications.total = allNotifications.notifications!.length;

    await sharedPrefsaveData(
      sharedPrefKeys.notifications,
      jsonEncode(allNotifications.toJson()),
    );

    log(
      "Saved Notifications: ${sharedPrefGetData(sharedPrefKeys.notifications)}",
    );
  }
}
