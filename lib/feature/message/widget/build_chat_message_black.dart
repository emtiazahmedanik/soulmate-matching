import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildChatMessageBlack({
  required String message,
  required String time,
  String? imageUrl,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,

    children: [
      Container(
        width: 230,
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Color(0xFF252525),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        child: Column(
          children: [
            if(imageUrl != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            if(message.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.6,
                  color: Color(0xFFCCCCCC),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  time,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xFF757575),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
