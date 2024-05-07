import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pryka_labs/experience/add_experience.dart';
import 'package:pryka_labs/experience/experience_model.dart';
import 'package:pryka_labs/components.dart';
import 'package:pryka_labs/experience/experience_tile.dart';
import 'package:pryka_labs/edit_avatar.dart';
import 'package:pryka_labs/utils.dart';
import 'package:uuid/uuid.dart';

class ExperienceWidget extends StatelessWidget {
  const ExperienceWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: homeHeading(
                  "Work Experience",
                ),
              ),
              GestureDetector(
                  onTap: () async {
                    var uuid = Uuid().v4();
                    AppUtils.navigate(
                        AddExperiencePage(companyid: uuid, model: null),
                        context);
                  },
                  child: const Icon(
                    Icons.add,
                    size: 34,
                  ))
            ],
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("Experience").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data!.docs.isEmpty) {
                return defaultThumbnail("work experience", () {
                  var uuid = Uuid().v4();
                  AppUtils.navigate(
                      AddExperiencePage(companyid: uuid, model: null), context);
                }, context);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return customCircularLoader("Experience");
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // return Text("erfdfv");
                      ExperienceModel model = ExperienceModel.fromFirestore(
                          snapshot.data!.docs[index]);
                      return ExperienceTile(model: model, context: context);
                    });
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              heading("See More ", 14,
                  fontweight: FontWeight.w400, color: Color(0xff0F1015)),
              Icon(Ionicons.chevron_down)
            ],
          )
        ],
      ),
    );
  }
}
