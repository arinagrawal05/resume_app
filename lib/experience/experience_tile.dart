import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pryka_labs/experience/add_experience.dart';
import 'package:pryka_labs/components.dart';
import 'package:pryka_labs/experience/experience_model.dart';
import 'package:pryka_labs/edit_avatar.dart';
import 'package:pryka_labs/utils.dart';

class ExperienceTile extends StatelessWidget {
  final ExperienceModel model;
  final BuildContext context;

  const ExperienceTile({super.key, required this.model, required this.context});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            AppUtils.navigate(
                AddExperiencePage(companyid: model.id, model: model), context);
          },
          child: buildEditableAvatar(avatarUrl: model.coverLogo),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading("${model.title} • ${model.type}", 14,
                fontweight: FontWeight.w600, color: const Color(0xff171717)),
            heading(
              model.location,
              12,
              fontweight: FontWeight.w400,
            ),
            heading(
                !model.isPresent
                    ? "${DateFormat('MMMM yyyy').format(model.startDate.toDate())} - ${DateFormat('MMMM yyyy').format(model.endDate.toDate())}"
                    : "${DateFormat('MMMM yyyy').format(model.startDate.toDate())} - Now",
                12,
                fontweight: FontWeight.w400,
                color: const Color(0xff616161)),
            const SizedBox(
              height: 8,
            ),
            model.role == ""
                ? Container()
                : SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        children: [
                          TextSpan(
                            text: 'Role ',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: const Color(0xff2F2F2F)),
                          ),
                          TextSpan(
                            text: model.role,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: const Color(0xff2F2F2F)),
                          ),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(
              height: 3,
            ),
            model.link == ""
                ? Container()
                : GestureDetector(
                    onTap: () {
                      AppUtils.launchURL("http:${model.link}");
                    },
                    child: heading("Checkout my Work", 12,
                        fontweight: FontWeight.w400,
                        color: const Color(0xffF54E44)),
                  )
          ],
        )
      ],
    );
  }
}
