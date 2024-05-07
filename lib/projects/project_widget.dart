import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pryka_labs/experience/add_experience.dart';
import 'package:pryka_labs/projects/add_project.dart';
import 'package:pryka_labs/projects/edit_project.dart';
import 'package:pryka_labs/experience/experience_model.dart';
import 'package:pryka_labs/components.dart';
import 'package:pryka_labs/education/education_tile.dart';
import 'package:pryka_labs/experience/experience_tile.dart';
import 'package:pryka_labs/projects/project_model.dart';
import 'package:pryka_labs/projects/project_tile.dart';
import 'package:pryka_labs/utils.dart';
import 'package:uuid/uuid.dart';

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: homeHeading(
                  "My Projects",
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () async {
                        var uuid = const Uuid().v4();
                        AppUtils.navigate(
                            AddProjectPage(companyid: uuid, model: null),
                            context);
                      },
                      child: const Icon(
                        Icons.add,
                        size: 34,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () async {
                        AppUtils.navigate(EditProjectPage(), context);
                      },
                      child: Image.asset(
                        "assets/icons/edit_pen.png",
                        height: 20,
                      )),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              // decoration:
              //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
              width: double.infinity,
              height: 225,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Projects")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data!.docs.isEmpty) {
                    return GestureDetector(
                      onTap: () {
                        var uuid = const Uuid().v4();
                        AppUtils.navigate(
                            AddProjectPage(companyid: uuid, model: null),
                            context);
                      },
                      child: Container(
                        height: 180,

                        // margin: EdgeInsets.only(
                        //     right:
                        //         MediaQuery.of(context).size.width * 5 / 2 + 12),

                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                        ),
                        // width: MediaQuery.of(context).size.width / 4,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Ionicons.add_circle_outline,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              heading("Add\nyour first\nproject", 14,
                                  center: true, fontweight: FontWeight.w600),
                            ]),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return customCircularLoader("Projects");
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // return Text("erfdfv");
                          ProjectModel model = ProjectModel.fromFirestore(
                              snapshot.data!.docs[index]);
                          return
                              // Text("data");
                              ProjectTile(
                            model: model,
                            context: context,
                            index: index,
                          );
                        });
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
