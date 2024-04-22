import 'package:flutter/material.dart';

class ContactPhotoWithEditIcon extends StatelessWidget {
  final String photoUrl;
  final VoidCallback onTapEdit;

  const ContactPhotoWithEditIcon({
    required this.photoUrl,
    required this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: 
               NetworkImage("https://via.placeholder.com/300"),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onTapEdit,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              
            ),
          ),
        ),
      ],
    );
  }
}