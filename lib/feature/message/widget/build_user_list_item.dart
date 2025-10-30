import 'package:elias_creed/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildUserListItem(Map<String, dynamic> user) {
  return Card(
    color: Colors.grey[900],
    margin: const EdgeInsets.symmetric(vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: ListTile(
      contentPadding: const EdgeInsets.all(12),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.blueAccent,
        child: Text(
          user['name'][0],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        user['name'],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        user['lastMessage'],
        style: TextStyle(color: Colors.grey[400], fontSize: 14),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            user['time'],
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
          if (user['unread'] > 0)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${user['unread']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        Get.snackbar('Chat', 'Opening chat with ${user['name']}');
        Get.toNamed(AppRoute.messageScreen);
      },
    ),
  );
}
