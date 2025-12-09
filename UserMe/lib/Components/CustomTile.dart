import 'package:UserMe/Utils/extensions.dart';

import '../Utils/utils.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatefulWidget {
  final Widget leadingIcon;
  final String title;
  final String? subTitle;
  final bool? showTrailingIcon;
  final VoidCallback? trailingIconTap;
  final VoidCallback? onTap;
  final bool? isFav;
  final Color? textColor;
  const CustomTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.subTitle,
    this.showTrailingIcon = false,
    this.trailingIconTap,
    this.textColor,
    this.onTap,
    this.isFav,
  });

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 20,
      leading: widget.leadingIcon,
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: UISizes.tileTitle,
          color: widget.textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: widget.subTitle.isNotNullOrEmpty
          ? Text(
              widget.subTitle!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: UISizes.tileSubtitle,
                color: UIColours.grey,
              ),
            )
          : null,
      trailing: widget.showTrailingIcon == true
          ? IconButton(
              icon: widget.isFav == true
                  ? UIIcons.favoriteFilled
                  : UIIcons.favorite,
              onPressed: widget.trailingIconTap,
            )
          : UIIcons.arrowBtnIcon,
      onTap: widget.onTap,
      shape: Border(
        bottom: BorderSide(
          color: UIColours.grey.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
    );
  }
}
