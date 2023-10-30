import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinder_clone/config/dio.dart';
import 'package:tinder_clone/controllers/register.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:tinder_clone/pages/register/onboarding/done.dart';

class GetPhotosScreen extends StatefulWidget {
  const GetPhotosScreen({super.key});

  @override
  State<GetPhotosScreen> createState() => _GetPhotosScreenState();
}

class _GetPhotosScreenState extends State<GetPhotosScreen> {
  List<XFile?> images = List.generate(6, (index) => XFile(""));
  final registerController = Get.find<RegisterController>();
  final int _minALlowedPhotos = 3;
  bool isUploading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 20,
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      "Add Photos",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Text(
                      "Add at least 3 photos to continue.",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.5,
                      children: images
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                _picker(images.indexOf(e));
                              },
                              onDoubleTap: () {
                                setState(() {
                                  images[images.indexOf(e)] = XFile("");
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  height: 130,
                                  width: 90,
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        height: double.infinity,
                                        child: e!.path.isNotEmpty
                                            ? Image.file(
                                                File(e.path),
                                                fit: BoxFit.cover,
                                                errorBuilder: (
                                                  BuildContext context,
                                                  Object error,
                                                  StackTrace? stackTrace,
                                                ) {
                                                  return const Center();
                                                },
                                              )
                                            : const SizedBox(),
                                      ),
                                      e.path.isEmpty
                                          ? Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: CircleAvatar(
                                                radius: 12,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: images
                                    .where(
                                        (element) => element!.path.isNotEmpty)
                                    .toList()
                                    .length <
                                _minALlowedPhotos
                            ? null
                            : const LinearGradient(
                                colors: [Color(0xffef4a75), Color(0xfffd9055)],
                                stops: [0.25, 0.75],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                      ),
                      child: ElevatedButton(
                        onPressed: images
                                    .where(
                                        (element) => element!.path.isNotEmpty)
                                    .toList()
                                    .length <
                                _minALlowedPhotos
                            ? null
                            : () {
                                _uploadImages();
                                // Get.to(
                                //   () => const RegisterDoneScreen(),
                                //   transition: Transition.rightToLeft,
                                // );
                              },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        child: const Text(
                          "CONTINUE",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          isUploading
              ? SafeArea(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.6),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                          strokeWidth: 4,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  void _picker(int index) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          images[index] = pickedFile;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _uploadImages() async {
    setState(() {
      isUploading = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      dio.options.headers["Authorization"] = "Bearer $token";

      final photos = FormData.fromMap({
        'photos[]': images
            .where((element) => element!.path.isNotEmpty)
            .toList()
            .map((e) => MultipartFile.fromFileSync(e!.path))
            .toList(),
      });
      await dio.post(
        '/upload-photos',
        data: photos,
      );
      setState(() {
        isUploading = false;
      });
      Get.to(
        () => const RegisterDoneScreen(),
        transition: Transition.rightToLeft,
      );
    } on DioException catch (e) {
      debugPrint(e.response!.data.toString());
      setState(() {
        isUploading = false;
      });
    }
  }
}
