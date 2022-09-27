import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/getx/music_controller.dart';
import '../../model/musicdb.dart';
import '../splashscreen/splashscreen.dart';
import 'favouritescreen.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({
    super.key,
    required this.songId,
  });
  final String songId;

  @override
  Widget build(BuildContext context) {
    final List<Songs> favouritesSong = box.get('favourites')! as List<Songs>;
    final Songs fav = databaseSongs(dbSongs, songId);

    return GetBuilder<MusicController>(
      init: MusicController(),
      builder: (MusicController favIconController) {
        return favouritesSong
                .where((Songs element) =>
                    element.id.toString() == fav.id.toString())
                .isEmpty
            ? IconButton(
                onPressed: () {
                  favIconController.onFavIconclicktoAdd(
                    favouritesSong,
                    fav,
                  );
                },
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30.sp,
                ),
              )
            : IconButton(
                onPressed: () {
                  favIconController.onFavIconclicktoRemove(
                    favouritesSong,
                    fav,
                  );
                },
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 30.sp,
                ),
              );
      },
    );
  }
}
