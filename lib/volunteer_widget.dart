import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pryka_labs/education/education_model.dart';
import 'package:pryka_labs/components.dart';
import 'package:pryka_labs/education/education_tile.dart';
import 'package:pryka_labs/edit_avatar.dart';

class VolunteerWidget extends StatelessWidget {
  const VolunteerWidget({
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
                  "Volunteer Work",
                ),
              ),
              GestureDetector(
                  onTap: () async {
                    // var uuid = Uuid().v4();
                    // AppUtils.navigate(
                    //     AddEducationPage(companyid: uuid, model: null),
                    //     context);
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
                FirebaseFirestore.instance.collection("Volunteers").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data!.docs.isEmpty) {
                return defaultThumbnail("volunteer work", () {
                  // var uuid = Uuid().v4();
                  // AppUtils.navigate(
                  //     AddEducationPage(companyid: uuid, model: null), context);
                }, context);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return customCircularLoader("Volunteers");
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // return Text("erfdfv");
                      EducationModel model = EducationModel.fromFirestore(
                          snapshot.data!.docs[index]);
                      return EducationTile(model: model, context: context);
                    });
              }
            },
          )
        ],
      ),
    );
  }
}
