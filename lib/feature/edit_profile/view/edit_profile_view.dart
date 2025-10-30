import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/edit_profile_controller.dart';
import '../widget/image_upload_row.dart';
import '../widget/social_media_links_edit.dart';
import '../widget/labeled_input_field.dart';
import '../widget/about_me_input.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});
  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(result: true),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image upload section (placeholder)
            ImageUploadRow(),
            const SizedBox(height: 24),
            // Name
            LabeledInputField(
              label: 'Name',
              controller: controller.nameController,
              decoration: _inputDecoration(),
            ),
            const SizedBox(height: 16),
            // Nationality dropdown
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nationality',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  value: controller.nationality.value,
                  items: controller.nationalityOptions
                      .map(
                        (n) => DropdownMenuItem(
                          value: n,
                          child: Text(
                            n,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => controller.nationality.value = val!,
                  dropdownColor: const Color(0xFF252525),
                  decoration: _inputDecoration(),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Gender (fixed)
            LabeledInputField(
              label: 'Gender',
              initialValue: controller.gender,
              enabled: false,
              decoration: _inputDecoration(),
            ),
            const SizedBox(height: 16),
            // Date of Birth
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Date of Birth',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: controller.dobController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2001, 2, 12),
                      firstDate: DateTime(1970),
                      lastDate: DateTime.now(),
                      builder: (context, child) =>
                          Theme(data: ThemeData.dark(), child: child!),
                    );
                    if (picked != null) {
                      controller.dobController.text = DateFormat(
                        'yyyy-MM-dd',
                      ).format(picked);
                    }
                  },
                  decoration: _inputDecoration(
                    suffixIcon: Icons.calendar_today,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Height
            Row(
              children: [
                Expanded(
                  child: LabeledInputField(
                    label: 'Height',
                    controller: controller.heightController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration(),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('cm', style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 16),
            // Weight
            Row(
              children: [
                Expanded(
                  child: LabeledInputField(
                    label: 'Weight',
                    controller: controller.weightController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration(),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('kg', style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 16),
            // Education
            LabeledInputField(
              label: 'Education',
              controller: controller.educationController,
              decoration: _inputDecoration(),
            ),
            const SizedBox(height: 24),
            // About Me
            AboutMeInput(controller: controller.aboutMeController),
            const SizedBox(height: 32),
            // Social Media Section (placeholder)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                border: Border.all(color: const Color(0xFF303030)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SocialMediaLinksEdit(),
            ),
            const SizedBox(height: 32),
            // Save Changes Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C0B0B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  controller.onTapSaveChange();
                },
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration _inputDecoration({IconData? suffixIcon}) {
  return InputDecoration(
    filled: true,
    fillColor: const Color(0xFF252525),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF78C8FF)),
    ),
    suffixIcon: suffixIcon != null
        ? Icon(suffixIcon, color: Colors.white70)
        : null,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
  );
}
