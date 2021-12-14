import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:image/image.dart';

enum IZIFileType {
  IMAGE,
  FILE,
  AVATAR,
}

class IZIFile extends StatefulWidget {
  IZIFile({
    this.height,
    this.width,
    this.imageSource = ImageSource.gallery,
    this.onPikerFile,
    this.margin,
    Key? key,
  })  : type = IZIFileType.IMAGE,
        super(key: key);

  IZIFile.avatar({
    this.height,
    this.width,
    this.imageSource = ImageSource.gallery,
    this.onPikerFile,
    this.margin,
    Key? key,
  })  : type = IZIFileType.AVATAR,
        super(key: key);

  IZIFile.file({
    this.height,
    this.width,
    this.onPikerFile,
    this.margin,
    Key? key,
  })  : type = IZIFileType.FILE,
        super(key: key);

  final double? height, width;
  // TODO: return file
  final String? Function(String? val)? onPikerFile;
  final EdgeInsets? margin;

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

  static Future<File> _resizeImage(String filePath, {int? height = 1024, int? width = 1024, int? quality = 100}) async {
    final file = File(filePath);

    final bytes = await file.readAsBytes();
    print("Picture original size: ${bytes.length}");

    final image = decodeImage(bytes);
    final resized = copyResize(image!, width: width, height: height);
    final resizedBytes = encodeJpg(resized, quality: quality!);
    print("Picture resized size: ${resizedBytes.length}");

    return file.writeAsBytes(resizedBytes);
  }

  ///
  /// Pick images
  ///
  Future pickImages() async {
    try {
      final result = await ImagePicker().pickImage(
        source: widget.imageSource!,
      );
      if (result == null) return;
      if (await File(result.path).length() > 2 * 1024 * 1024) {
        await _resizeImage(result.path, height: 512, width: 512).then((value) {
          setState(() {
            file = value;
          });
        });
      } else {
        setState(() {
          file = File(result.path);
        });
      }
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  void onPicker(IZIFileType type) async {
    if (type == IZIFileType.FILE) {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        pickFiles();
      }
    } else {
      PermissionStatus? status;
      if (widget.imageSource == ImageSource.gallery) {
        status = await Permission.photos.request();
      } else {
        status = await Permission.camera.request();
      }
      if (status.isGranted) {
        pickImages();
      }
    }
    if (!IZIValidate.nullOrEmpty(widget.onPikerFile) && !IZIValidate.nullOrEmpty(file)) {
      // TODO: Upload file and return url image
      widget.onPikerFile!(file!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.type == IZIFileType.FILE
          ? fileWidget()
          : widget.type == IZIFileType.AVATAR
              ? avatar()
              : imageWidget(),
    );
  }

  Widget fileWidget() {
    return GestureDetector(
      onTap: () {
        onPicker(widget.type);
      },
      child: Container(
        margin: widget.margin ??
            EdgeInsets.symmetric(
              vertical: IZIDimensions.BLUR_RADIUS_2X,
            ),
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_2X,
        ),
        height: IZIValidate.nullOrEmpty(widget.height) ? IZIDimensions.ONE_UNIT_SIZE * 70 : widget.height!,
        width: IZIValidate.nullOrEmpty(widget.width) ? double.infinity : widget.width!,
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
                    Icon(Icons.folder, color: ColorResources.CIRCLE_COLOR_BG3),
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
                  const Icon(Icons.folder, color: ColorResources.CIRCLE_COLOR_BG3)
                ],
              ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      margin: widget.margin ??
          EdgeInsets.symmetric(
            vertical: IZIDimensions.BLUR_RADIUS_2X,
          ),
      height: IZIValidate.nullOrEmpty(widget.height) ? IZIDimensions.ONE_UNIT_SIZE * 250 : widget.height!,
      width: IZIValidate.nullOrEmpty(widget.width) ? IZIDimensions.ONE_UNIT_SIZE * 250 : widget.width!,
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
            height: IZIValidate.nullOrEmpty(widget.height) ? IZIDimensions.ONE_UNIT_SIZE * 250 : widget.height!,
            width: IZIValidate.nullOrEmpty(widget.width) ? IZIDimensions.ONE_UNIT_SIZE * 250 : widget.width!,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                IZIDimensions.BLUR_RADIUS_3X,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                IZIDimensions.BLUR_RADIUS_3X,
              ),
              child: IZIImage.file(
                file,
              ),
            ),
          ),
          Container(
            height: IZIValidate.nullOrEmpty(widget.height) ? IZIDimensions.ONE_UNIT_SIZE * 50 : widget.height! / 5,
            width: IZIValidate.nullOrEmpty(widget.width) ? IZIDimensions.ONE_UNIT_SIZE * 50 : widget.height! / 5,
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

  Widget avatar() {
    return GestureDetector(
      onTap: () {
        onPicker(widget.type);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: ColorResources.WHITE,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(
          IZIDimensions.ONE_UNIT_SIZE * 5,
        ),
        child: const Icon(
          Icons.camera_alt,
        ),
      ),
    );
  }
}
