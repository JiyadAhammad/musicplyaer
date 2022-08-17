import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music/screens/Playlist/createplaylist.dart';
import 'package:music/screens/eachplaylistscreen/eachplaylistscreen.dart';
import 'package:music/screens/homescreen/navbar/navbar.dart';
import 'package:music/screens/splashscreen/splashscreen.dart';

final GlobalKey<FormState> formKey = GlobalKey();
var palyListNameValidate = '';
final nameController = TextEditingController();

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF911BEE),
            Colors.black.withOpacity(0.94),
            Colors.black,
            Colors.black.withOpacity(0.94),
            const Color(0xFF911BEE),
          ],
          stops: const [
            0.01,
            0.3,
            0.5,
            0.7,
            1,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Playlist'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) {
                    return NavBar();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (BuildContext context, playlistnameBox, Widget? child) {
            var playlistName = box.keys.toList();
            return playlistName.length == 2
                ? Center(
                    child: Text(
                      'No Playlist',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp,
                      ),
                    ),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 3,
                    ),
                    itemCount: playlistName.length,
                    itemBuilder: (context, index) {
                      var playlistSongs = box.get(playlistName[index]);
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) => EachPlayList(
                                      playlistName: playlistName[index],
                                    )),
                              ),
                            );
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (ctx) {
                            //       return EachPlayList(
                            //         playlistName: playlistnameDb!.playlistName!,
                            //         playlistnameId: playlistnameDb.id,
                            //       );
                            //     },
                            //   ),
                            // );
                          },
                          child: playlistName[index] != "mymusic" &&
                                  playlistName[index] != "favourites"
                              ? Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15).r,
                                        border: Border.all(
                                          color: Colors.white54,
                                          style: BorderStyle.solid,
                                          width: 2.5,
                                        ),
                                        color: Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Text(
                                          playlistName[index].toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    PopupMenuButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          const Radius.circular(15.0).r,
                                        ),
                                      ),
                                      color: Colors.black,
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      ),
                                      itemBuilder: (_) =>
                                          <PopupMenuItem<String>>[
                                        PopupMenuItem<String>(
                                          onTap: () {},
                                          value: 'rename',
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                ' Edit playlist',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem<String>(
                                          onTap: () {},
                                          value: 'delete',
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                ' Delete playlist ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                      onSelected: (selected) {
                                        if (selected == 'delete') {
                                          // deletePlaylist(
                                          // context: context
                                          // );
                                        } else if (selected == 'rename') {
                                          // playlistEdit(
                                          //   context: context,
                                          //   // context: context,
                                          //   playName: playlistnameDb.playlistName,
                                          // );
                                        }
                                      },
                                    ),
                                    // popupMenuButtonSelected(
                                    //   playlistfile: playlistnameDb,
                                    //   index: index,
                                    // )
                                  ],
                                )
                              : const SizedBox(),
                        ),
                      );
                    },
                  );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: const RadialGradient(
              colors: [
                Color(0xFF911BEE),
                Color(0xFF4D0089),
              ],
            ),
          ),
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CreatePlaylist();
                  });
              // popupshowDialogbox(context: context);
            },
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
