import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pryka_labs/Education/add_education.dart';
import 'package:pryka_labs/components.dart';
import 'package:pryka_labs/education/education_model.dart';
import 'package:pryka_labs/education/education_tile.dart';
import 'package:pryka_labs/edit_avatar.dart';
import 'package:pryka_labs/utils.dart';
import 'package:uuid/uuid.dart';

class CertificateWidget extends StatelessWidget {
  const CertificateWidget({
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
                  "Courses & Certification",
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
            stream: FirebaseFirestore.instance
                .collection("Certificates")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data!.docs.isEmpty) {
                return defaultThumbnail("courses & certification", () {
                  var uuid = Uuid().v4();
                  AppUtils.navigate(
                      AddEducationPage(companyid: uuid, model: null), context);
                }, context);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return customCircularLoader("Certificates");
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
