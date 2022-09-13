import '../../../../controller/add_img_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Future<ImageSource> showImgSorce(BuildContext context) async {
  AddImgController controller = Get.find();

  return await showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(
                controller.choseImgFrom(ImageSource.camera),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.camera),
              title: Text('Chose from camera'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(
                controller.choseImgFrom(ImageSource.gallery),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.image),
              title: Text('Chose from gallary'),
            ),
          ),
        ],
      );
    },
  );
}
