import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

String? getStringImage(File? file){
  if(file==null) return null;
  return base64Encode(file.readAsBytesSync());
}

Future<File> getImage() async{
  final _picker = ImagePicker();
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  if(pickedFile != null){
    return File(pickedFile.path);
  }
  else{
    return File('');
  }
}