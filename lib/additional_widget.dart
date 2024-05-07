import 'package:flutter/material.dart';
import 'package:pryka_labs/components.dart';

class AdditionalWidget extends StatelessWidget {
  const AdditionalWidget({
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
                  "Additional Work",
                ),
              ),
              Container()
            ],
          ),
          // const SizedBox(
          //   height: 5,
          // ),

          heading(
              "Hello, I am a Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
              12,
              fontweight: FontWeight.w400,
              color: Color(0xff5B5B5B))
        ],
      ),
    );
  }
}
