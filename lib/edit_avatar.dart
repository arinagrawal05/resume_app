import 'package:flutter/material.dart';
import 'package:pryka_labs/components.dart';

Widget buildEditableAvatar(
    {String? avatarUrl, double radius = 27.5, bool isAsset = false}) {
  return Stack(
    children: [
      avatarUrl == null
          ? CircleAvatar(
              radius: radius,
              backgroundColor: Color(0xffFFEEEE),
            )
          : isAsset
              ? CircleAvatar(
                  radius: radius,
                  backgroundImage: AssetImage(avatarUrl),
                )
              : CircleAvatar(
                  radius: radius,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Image.asset(
              "assets/icons/edit_pen.png",
              height: 13,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget defaultThumbnail(String type, ontap, BuildContext context) {
  return GestureDetector(
    onTap: ontap,
    child: Row(children: [
      buildEditableAvatar(),
      const SizedBox(
        width: 10,
      ),
      heading("Add your first $type", 14, fontweight: FontWeight.w600),
    ]),
  );
}
