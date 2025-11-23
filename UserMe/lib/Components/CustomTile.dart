import '../Utils/utils.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final Widget leadingIcon;
  final String title;
  final String? subTitle;
  final Icon? trailingIcon;
  final VoidCallback? onTap;
  final Color? textColor;
  const CustomTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.subTitle,
    this.trailingIcon,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 20,
      leading: leadingIcon,
      title: Text(
        title,
        style: TextStyle(
          fontSize: UISizes.tileTitle,
          color: textColor ?? UIColours.black,
        ),
      ),
      subtitle: subTitle != null
          ? Text(
              subTitle!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: UISizes.tileSubtitle,
                color: UIColours.grey,
              ),
            )
          : null,
      trailing: trailingIcon,
      onTap: onTap,
      shape: Border(
        bottom: BorderSide(
          color: UIColours.greyShade.withOpacity(0.3),
          width: 0.5,
        ),
      ),
    );
  }
}
