part of 'ImagePickerCubit.dart';

class ImagePickerCubitState extends Equatable {
  bool isInitialized;
  bool isLoading;
  File? storedImage;
  bool isEnabled;
  String? imageURL;
  String? title;
  String? localImageURL;

  ImagePickerCubitState( {
    this.isInitialized = true,
    this.isLoading = false,
    this.storedImage,
    this.isEnabled = true,
    this.imageURL,
    this.title,
    this.localImageURL,
  });

  ImagePickerCubitState copyWith({
    bool? isInitialized,
    bool? isLoading,
    File? storedImage,
    bool? isEnabled,
    String? imageURL,
    String? title,
    String? localImageURL,
}){
    return ImagePickerCubitState(
        isInitialized: isInitialized ?? this.isInitialized,
        isLoading: isLoading ?? this.isLoading,
        storedImage: storedImage ?? this.storedImage,
        isEnabled: isEnabled ?? this.isEnabled,
        imageURL: imageURL ?? this.imageURL,
        title: title ?? this.title,
        localImageURL: localImageURL ?? this.localImageURL,
    );
  }

  @override
  List<Object?> get props => [
    isInitialized,
    isLoading,
    storedImage,
    isEnabled,
    imageURL,
    title,
    localImageURL,
  ];
}
