import 'dart:io';

import 'package:galery_app/core/resources/helper/file_size_check.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';


// FIXME choose between High, Medium, or Low (100%, 90%, 80%)
// TODO make enum



enum ImageQuality { high, medium, low }


Future<File> fileCompressor(File file, ImageQuality imageQuality) async {

  if(imageQuality == ImageQuality.high) return file;

  var fileSize = fileSizeCheckInMB(file.readAsBytesSync().lengthInBytes);
  print("image size in widget before: $fileSize MB");
  // var compressedResult;
  var filePath = file.path;
  final lastIndex = filePath.lastIndexOf(RegExp(r'.jp|.pn'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  print("outPath: $outPath");
    var compressedResult = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: imageQuality == ImageQuality.medium? 90 :80,
    );
  var compressedFileSize = fileSizeCheckInMB((compressedResult ?? file).readAsBytesSync().lengthInBytes);

  print("image size in widget after: $compressedFileSize MB");

  return compressedResult ?? file;
}
