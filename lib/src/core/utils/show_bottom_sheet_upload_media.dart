import 'package:flutter/material.dart';
import 'package:safety_zone/src/presentation/widgets/upload_media_widget.dart';

Future showBottomSheetUploadMedia({
  required BuildContext context,
  required Function() onTapCamera,
  required Function() onTapGallery,
}) async {
  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: UploadMediaWidget(
        onTapCamera: onTapCamera,
        onTapGallery: onTapGallery,
      ),
    ),
  );
}
