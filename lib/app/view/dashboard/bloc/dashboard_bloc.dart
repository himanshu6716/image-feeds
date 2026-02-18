import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ImagePicker picker;
  final GetStorage box;

  DashboardBloc(this.picker, this.box) : super(DashboardInitial()) {
    on<LoadImagesEvent>(_loadImages);
    on<PickImagesEvent>(_pickImages);
    on<DeleteImageEvent>(_deleteImage);
  }

  List<Map<String, String>> imagesData = [];

  void _loadImages(
      LoadImagesEvent event, Emitter<DashboardState> emit) {

    final storedImages = box.read("images");

    if (storedImages == null) {
      imagesData = [];
    } else if (storedImages is List) {
      if (storedImages.isNotEmpty && storedImages.first is String) {
        imagesData = storedImages.map<Map<String, String>>((img) {
          return {
            "image": img.toString(),
            "time": DateTime.now().toString()
          };
        }).toList();
        box.write("images", imagesData);
      } else {
        imagesData = storedImages.map<Map<String, String>>((e) {
          return {
            "image": e["image"].toString(),
            "time": e["time"].toString()
          };
        }).toList();
      }
    }

    emit(DashboardLoaded(imagesData));
  }

  Future<void> _pickImages(
      PickImagesEvent event, Emitter<DashboardState> emit) async {

    final images = await picker.pickMultiImage();
    if (images.isEmpty) return;

    emit(DashboardLoading());

    for (var image in images) {
      File file = File(image.path);
      List<int> bytes = await file.readAsBytes();
      String base64String = base64Encode(bytes);

      imagesData.add({
        "image": base64String,
        "time": DateTime.now().toString()
      });
    }

    await box.write("images", imagesData);
    emit(DashboardLoaded(imagesData));
  }

  Future<void> _deleteImage(
      DeleteImageEvent event, Emitter<DashboardState> emit) async {
    imagesData.removeAt(event.index);
    await box.write("images", imagesData);
    emit(DashboardLoaded(imagesData));
  }
}
