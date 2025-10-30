import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elias_creed/feature/message/controller/chat_controller.dart';
import 'package:elias_creed/feature/message/screen/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where(
              'participants',
              arrayContains: controller.currentUserId.value,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) => _buildShimmerItem(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No chats yet.',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          final chats = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              final participants = List<String>.from(chat['participants']);
              final otherUserId = participants.firstWhere(
                (id) => id != controller.currentUserId.value,
              );

              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(otherUserId)
                    .get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return _buildShimmerItem();
                  }

                  if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                    return const SizedBox();
                  }

                  final otherUser = userSnapshot.data!;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(otherUser['photos'][0]),
                    ),
                    title: Text(
                      otherUser['name'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      chat['lastMessage'] ?? '',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    onTap: () {
                      Get.to(
                        () => MessageScreen(),
                        arguments: {
                          'uid': otherUser.id,
                          'name': otherUser['name'],
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

    Widget _buildShimmerItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[700]!,
            child: CircleAvatar(radius: 25, backgroundColor: Colors.grey[800]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[700]!,
                  child: Container(
                    width: double.infinity,
                    height: 12,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 6),
                Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[700]!,
                  child: Container(
                    width: 150,
                    height: 10,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
