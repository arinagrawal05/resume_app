import 'package:flutter/material.dart';
import 'package:pryka_labs/Education/add_education.dart';
import 'package:pryka_labs/components.dart';
import 'package:pryka_labs/education/education_model.dart';
import 'package:pryka_labs/edit_avatar.dart';
import 'package:pryka_labs/utils.dart';

class EducationTile extends StatelessWidget {
  final EducationModel model;
  final BuildContext context;

  const EducationTile({super.key, required this.model, required this.context});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            AppUtils.navigate(
                AddEducationPage(companyid: model.id, model: model), context);
          },
          child: buildEditableAvatar(avatarUrl: model.coverLogo),

          //  CircleAvatar(
          //   backgroundImage: NetworkImage(model.coverLogo),
          //   radius: 30,
          // ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading("${model.institute} ", 14,
                fontweight: FontWeight.w600, color: const Color(0xff171717)),
            heading(model.degree, 12,
                fontweight: FontWeight.w500, color: const Color(0xff171717)),
            heading(
                !model.isPresent
                    ? "${model.location} • ${model.startDate.toDate().year} - ${model.endDate.toDate().year}"
                    : "${model.location} • ${model.startDate.toDate().year} - Now",
                12,
                fontweight: FontWeight.w400,
                color: const Color(0xff616161))
          ],
        )
      ],
    );
  }
}
