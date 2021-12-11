import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'dart:io' as Io;
import 'package:image/image.dart';

enum IZIFileType {
  IMAGE,
  FILE,
}

class IZIFile extends StatefulWidget {
  IZIFile({
    this.height,
    this.width,
    this.imageSource = ImageSource.gallery,
    this.onFile,
    Key? key,
  })  : type = IZIFileType.IMAGE,
        super(key: key);
  IZIFile.file({
    this.height,
    this.width,
    this.onFile,
    Key? key,
  })  : type = IZIFileType.FILE,
        super(key: key);

  final double? height, width;
  final String? Function(String? val)? onFile;

  ImageSource? imageSource;
  IZIFileType type;

  @override
  _IZIFileState createState() => _IZIFileState();
}

class _IZIFileState extends State<IZIFile> {
  File? file;

  Future pickFiles() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;

      setState(() {
        file = File(
          result.files.single.path.toString(),
        );
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  // Future<File> resizeImage(File file, {int? height, int? width, int? compressQuality = 100}) async {
  //   File? image = await ImageCropper.cropImage(
  //     sourcePath: file.path,
  //     aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
  //     compressQuality: compressQuality ?? 100,
  //     maxWidth: width ?? 700,
  //     maxHeight: height ?? 700,
  //     compressFormat: ImageCompressFormat.png,
  //   );
  // }

  ///
  /// Pick images
  ///
  Future pickImages() async {
    try {
      final result = await ImagePicker().pickImage(source: widget.imageSource!,);
      if (result == null) return;
      if (await File(result.path).length() > 1024) {
         // Resize image
      } 
      setState(() {
          file = File(result.path);
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  void onPicker(IZIFileType type) {
    if (type == IZIFileType.FILE) {
      pickFiles();
    } else {
      pickImages();
    }
    if (!IZIValidate.nullOrEmpty(widget.onFile) && !IZIValidate.nullOrEmpty(file)) {
      // Upload file and return url image
      widget.onFile!(file!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.type == IZIFileType.FILE ? fileWidget() : imageWidget(),
    );
  }

  Widget fileWidget() {
    return GestureDetector(
      onTap: () {
        onPicker(widget.type);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_2X),
        height: IZIValidate.nullOrEmpty(widget.height) ? IZIDimensions.ONE_UNIT_SIZE * 70 : IZIDimensions.ONE_UNIT_SIZE * widget.height!,
        width: IZIValidate.nullOrEmpty(widget.width) ? double.infinity : IZIDimensions.ONE_UNIT_SIZE * widget.width!,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            IZIDimensions.BLUR_RADIUS_2X,
          ),
          color: ColorResources.WHITE,
          border: Border.all(
            color: ColorResources.GREEN,
            width: 2,
          ),
        ),
        child: IZIValidate.nullOrEmpty(file)
            ? Container(
                color: ColorResources.WHITE,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: IZIText(
                        text: "Chọn tập tin",
                      ),
                    ),
                    Icon(
                      Icons.file_download_outlined,
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: IZIText(
                      text: file!.path.split('/').last.toString(),
                      maxLine: 1,
                    ),
                  ),
                  const Icon(
                    Icons.file_download_outlined,
                  )
                ],
              ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      height: IZIValidate.nullOrEmpty(widget.height) ? IZIDimensions.ONE_UNIT_SIZE * 250 : IZIDimensions.ONE_UNIT_SIZE * widget.height!,
      width: IZIValidate.nullOrEmpty(widget.width) ? IZIDimensions.ONE_UNIT_SIZE * 250 : IZIDimensions.ONE_UNIT_SIZE * widget.width!,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BLUR_RADIUS_3X,
        ),
        color: ColorResources.GREY.withOpacity(0.7),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: IZIValidate.nullOrEmpty(widget.height) ? IZIDimensions.ONE_UNIT_SIZE * 250 : IZIDimensions.ONE_UNIT_SIZE * widget.height!,
            width: IZIValidate.nullOrEmpty(widget.width) ? IZIDimensions.ONE_UNIT_SIZE * 250 : IZIDimensions.ONE_UNIT_SIZE * widget.width!,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                IZIDimensions.BLUR_RADIUS_3X,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                IZIDimensions.BLUR_RADIUS_3X,
              ),
              child: IZIImage.file(file),
            ),
          ),
          Container(
            height: IZIValidate.nullOrEmpty(widget.height) ? IZIDimensions.ONE_UNIT_SIZE * 50 : IZIDimensions.ONE_UNIT_SIZE * (widget.height! / 5),
            width: IZIValidate.nullOrEmpty(widget.width) ? IZIDimensions.ONE_UNIT_SIZE * 50 : IZIDimensions.ONE_UNIT_SIZE * (widget.height! / 5),
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorResources.CIRCLE_COLOR_BG3,
                width: 3,
              ),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  onPicker(widget.type);
                },
                child: Icon(
                  Icons.add,
                  color: ColorResources.CIRCLE_COLOR_BG3,
                  size: IZIDimensions.ONE_UNIT_SIZE * 40,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
