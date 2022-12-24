import 'package:bot_toast/bot_toast.dart';
import 'package:clickablesvg/screens/data_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ItemTile extends ConsumerStatefulWidget {
  final String title;
  var icon;

  ItemTile({super.key, required this.title, required this.icon});

  @override
  ConsumerState<ItemTile> createState() => ItemTileState();
}

class ItemTileState extends ConsumerState<ItemTile> {
  Future<void> simulateTap() async {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (() {
            FocusScopeNode currentfocus = FocusScope.of(context);
            if (!currentfocus.hasPrimaryFocus) {
              //prevent Flutter from throwing an exception
              currentfocus.unfocus();
            }
            ref
                .read(colorMap.notifier)
                .update((state) => imagesLabel[widget.title.split('-').first]!);
            ref.read(isSearch.notifier).update((state) => false);
            ref.read(textControlller).clear();
            ref
                .read(currentImage.notifier)
                .update((state) => widget.title.split('-').first);
            ref.read(imageProvider.notifier).update(
                (state) => "assets/${widget.title.split('-').first}.png");

            var image = ref.read(currentImage);

            

            Future.delayed(Duration(seconds: 1)).then((value) {
              BotToast.showAttachedWidget(
                  attachedBuilder: (_) => Card(
                        color: labels[widget.title],
                        key: UniqueKey(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              imagesLabel[image]![labels[widget.title]] ?? ""),
                        ),
                      ),
                  duration: Duration(seconds: 10),
                  target: desktopOffset[widget.title]);
            });

            // Future.delayed(Duration(seconds: 1)).then((value) {

            //    Fluttertoast.showToast(
            //       timeInSecForIosWeb: 4,
            //        webBgColor: '#'+labels[widget.title].toString().split('(').last.split(')').first.split('0xff').last,
            //        backgroundColor: labels[widget.title],
            //        msg: widget.title.split('-').last,

            //       webPosition: "center");
            // });
          }),
          splashColor: Colors.black45,
          child: Container(
            width: MediaQuery.of(context).size.width * .15,
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * .10
                : MediaQuery.of(context).size.width < 600
                    ? MediaQuery.of(context).size.height * .20
                    : MediaQuery.of(context).size.height * .15,
            child: ListTile(
              tileColor:
                  ref.watch(currentImage) == widget.title.split('-').first
                      ? Color.fromARGB(255, 232, 232, 232)
                      : Colors.transparent,
              leading: widget.icon,
              title: Text(widget.title.split('-').last),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
