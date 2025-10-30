import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../controller/edit_profile_controller.dart';

class ImageUploadRow extends StatelessWidget {
  ImageUploadRow({super.key});
  final EditProfileController controller = Get.find();
  final ImagePicker _picker = ImagePicker();

  static const double slotWidth = 90;
  static const double slotHeight = 120;
  static const double slotGap = 16;
  static const double rowWidth = slotWidth * 3 + slotGap * 2;

  Future<void> _pickImage(int index) async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      controller.images[index].value = File(picked.path);
    }
  }

  Widget _imageSlot(int i) {
    final imagePath = controller.images[i].value;
    return GestureDetector(
      onTap: () => _pickImage(i),
      child: Container(
        width: slotWidth,
        height: slotHeight,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: imagePath == null ? const Color(0xFF252525) : null,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF6B7280),
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Stack(
          children: [
            if (imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child:Image.file(
                        File(imagePath.path),
                        fit: BoxFit.cover,
                        width: slotWidth,
                        height: slotHeight,
                      ),
              ),
            if (imagePath == null)
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(Icons.add, color: Colors.white, size: 28),
                ),
              ),
            if (imagePath != null)
              Positioned(
                right: 6,
                bottom: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: SizedBox(
          width: rowWidth,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (i) => _imageSlot(i)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: slotWidth / 2),
                  _imageSlot(3),
                  SizedBox(width: slotGap),
                  _imageSlot(4),
                  SizedBox(width: slotWidth / 2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
