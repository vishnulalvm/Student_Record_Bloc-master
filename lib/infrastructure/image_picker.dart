import 'package:image_picker/image_picker.dart';

class ImagePickerServices {
  Future<XFile?> pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    return image;
  }
}
