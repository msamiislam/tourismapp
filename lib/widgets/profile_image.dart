import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/login_controller.dart';
import '../utils/colors.dart';
import '../widgets/image_place_holder.dart';
import '../widgets/simple_txt.dart';

typedef OnPicked = void Function(XFile file);
typedef OnPickedImages = void Function(List<XFile> file);

class ProfileImage extends StatefulWidget {
  final String? imageUrl;
  final OnPicked onPicked;
  final double radius;

  const ProfileImage({Key? key, required this.onPicked, this.radius = 75.0, this.imageUrl}) : super(key: key);

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final ImagePicker _picker = ImagePicker();
  final LoginController _login = Get.find();
  XFile? image;

  Future<void> getImage(ImageSource source) async {
    image = (await _picker.pickImage(source: source));
    setState(() {
      if (image != null) widget.onPicked.call(image!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ImageSource>(
      onSelected: (source) {
        getImage(source);
      },
      offset: Offset(0.0, 2 * widget.radius),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
              value: ImageSource.camera,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.camera),
                title: Text("Camera"),
              )),
          PopupMenuItem(
            value: ImageSource.gallery,
            child: ListTile(
              leading: Icon(FontAwesomeIcons.image),
              title: Text("Gallery"),
            ),
          ),
        ];
      },
      child: Material(
        elevation: 4.0,
        child: Container(
          decoration: BoxDecoration(color: Colors.black26),
          child: image == null || image?.path == null
              ? widget.imageUrl == null
                  ? Icon(Icons.image, size: 32.0, color: Colors.white)
                  : CachedNetworkImage(
                      imageUrl: _login.user!.imageUrl,
                      progressIndicatorBuilder: (context, url, progress) => ImagePlaceHolder(_login.user!.initials),
                      errorWidget: (context, url, error) => Icon(Icons.image, size: 32.0, color: Colors.white),
                    )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.file(
                      File(image!.path),
                      fit: BoxFit.cover,
                      width: 2 * widget.radius,
                      height: 2 * widget.radius,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class MultiImage extends StatefulWidget {
  final OnPickedImages onPickedImages;

  const MultiImage({Key? key, required this.onPickedImages}) : super(key: key);

  @override
  State<MultiImage> createState() => _MultiImageState();
}

class _MultiImageState extends State<MultiImage> {
  final ImagePicker _picker = ImagePicker();

  List<XFile>? images;

  Future<void> getImage(ImageSource source) async {
    images = (await _picker.pickMultiImage());
    setState(() {
      if (images != null) widget.onPickedImages.call(images!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => getImage(ImageSource.gallery),
        child: Container(
          width: Get.width,
          height: 180.0,
          decoration: BoxDecoration(color: Colors.black26),
          child: images == null || images!.isEmpty
              ? Icon(
                  Icons.image,
                  size: 32.0,
                  color: AppColors.onBackground,
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.file(File(images![0].path), fit: BoxFit.cover),
                    if (images!.length > 1)
                      Positioned.fill(
                        child: Container(
                            color: AppColors.black.withOpacity(0.5),
                            child: Center(
                              child: AppText(
                                " + ${images!.length - 1} More ",
                                color: AppColors.white,
                              ),
                            )),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
