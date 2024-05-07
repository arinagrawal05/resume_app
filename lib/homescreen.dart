// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pryka_labs/additional_widget.dart';
import 'package:pryka_labs/certificates_widget.dart';
import 'package:pryka_labs/colors.dart';
import 'package:pryka_labs/components.dart';
import 'package:pryka_labs/edit_avatar.dart';
import 'package:pryka_labs/education/education_widget.dart';
import 'package:pryka_labs/experience/experience_widget.dart';
import 'package:pryka_labs/projects/project_widget.dart';
import 'package:pryka_labs/skill_choosing.dart';
import 'package:pryka_labs/volunteer_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List softSkills = [];
  List hardSkills = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // randomOtp();
  }

  @override
  Widget build(BuildContext context) {
    // AuthController controller = Get.put<AuthController>(AuthController());
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 240,
            leading: Container(),
            automaticallyImplyLeading: false,
            leadingWidth: 0,
            title: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          // height: 130,
                          // margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildEditableAvatar(
                                    radius: 37.5,
                                    avatarUrl:
                                        "https://media.istockphoto.com/id/1300972574/photo/millennial-male-team-leader-organize-virtual-workshop-with-employees-online.webp?b=1&s=170667a&w=0&k=20&c=96pCQon1xF3_onEkkckNg4cC9SCbshMvx0CfKl2ZiYs=",
                                  ),
                                  // CircleAvatar(
                                  //   backgroundColor:
                                  //       Theme.of(context).canvasColor,
                                  //   minRadius: 35,
                                  //   backgroundImage: const NetworkImage(,
                                  //   ),
                                  // ),
                                  const SizedBox(width: 50),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        countBlock(
                                          19,
                                          "Projects",
                                          context,
                                        ),
                                        countBlock(
                                          4,
                                          "Work x",
                                          context,
                                        ),
                                        countBlock(2, "Followings", context,
                                            isContact: true),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              boldHeading("Hey,", 24, color: Color(0xff0F1015)),
                              boldHeading("I'm Arin Agrawal", 24,
                                  color: Color(0xff0F1015)),
                              const SizedBox(
                                height: 5,
                              ),
                              heading(
                                  "Student • Software Developer • Freelancer",
                                  16,
                                  fontweight: FontWeight.w500),
                              const SizedBox(
                                height: 5,
                              ),
                              heading(
                                  "Hello, I am a Lorem ipsum dolor sit amet, conse\nadipiscing elit, sed do eiusmod tcididun.",
                                  14,
                                  fontweight: FontWeight.w400)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              dividerColor: ColorPalatte.primaryColor,
              labelColor: ColorPalatte.primaryColor,
              indicatorColor: ColorPalatte.primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              // indicator: indicatord(),
              // indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
              indicatorWeight: 1,
              dividerHeight: 0,
              tabs: [
                customTab("Products", "assets/icons/shopping_bag.png"),
                customTab("Events", "assets/icons/msg_new.png"),
                customTab("News", "assets/icons/bookmark.png"),
              ],
            ),
          ),
          body: TabBarView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CarouselWidget(),
                      ProjectWidget(context: context),
                      ExperienceWidget(context: context),
                      EducationWidget(context: context),
                      CertificateWidget(context: context),
                      VolunteerWidget(context: context),
                      const SizedBox(
                        height: 30,
                      ),
                      skillsWidget(context),
                      AdditionalWidget(context: context),
                      const SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: heading("This is  Notes Tab", 18, color: Colors.grey),
              ),
              Center(
                child:
                    heading("This is  Bookmarks Tab", 18, color: Colors.grey),
              ),
              // Container(),
            ],
          ),
        ));
  }

  Widget skillsWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldHeading("My Skillset", 26),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            heading("Soft Skills", 15),
            GestureDetector(
                onTap: () async {
                  List? value = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectSkills(
                              defaultSkills: null,
                            )),
                  );
                  setState(() {
                    softSkills = value ?? [];
                  });
                  print(value ?? ["hello"]);
                },
                child: const Icon(Ionicons.add))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 1.0,
            runSpacing: 4.0,
            children: List.generate(
              softSkills.length,
              (index) => skillTag(softSkills[index], context, () {
                setState(() {
                  softSkills.remove(softSkills[index]);
                });
              }),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            heading("Hard Skills", 15),
            GestureDetector(
                onTap: () async {
                  List? value = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectSkills(
                              defaultSkills: null,
                            )),
                  );
                  setState(() {
                    hardSkills = value ?? [];
                  });
                  print(value ?? ["hello"]);
                },
                child: const Icon(Ionicons.add))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 1.0,
            runSpacing: 4.0,
            children: List.generate(
              hardSkills.length,
              (index) => skillTag(hardSkills[index], context, () {
                setState(() {
                  hardSkills.remove(hardSkills[index]);
                });
              }),
            ),
          ),
        ),
      ],
    );
  }

  Padding skillBox(
      BuildContext context, bool isMentorSelected, List defaultList, ontap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: ontap,
          // icon: Icon(Icons.abc),
          child: Row(
            children: [
              Text(defaultList.isEmpty ? "Select Skills" : "Re-select Skills"),
              const Spacer(),
              const Icon(Icons.chevron_right_rounded)
            ],
          )),
    );
  }

  Widget skillTag(String term, BuildContext context, ontap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        color: Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          productTileText(
            term,
            12,
            color: Color(0xff303030),
            fontweight: FontWeight.w400,
          ),
          const SizedBox(width: 4.0),
          GestureDetector(
            onTap: ontap,
            child: const Icon(
              Icons.close,
              // color: Colors.white,
              size: 16.0,
            ),
          ),
        ],
      ),
    );
    //  InputChip(
    //   backgroundColor: Colors.indigoAccent.shade100,
    //   label: Text(term,style: GoogleFonts.font,),
    //   onDeleted: () {
    //     setState(() {
    //       skill.remove(term);
    //     });
    //   },
    //   deleteIcon: Icon(Icons.cancel),
    //   deleteIconColor: Colors.red,
    //   onPressed: () {
    //     // Add any action when chip is pressed
    //   },
    // ); //  Container(

    //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
    //   margin: const EdgeInsets.symmetric(horizontal: 3),
    //   decoration: BoxDecoration(
    //     // border: Border.all(
    //     //     color: isActive ? ColorPalatte.secondaryColor : Colors.white),
    //     color: Theme.of(context)
    //         .buttonTheme
    //         .colorScheme!
    //         .inversePrimary
    //         .withOpacity(0.3),
    //     borderRadius: BorderRadius.circular(8),
    //   ),
    //   child: Row(
    //     children: [
    //       productTileText(
    //         term,
    //         10,
    //         fontweight: FontWeight.w400,
    //       ),
    //       GestureDetector(
    //         onTap: () {
    //           setState(() {
    //             skill.remove(term);
    //           });
    //         },
    //         child: Icon(Ionicons.create),
    //       )
    //     ],
    //   ),
    // );
  }

  Tab customTab(String title, String icon) {
    return Tab(
      child: const SizedBox(
        width: 100,
      ),
      height: 50,
      icon: Image.asset(icon, height: 27),
      // child: heading(title, 12),
      iconMargin: const EdgeInsets.only(bottom: 0),
    );
  }
}
