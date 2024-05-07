import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pryka_labs/experience/add_experience.dart';
import 'package:pryka_labs/projects/add_project.dart';
import 'package:pryka_labs/components.dart';
import 'package:pryka_labs/experience/experience_model.dart';
import 'package:pryka_labs/edit_avatar.dart';
import 'package:pryka_labs/projects/project_model.dart';
import 'package:pryka_labs/utils.dart';

class ProjectListTile extends StatelessWidget {
  final ProjectModel model;
  final BuildContext context;

  const ProjectListTile(
      {super.key, required this.model, required this.context});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              AppUtils.navigate(
                  AddProjectPage(companyid: model.id, model: model), context);
            },
            child: buildEditableAvatar(avatarUrl: model.coverLogo),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading("${model.heading}", 16, fontweight: FontWeight.w600),
              heading(
                model.link,
                14,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 150,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    children: [
                      TextSpan(
                        text: 'Description ',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: model.description,
                        style: GoogleFonts.nunito(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
    ();
  }
}
