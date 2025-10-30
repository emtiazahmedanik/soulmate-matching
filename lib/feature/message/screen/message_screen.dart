import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elias_creed/core/const/image_path.dart';
import 'package:elias_creed/feature/message/controller/chat_page_controller.dart';
import 'package:elias_creed/feature/message/widget/build_chat_message_black.dart';
import 'package:elias_creed/feature/message/widget/build_chat_message_white.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});
  final ChatPageController controller = Get.put(ChatPageController());
  final RxBool showOptions = false.obs;

  @override
  Widget build(BuildContext context) {
    final String name = controller.otherUserName;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Stack(
          children: [
            Positioned.fill(
              bottom: 80,
              child: controller.chatId.value.isEmpty
                  ? loadShimmer()
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('chats')
                          .doc(controller.chatId.value)
                          .collection('messages')
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          // SHIMMER LOADING EFFECT
                          return loadShimmer();
                        }
                        final messages = snapshot.data!.docs;
                        return ListView.builder(
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final msg = messages[index];
                            final isMe =
                                msg['senderId'] ==
                                controller.currentUserId.value;
                            final timestamp = msg['timestamp'];
                            String? imageUrl;
                            DateTime? dateTime;
                            String formattedTime = '';
                            if (timestamp != null) {
                              dateTime = (timestamp as Timestamp).toDate();
                              formattedTime = DateFormat(
                                'hh:mm a',
                              ).format(dateTime);
                            }
                            final data = msg.data();
                            if (data.containsKey('imageUrl')) {
                              imageUrl = data['imageUrl'];
                            }
                            return isMe
                                ? buildChatMessageWhite(
                                    message: msg['text'],
                                    time: formattedTime.toString(),
                                    imageUrl: imageUrl,
                                  )
                                : buildChatMessageBlack(
                                    message: msg['text'],
                                    time: formattedTime.toString(),
                                    imageUrl: imageUrl,
                                  );
                          },
                        );
                      },
                    ),
            ),
            Positioned(
              bottom: 105,
              left: 24,
              right: 24,
              child: Obx(
                () => Visibility(
                  visible: showOptions.value,
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF252525),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (image != null) {
                          showOptions.value = false;
                          controller.imagePath.value = image.path;
                          if (kDebugMode) {
                            print('Selected image path: ${image.path}');
                          }
                        }
                      },
                      child: Image.asset(
                        ImagePath.addImage,
                        width: 32,
                        height: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.imagePath.value.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                File(controller.imagePath.value),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  controller.imagePath.value = '';
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        margin: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          bottom: 24,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDFE1E7),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          controller: controller.messageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message...",
                            hintStyle: const TextStyle(
                              color: Color(0xFF818898),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            prefixIcon: Obx(
                              () => IconButton(
                                icon: Icon(
                                  showOptions.value ? Icons.close : Icons.add,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  showOptions.value = !showOptions.value;
                                },
                              ),
                            ),
                            suffixIcon: !controller.isLoading.value
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.send,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {                                     
                                      controller.sendMsg();
                                    },
                                  )
                                : CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Shimmer loadShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 6, // number of placeholder messages
        reverse: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Align(
              alignment: index % 2 == 0
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
