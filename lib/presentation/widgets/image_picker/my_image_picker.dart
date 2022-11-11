import 'dart:io';
import 'package:galery_app/core/resources/consts/colors.dart';
import 'package:galery_app/core/resources/consts/sizes.dart';
import 'package:galery_app/core/resources/helper/file_compressor.dart';
import 'package:galery_app/core/resources/media_query/media_query_helpers.dart';
import 'package:galery_app/presentation/widgets/container/rounded_container.dart';
import 'package:galery_app/presentation/widgets/my_confirm_dialog/my_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'widget_cubit/ImagePickerCubit.dart';

class MyImagePickerWidget extends StatefulWidget {
  const MyImagePickerWidget({
    Key? key,
    this.functionCallbackSetImageFilePath,
    this.isEnabled = true,
    this.imageURL,
    this.title,
    this.localImageURL,
    this.defaultImagePlaceholder,
  }) : super(key: key);

  final Function(int, File?)? functionCallbackSetImageFilePath;
  final bool isEnabled;
  final String? imageURL;
  final String? localImageURL;
  final String? title;
  final Widget? defaultImagePlaceholder;

  @override
  _MyImagePickerWidgetState createState() => _MyImagePickerWidgetState();
}

class _MyImagePickerWidgetState extends State<MyImagePickerWidget> {
  Future _showDialogPickImageFromGalleryOrCamera(
      BuildContext context, ImagePickerCubitState state) async {
    myConfirmDialog(context,
        basicContentString: "Choose Report Image",
        positiveButton: () async {
          await _showDialogChooseImageQuality(context, (imageQuality) async {
            print("GALLERY");

            var cubit = context.read<ImagePickerCubit>();
            cubit.updateState(isLoading: true);
            ImagePicker imagePicker = ImagePicker();

            XFile? pickedFile = await imagePicker
                .pickImage(source: ImageSource.gallery)
                .whenComplete(() {
              Navigator.of(context).pop();
            });
            try{
              cubit.updateState(
                  storedImage: await fileCompressor(
                      File(pickedFile?.path ?? ""), imageQuality),
                  isLoading: false);
            } on FileSystemException {
              cubit.updateState(isLoading: false);
            }
          });
        },
        positiveButtonText: "From Gallery",
        negativeButton: () async {
          _showDialogChooseImageQuality(context, (imageQuality) async {
            var cubit = context.read<ImagePickerCubit>();
            cubit.updateState(isLoading: true);
            ImagePicker imagePicker = ImagePicker();

            XFile? pickedFile = await imagePicker
                .pickImage(source: ImageSource.camera)
                .whenComplete(() {
              Navigator.of(context).pop();
            });
            try{
              cubit.updateState(
                  storedImage: await fileCompressor(
                      File(pickedFile?.path ?? ""), imageQuality),
                  isLoading: false);
            } on FileSystemException {
              cubit.updateState(isLoading: false);
            }
          });
        },
        negativeButtonText: "Pick From Camera");
  }

