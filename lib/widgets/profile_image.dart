import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourismapp/utils/colors.dart';

typedef OnPicked = void Function(XFile file);
typedef OnPickedImages = void Function(List<XFile> file);

class ProfileImage extends StatefulWidget {
  final OnPicked onPicked;
  final double radius;

  const ProfileImage({Key? key, required this.onPicked, this.radius = 75.0}) : super(key: key);

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final ImagePicker _picker = ImagePicker();
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
              ? Icon(
                  Icons.image,
                  size: 32.0,
                  color: Colors.white,
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
double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () => getImage(ImageSource.gallery),
      child: Container(
        width: width,
        height: 180.0,
        decoration: BoxDecoration(color: Colors.black26),
        child: images == null || images!.isEmpty
            ? Icon(
                Icons.image,
                size: 32.0,
                color: AppColors.onBackground,
              )
            : SizedBox(),
        // : Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       Image.file(
        //         File(images![0].path),
        //         fit: BoxFit.cover,
        //       ),
        //     ],
        //   ),
      ),
    );
  }
}
