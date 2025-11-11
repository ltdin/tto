import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news/blocs/user_bloc.dart';
import 'package:news/base/app_helpers.dart';

class TTOSettingsPhotoContainerWidget extends StatefulWidget {
  const TTOSettingsPhotoContainerWidget(
      {Key key, this.currentAvatarAbsoluteURL})
      : super(key: key);

  final String currentAvatarAbsoluteURL;

  @override
  _TTOSettingsPhotoContainerWidgetState createState() =>
      _TTOSettingsPhotoContainerWidgetState();
}

class _TTOSettingsPhotoContainerWidgetState
    extends State<TTOSettingsPhotoContainerWidget> {
  @override
  Widget build(BuildContext context) {
    ImageProvider image = AssetImage("assets/icons/ic_avatar.png");

    if (userBloc.photoBytes != null) {
      image = MemoryImage(userBloc.photoBytes);
    } else if (AppHelpers.safeString(widget.currentAvatarAbsoluteURL).length !=
        0) {
      image = NetworkImage(
        AppHelpers.safeString(widget.currentAvatarAbsoluteURL),
      );
    }

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Avata
          Container(
            padding: const EdgeInsets.all(0),
            child: CircleAvatar(
              backgroundImage: image,
              radius: Size.square(68.0).width / 2,
            ),
          ),
          SizedBox(width: 10.0),

          // Icon add avata
          CircleAvatar(
            child: IconButton(
                icon: Icon(Icons.add),
                color: Colors.black,
                onPressed: () => _getGalleryImage()),
            backgroundColor: Color(0xFFC4C4C4).withOpacity(0.5),
            radius: Size.square(68.0).width / 2,
          ),
        ],
      ),
    );
  }

  FutureOr<void> _getGalleryImage() async {
    File fileImage = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 256,
      maxHeight: 256,
    );

    if (fileImage == null) {
      if (Platform.isAndroid) {
        LostDataResponse lostDataResponse =
            await ImagePicker.retrieveLostData();
        fileImage = lostDataResponse.file;
      }
    }

    final result = await userBloc.savePhoto(fileImage);

    // Update avata
    if (result) setState(() {});
  }
}