  Future<void> _showDialogChooseImageQuality(
      BuildContext context, Function(ImageQuality) action) async {
    myConfirmDialog(context,
        basicContentString: "Choose File Quality",
        customActions: [
          Flexible(
            child: Container(
              height: 45,
              width: widthScreen(context),
              child: ElevatedButton(
                onPressed: () async {
                  action(ImageQuality.high);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(sizeNormal)),
                  backgroundColor: primaryGreen,
                  side: const BorderSide(color: primaryGreen),
                ),
                child: const FittedBox(child: Text("High")),
              ),
            ),
          ),
          const SizedBox(width: sizeMedium),
          Flexible(
            child: Container(
              height: 45,
              width: widthScreen(context),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(sizeNormal)),
                  backgroundColor: primaryGreen,
                  side: const BorderSide(color: primaryGreen),
                ),
                onPressed: () async {
                  action(ImageQuality.medium);
                  Navigator.of(context).pop();
                },
                child: const FittedBox(child: Text("Medium")),
              ),
            ),
          ),
          const SizedBox(width: sizeMedium),
          Flexible(
            child: Container(
              height: 45,
              width: widthScreen(context),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(sizeNormal)),
                  backgroundColor: primaryGreen,
                  side: const BorderSide(color: primaryGreen),
                ),
                onPressed: () async {
                  action(ImageQuality.low);
                  Navigator.of(context).pop();
                },
                child: const FittedBox(child: Text("Low")),
              ),
            ),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return ImagePickerCubit();
      },
      child: Builder(builder: (builderContext) {
        var cubitInst = builderContext.read<ImagePickerCubit>();

        var cubitState = builderContext.watch<ImagePickerCubit>().state;

        if (!cubitState.isInitialized) {
          cubitInst.initLocalImagePickerState(
            // storedImage: storedImage,
            isEnabled: widget.isEnabled,
            imageURL: widget.imageURL,
            title: widget.title,
            localImageURL: widget.localImageURL,
          );
        }
        // FIXME INI MUNGKIN ERROR
        return BlocListener<ImagePickerCubit, ImagePickerCubitState>(
          listener: (context, state) {
            widget.functionCallbackSetImageFilePath
                ?.call(69, state.storedImage);

            FocusScope.of(context).unfocus();
          },
          listenWhen: (previous, current) {
            return (current.storedImage != null) &&
                (previous.storedImage?.path != current.storedImage?.path);
          },
          child: InkWell(
            onTap: cubitState.isEnabled
                ? () {
                    _showDialogPickImageFromGalleryOrCamera(
                        builderContext, cubitState);
                  }
                : null,
            child: IntrinsicHeight(
              child: Column(
                children: [
                  SizedBox(
                    height: widthScreen(context) * 0.8,
                    width: widthScreen(context) * 0.8,
                    child: RoundedContainer(sizeNormal,
                        // height: sizeHuge * 4,
                        // width:
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: widthScreen(context) * 0.4,
                                width: widthScreen(context) * 0.4,
                                child: Padding(
                                  padding: const EdgeInsets.all(sizeSmall),
                                  child: RoundedContainer(
                                    sizeNormal,
                                    // height: widthScreen(context) * 0.4,
                                    // width: widthScreen(context) * 0.4,
                                    boxDecoration:
                                        const BoxDecoration(color: primaryGreen),
                                    child: IntrinsicHeight(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.camera_alt, color: Colors.white,size: sizeHuge,),
                                          FittedBox(child: Text("Choose Image",style: TextStyle(color: Colors.white),)),
                                        ],
                                      ),
                                    ),
                                    // SvgPicture.asset(
                                    //   "assets/images/bi_camera.svg",
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: (cubitState.imageURL == null)
                                  ? cubitState.storedImage == null
                                      ? widget.defaultImagePlaceholder ??
                                          const _DefaultIconPlaceholder()
                                      : Image.file(cubitState.storedImage!,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                          // setState(() {
                                          cubitState.imageURL = null;
                                          // });
                                          return widget
                                                  .defaultImagePlaceholder ??
                                              const _DefaultIconPlaceholder();
                                        })
                                  : (cubitState.localImageURL !=
                                              cubitState.imageURL &&
                                          cubitState.localImageURL != null &&
                                          cubitState.storedImage != null)
                                      ? Image.file(cubitState.storedImage!,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                          // setState(() {
                                          cubitState.imageURL = null;
                                          // });
                                          return widget
                                                  .defaultImagePlaceholder ??
                                              const _DefaultIconPlaceholder();
                                        })
                                      : Image.network(
                                          cubitState.imageURL!,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            // setState(() {
                                            cubitState.imageURL = null;
                                            // });
                                            return widget
                                                    .defaultImagePlaceholder ??
                                                const _DefaultIconPlaceholder();
                                          },
                                        ),
                            )
                          ],
                        )),
                  ),
                  Visibility(
                      visible: cubitState.title != null,
                      child: Container(
                          padding: const EdgeInsets.all(sizeNormal),
                          child: Text("${cubitState.title ?? ""}")))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _DefaultIconPlaceholder extends StatelessWidget {
  const _DefaultIconPlaceholder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerCubit, ImagePickerCubitState>(
      builder: (context, state) {
        return state.isLoading
            ? const SizedBox(
                height: sizeBig,
                width: sizeBig,
                child: FittedBox(child: CircularProgressIndicator(color: primaryGreen,)))
            : FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(sizeNormal),
            child: RoundedContainer(
              sizeNormal,
              height: widthScreen(context) * 0.4,
              width: widthScreen(context) * 0.4,
              boxDecoration: const BoxDecoration(color: Colors.grey),
              child: const Center(
                child:  FittedBox(
                  child: Text(
                    "No Picture Selected",
                    style: TextStyle(color: Colors.white,
                    fontSize: sizeBig,),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}