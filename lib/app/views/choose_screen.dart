import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/data/dummy.dart';
import 'package:my_breath_work/app/http/controllers/choose_controller.dart';
import 'package:my_breath_work/app/services/local_storage.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/button.dart';
import 'package:my_breath_work/app/widgets/choose_label.dart';
import 'package:my_breath_work/app/widgets/custom_spacing.dart';
import 'package:my_breath_work/app/widgets/home_row.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;

class ChooseScreen extends StatelessWidget {
  ChooseScreen({super.key});
  final ChooseController chooseController = Get.put(ChooseController());

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      transparent: true,
      body: Obx(
        () => Opacity(
          opacity: chooseController.loading.value ? .35 : 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HomeRow(),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: verticalSpace(context, .03),
                            horizontal: horizontalSpace(context, .02)
                          ),
                          child: const CustomText(
                            text: "Create your personal Breathwork session",
                            fontSize: 25,
                            textColor: KColors.white,
                            fontWeight: FontWeight.bold,
                            centerText: true,
                          ),
                        ),
                        const ChooseLabel(icon: Icons.emoji_emotions, label: "1. Select Voice"),
                        const CustomSpacing(height: .02),
                        SizedBox(
                          height: verticalSpace(context, .425),
                          width: 380,
                          child: Center(
                            child: cs.CarouselSlider(
                              items: [
                                ...List.generate(
                                  voices.length,
                                  (index) => GestureDetector(
                                    onTap: (){
                                      if(!chooseController.loading.value){
                                        chooseController.togglePlayer();
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Obx(
                                          () => 
                                          Transform(
                                            transform: Matrix4.skewY(index != chooseController.voice.value ? .2 : 0),
                                            child: Container(
                                              height: verticalSpace(context, .35),
                                              color: Colors.black.withOpacity(index == chooseController.voice.value ? 0 : .2),
                                              child: Image(
                                                image: AssetImage('assets/images/${voices[index]['image']}.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const CustomSpacing(height: .02),
                                        CustomText(
                                          text: voices[index]['name'],
                                          fontSize: 20,
                                          textColor: KColors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              options: cs.CarouselOptions(
                                initialPage: chooseController.voice.value,
                                height: verticalSpace(context, .5),
                                viewportFraction: .7,
                                enlargeFactor: .175,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason){
                                  chooseController.voice.value = index;
                                  if(!chooseController.loading.value){
                                    chooseController.togglePlayer();
                                  }
                                },
                                enableInfiniteScroll: false,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => CustomText(
                      text: voices[chooseController.voice.value]['label'],
                      fontSize: 14,
                      textColor: KColors.lightGrey,
                    ),
                  ),
                  const CustomSpacing(height: .075),
                  const ChooseLabel(icon: Icons.music_note, label: "2. Select Music"),
                  const CustomSpacing(height: .05),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: Center(
                      child: cs.CarouselSlider(
                        items: [
                          ...List.generate(
                            tracks.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  if(!chooseController.loading.value){
                                    chooseController.loadMusic(tracks[chooseController.music.value]['music']);
                                  }
                                },
                                child: Obx(
                                  () => Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: index == chooseController.music.value ? KColors.primary : KColors.secondary,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        child: CustomText(
                                          text: tracks[index]['label'],
                                          fontSize: 16,
                                          textColor: Colors.white,
                                          centerText: true,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        options: cs.CarouselOptions(
                          initialPage: chooseController.music.value,
                          height: 50,
                          viewportFraction: .6,
                          enlargeFactor: .2,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason){
                            chooseController.music.value = index;
                            if(!chooseController.loading.value){
                              chooseController.loadMusic(tracks[chooseController.music.value]['music']);
                            }
                          },
                          enableInfiniteScroll: false,
                        ),
                      ),
                    ),
                  ),
                  const CustomSpacing(height: .05),
                  CustomText(
                    text: "Gives you energy boost and the strength to fight.",
                    fontSize: 14,
                    textColor: KColors.lightGrey,
                  ),
                  const CustomSpacing(height: .05),
                  const ChooseLabel(icon: Icons.music_note, label: "3. Select Purpose"),
                  const CustomSpacing(height: .05),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: Center(
                      child: cs.CarouselSlider(
                        items: [
                          ...List.generate(
                            purposes.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  if(!chooseController.loading.value){
                                    chooseController.loadMusic(purposes[chooseController.purpose.value]['purpose']);
                                  }
                                },
                                child: Obx(
                                  () => Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: index == chooseController.purpose.value ? KColors.primary : KColors.secondary,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        child: CustomText(
                                          text: purposes[index]['label'],
                                          fontSize: 16,
                                          textColor: Colors.white,
                                          centerText: true,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        options: cs.CarouselOptions(
                          initialPage: chooseController.purpose.value,
                          height: 50,
                          viewportFraction: .6,
                          enlargeFactor: .2,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason){
                            chooseController.purpose.value = index;
                            if(!chooseController.loading.value){
                              chooseController.loadMusic(purposes[chooseController.purpose.value]['purpose']);
                            }
                          },
                          enableInfiniteScroll: false,
                        ),
                      ),
                    ),
                  ),
                  const CustomSpacing(height: .05),
                  CustomText(
                    text: "Gives you energy boost and the strength to fight.",
                    fontSize: 14,
                    textColor: KColors.lightGrey,
                  ),
                  const CustomSpacing(height: .075),
                  CustomButton(
                    width: 250,
                    onPressed: (){
                      chooseController.createBreathwork();
                    },
                    text: 'Create',
                  ),
                  Visibility(
                    visible: Get.arguments != null ? Get.arguments['from'].toString() != 'try_free' : true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomSpacing(height: .05),
                        StreamBuilder(
                          stream: chooseController.breathworkSnapshots(),
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              if(snapshot.data!.docs.isEmpty){
                                return Container();
                              }
                              List docs = snapshot.data!.docs.where(
                                (doc) => doc['user'] == FirebaseAuth.instance.currentUser!.email
                              ).toList();
                              return SizedBox(
                                width: 350,
                                child: ListView.builder(
                                  itemCount: docs.length,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) => ListTile(
                                    onTap: () async {
                                      await storeId(docs[index].id);
                                      Get.toNamed(
                                        '/my_breathwork',
                                        arguments: {
                                          'breathwork_id': docs[index].id,
                                        }
                                      );
                                    },
                                    tileColor: KColors.primaryDark,
                                    leading: const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: KColors.secondary,
                                      child: Icon(
                                        Icons.mic,
                                        color: KColors.primaryTransparent,
                                        size: 30,
                                      ),
                                    ),
                                    title: CustomText(
                                      text: docs[index]['title'],
                                      fontSize: 18,
                                      textColor: KColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    subtitle: CustomText(
                                      text: "${docs[index]['voice']} - ${docs[index]['music']} - ${docs[index]['purpose']}",
                                      fontSize: 15,
                                      textColor: KColors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    trailing: const Icon(
                                      Icons.delete,
                                      color: KColors.secondaryDark,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }
                        ),
                      ],
                    ),
                  ),
                  const CustomSpacing(height: .075),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}