import 'package:flutter/material.dart';
import 'package:pryka_labs/components.dart';
import 'package:pryka_labs/projects/project_model.dart';
import 'package:pryka_labs/utils.dart';

class ProjectTile extends StatelessWidget {
  final ProjectModel model;
  final BuildContext context;
  final int index;

  const ProjectTile(
      {super.key,
      required this.model,
      required this.context,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppUtils.launchURL("http:${model.link}");
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25 - 11,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        // height: 180,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(model.coverLogo), fit: BoxFit.cover),
          // borderRadius: index == 0
          //     ? const BorderRadius.only(
          //         topLeft: Radius.circular(15.0),
          //         bottomLeft: Radius.circular(15.0),
          //       )
          //     : index % 3 == 0
          //         ? const BorderRadius.only(
          //             topRight: Radius.circular(15.0),
          //             bottomRight: Radius.circular(15.0),
          //           )
          //         : BorderRadius.circular(0)
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            // borderRadius: index == 0
            //     ? const BorderRadius.only(
            //         topLeft: Radius.circular(15.0),
            //         bottomLeft: Radius.circular(15.0),
            //       )
            //     : index % 3 == 0
            //         ? const BorderRadius.only(
            //             topRight: Radius.circular(15.0),
            //             bottomRight: Radius.circular(15.0),
            //           )
            // : BorderRadius.circular(0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // heading("${model.heading} ", 16, fontweight: FontWeight.w600),
              boldHeading(
                // MediaQuery.of(context).size.width.toString(),
                model.heading,
                center: true,

                color: Colors.white,
                10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
