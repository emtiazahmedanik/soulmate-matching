import 'package:elias_creed/core/global_widegts/custom_button.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/view/about.dart'
    show About;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:elias_creed/core/style/global_text_style.dart'
    show globalTextStyle;
import 'package:elias_creed/feature/auth/signup/profile_flow/controller/profile_flow_controller.dart';

class AddPhotos extends StatelessWidget {
  AddPhotos({super.key});

  final ProfileFlowController controller = Get.find<ProfileFlowController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = 12.0;
    final crossAxisCount = 3;
    final itemWidth =
        (screenWidth - (spacing * (crossAxisCount + 1))) / crossAxisCount;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Photo",
              style: globalTextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Remember your first upload photo will be your profile picture",
              style: globalTextStyle(
                color: Color(0xFFCCCCCC).withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: 40),
            // Modified GridView.builder to fix improper Obx usage
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: itemWidth / 195,
              ),
              itemBuilder: (context, index) {
                return DragTarget<int>(
                  // Accept drag data of type int (index of dragged item)
                  onWillAcceptWithDetails: (details) {
                    // Allow dropping only if the target index is different and the dragged item has an image
                    return details.data != index &&
                        controller.images[details.data].value != null;
                  },
                  onAcceptWithDetails: (details) {
                    // Swap images between dragged index and target index
                    final draggedIndex = details.data;
                    final temp = controller.images[index].value;
                    controller.images[index].value =
                        controller.images[draggedIndex].value;
                    controller.images[draggedIndex].value = temp;
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Draggable<int>(
                      // Data is the index of the current item
                      data: index,
                      // Feedback widget shown while dragging
                      feedback: Container(
                        height: 195,
                        width: itemWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white, width: 2),
                          image: controller.images[index].value != null
                              ? DecorationImage(
                                  image: FileImage(
                                    controller.images[index].value!,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: controller.images[index].value == null
                            ? Icon(
                                Icons.add_a_photo,
                                size: 40,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      // Child when dragging
                      childWhenDragging: Container(
                        height: 195,
                        width: itemWidth,
                        decoration: BoxDecoration(
                          color: Color(0xFF252525),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFF6B7280),
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () => controller.pickImage(index),
                        // Moved Obx to wrap only the Container that depends on images[index]
                        child: Obx(
                          () => Container(
                            height: 195,
                            width: itemWidth,
                            decoration: BoxDecoration(
                              color: controller.images[index].value == null
                                  ? Color(0xFF252525)
                                  : null,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xFF6B7280),
                                width: 1.5,
                              ),
                              image: controller.images[index].value != null
                                  ? DecorationImage(
                                      image: FileImage(
                                        controller.images[index].value!,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: controller.images[index].value == null
                                ? Icon(Icons.add_a_photo, size: 40)
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Spacer(),
            CustomButton(
              title: "Next",
              ontap: () async {
                final hasNoImage = controller.images.every(
                  (img) => img.value == null,
                );

                if (hasNoImage) {
                  EasyLoading.showError('Please Select Image');
                  return;
                } else {
                  await controller.uploadInFirebaseStorage();
                  Get.to(() => About());
                }

              },
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
