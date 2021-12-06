import 'package:flutter/material.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool isBackButtonExist;
  final IconData? icon;
  final VoidCallback? onActionPressed;
  final Function? onBackPressed;

  const CustomAppBar(
      {required this.title,
      this.isBackButtonExist = true,
      this.icon,
      this.onActionPressed,
      this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ColorFiltered(
        colorFilter:
            ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.color),
        child: Image.asset(
          Images.toolbar_background,
          fit: BoxFit.fill,
          height: Dimensions.CATEGORY_WIDTH_DEFAULT +
              MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: Dimensions.CATEGORY_WIDTH_DEFAULT,
        alignment: Alignment.center,
        child: Row(children: [
          if (isBackButtonExist)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  size: 20, color: Colors.white),
              onPressed: () => onBackPressed != null
                  ? onBackPressed!()
                  : Navigator.of(context).pop(),
            )
          else
            const SizedBox.shrink(),
          const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(
            child: Text(
              title,
              style:
                  titilliumRegular.copyWith(fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (icon != null)
            IconButton(
              icon: Icon(icon,
                  size: Dimensions.ICON_SIZE_LARGE, color: Colors.white),
              onPressed: onActionPressed,
            )
          else
            const SizedBox.shrink(),
        ]),
      ),
    ]);
  }
}
