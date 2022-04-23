import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Im;
import 'dart:math' as Math;

import 'package:path_provider/path_provider.dart';

/// Get image from device
Future<XFile?>  getImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  final pickedFile = await _picker.pickImage(
    source: source,

    // maxWidth: maxWidth,
    // maxHeight: maxHeight,
    // imageQuality:50,
  );

  return pickedFile;
}

Future<File> compressImage(XFile pickedFile) async {
  var imageFile = File(pickedFile.path);

  final tempDir = await getTemporaryDirectory();
  final path = tempDir.path;
  int rand = new Math.Random().nextInt(10000);

  Im.Image? image = Im.decodeImage(imageFile.readAsBytesSync());
  Im.Image smallerImage = Im.copyResize(image!, width: 500, height: 500); // choose the size here, it will maintain aspect ratio

  var compressedImage = new File('$path/img_$rand.jpg')..writeAsBytesSync(Im.encodeJpg(image, quality: 85));
  print("image ${compressedImage.path}");

  return compressedImage;
}




 String getFileSizeString({ required int bytes, int decimals = 0}) {
if (bytes <= 0) return "0 Bytes";
const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
var i = (log(bytes) / log(1024)).floor();
return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
}
