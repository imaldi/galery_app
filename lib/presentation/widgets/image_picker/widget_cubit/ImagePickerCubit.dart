import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// import 'package:meta/meta.dart';

part 'ImagePickerCubitState.dart';

class ImagePickerCubit extends Cubit<ImagePickerCubitState> {
  ImagePickerCubit() : super(ImagePickerCubitState(isInitialized: false));
  initLocalImagePickerState(
      // storedImage,
      {bool isEnabled = true,
      String? imageURL,
      String? title,
      String? localImageURL}) async {
    emit(ImagePickerCubitState(
      isEnabled: isEnabled,
      imageURL: imageURL,
      title: title,
      localImageURL: localImageURL,
    ));
  }

  void updateState({File? storedImage, bool? isEnabled, bool? isLoading, String? imageURL, String? title, String? localImageURL}) {
    print("Path of stored Image: ${storedImage?.path}");
    emit(state.copyWith(
      storedImage: storedImage,
      isLoading: isLoading,
      isEnabled: isEnabled,
      imageURL: imageURL,
      title: title,
      localImageURL: localImageURL,
    ));
  }
}
