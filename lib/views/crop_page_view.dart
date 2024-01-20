import 'dart:io';
import 'dart:typed_data';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:manga_reading/support/auth_provider.dart';
import 'package:manga_reading/support/user_actions.dart';

class CropPageView extends StatefulWidget {
  final File imageFile;

  const CropPageView({
    super.key,
    required this.imageFile,
  });

  @override
  State<CropPageView> createState() => _CropPageViewState();
}

class _CropPageViewState extends State<CropPageView> {
  bool canSave = true;

  CustomImageCropController controller = CustomImageCropController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: MediaQuery.of(context).size.width * .4,
        leading: Container(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        actions: [
          canSave
              ? TextButton(
                  onPressed: () async {
                    if (canSave == true) {
                      setState(() {
                        canSave = false;
                      });

                      final image = await controller.onCropImage();
                      if (image != null) {
                        Navigator.of(context).pop();

                        Uint8List bodyBytes = image.bytes;
                        String fileName = '${currentUser!.id}.jpg';

                        Reference reference = FirebaseStorage.instance
                            .ref()
                            .child('users_images');

                        Reference imageToUpload = reference.child(fileName);

                        await imageToUpload.putData(bodyBytes);
                        final imagePath = await imageToUpload.getDownloadURL();

                        await setUserImage(imagePath);
                      }
                    }
                  },
                  child: Text(
                    'done'.toUpperCase(),
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                )
              : const Text(''),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomImageCrop(
              image: FileImage(widget.imageFile),
              cropController: controller,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    size: 30,
                    color: Colors.grey,
                  ),
                  onPressed: controller.reset,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.zoom_in,
                        size: 30,
                        color: Colors.grey,
                      ),
                      onPressed: () => controller.addTransition(
                        CropImageData(scale: 1.33),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.zoom_out,
                        size: 30,
                        color: Colors.grey,
                      ),
                      onPressed: () => controller.addTransition(
                        CropImageData(scale: 0.75),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.rotate_left,
                        size: 30,
                        color: Colors.grey,
                      ),
                      onPressed: () => controller.addTransition(
                        CropImageData(angle: -3.14 / 4),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.rotate_right,
                        size: 30,
                        color: Colors.grey,
                      ),
                      onPressed: () => controller.addTransition(
                        CropImageData(angle: 3.14 / 4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
