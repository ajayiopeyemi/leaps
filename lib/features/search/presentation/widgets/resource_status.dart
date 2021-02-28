import 'package:flutter/material.dart';
import 'package:leaps/core/components/leaps_dialogs.dart';
import 'package:leaps/core/components/leaps_fb.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/notes/presentation/modals/note_adding_dialog.dart';
import 'package:leaps/features/search/data/models/resource.dart';

class ResourceStatusWidget extends StatelessWidget {
  final Resource resource;
  ResourceStatusWidget({this.resource});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              padding:
              const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: Text(
                resource.subject.toUpperCase(),
                style: bodyStyle(fontColor: AppColors.Black, fontSize: 12.0),
              ),
            ),
          ),
        ),
        Spacer(),
        LeapsFloatingActionButton(
          iconData: Icons.save_alt,
          onPressed: (){
            Navigator.pop(context);
            LeapsDialogs.bottomModalSheet(
                context,
                NoteAddingDialog(
                  resource: resource,
                )
            );
          },
        )
      ],
    );
  }
}
