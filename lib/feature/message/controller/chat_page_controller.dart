import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elias_creed/core/services_class/shared_preference/shared_preferences_helper.dart';
import 'package:elias_creed/feature/message/service/chat_image_upload_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatMessage {
  final String message;
  final String time;
  final bool isUser;

  ChatMessage({
    required this.message,
    required this.time,
    required this.isUser,
  });
}

class ChatPageController extends GetxController {
  Map<String, dynamic> userModel = Get.arguments;
  String otherUserId = '';
  String otherUserName = '';
  RxString currentUserId = ''.obs;
  RxString chatId = ''.obs;
  RxString imagePath = ''.obs;
  RxnString downloadUrl = RxnString();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    otherUserId = userModel['uid'];
    otherUserName = userModel['name'];
    createOrGetChat().then((id) {
      chatId.value = id;
    });
    super.onInit();
  }

  final TextEditingController messageController = TextEditingController();

  void sendMsg() async{

    isLoading.value = true;

    final messageText = messageController.text.trim();

    if(imagePath.value.isNotEmpty){
      await uploadMsgImage();
    }
    if (messageText.isNotEmpty &&
        chatId.value.isNotEmpty &&
        downloadUrl.value != null) {
      await sendMessage(
        chatId: chatId.value,
        senderId: currentUserId.value,
        receiverId: otherUserId,
        text: messageText,
        imageUrl: downloadUrl.value,
      );
      messageController.clear();
      downloadUrl.value = null;
      imagePath.value = '';
    } else if (messageText.isNotEmpty &&
        chatId.value.isNotEmpty &&
        downloadUrl.value == null) {
      await sendMessage(
        chatId: chatId.value,
        senderId: currentUserId.value,
        receiverId: otherUserId,
        text: messageText,
      );
      messageController.clear();
      downloadUrl.value = null;
      imagePath.value = '';
    }else if(messageController.text.isEmpty &&
        chatId.value.isNotEmpty &&
        downloadUrl.value != null){
      await sendMessage(
        chatId: chatId.value,
        senderId: currentUserId.value,
        receiverId: otherUserId,
        text: '',
        imageUrl: downloadUrl.value,
      );
      messageController.clear();
      downloadUrl.value = null;
      imagePath.value = '';
    }
    isLoading.value = false;
  }

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String text,
    String? imageUrl,
  }) async {
    try {
      final chatRef = FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId);

      final message = {
        'senderId': senderId,
        'receiverId': receiverId,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
        if (imageUrl != null) 'imageUrl': imageUrl,
      };

      await chatRef.collection('messages').add(message);

      await chatRef.update({
        'lastMessage': text,
        'lastMessageTime': FieldValue.serverTimestamp(),
        'lastSenderId': senderId,
      });

      debugPrint('Message sent successfully');
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
  }

  Future<String> getChatId() async {
    currentUserId.value = await SharedPreferencesHelper.getUserUid() ?? '';
    String uid1 = currentUserId.value;
    String uid2 = otherUserId;
    return uid1.hashCode <= uid2.hashCode ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }

  Future<String> createOrGetChat() async {
    try {
      final chatId = await getChatId();
      final chatRef = FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId);

      final chatDoc = await chatRef.get();

      if (!chatDoc.exists) {
        await chatRef.set({
          'participants': [currentUserId.value, otherUserId],
          'lastMessage': '',
          'lastMessageTime': FieldValue.serverTimestamp(),
          'lastSenderId': '',
        });
      }

      return chatId;
    } catch (e) {
      debugPrint('Error creating or getting chat: $e');
      rethrow;
    }
  }

  Future<void> uploadMsgImage() async {
    downloadUrl.value = await ChatImageUploadService.uploadToFirebase(
      uid: currentUserId.value,
      imagePath: imagePath.value,
    );
  }
}
