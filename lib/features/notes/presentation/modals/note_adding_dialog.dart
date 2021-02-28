import 'package:flutter/material.dart';
import 'package:leaps/core/base/leaps_base_change_notifier.dart';
import 'package:leaps/core/components/leaps_dialogs.dart';
import 'package:leaps/core/components/leaps_loading_indicators.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/helpers/drop_down_helper.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/notes/data/model/note.dart';
import 'package:leaps/features/notes/domain/view_models/notes_viewmodel.dart';
import 'package:leaps/features/search/data/models/resource.dart';
import 'package:provider/provider.dart';

import 'lesson_plan_form.dart';

String lessonPlanDocId;
String selectedTopic;
bool _isSelected;

class NoteAddingDialog extends StatefulWidget {
  final Resource resource;
  NoteAddingDialog({this.resource});
  @override
  _NoteAddingDialogState createState() => _NoteAddingDialogState();
}

class _NoteAddingDialogState extends State<NoteAddingDialog> {
  TextEditingController searchField;
  String resource;

  @override
  void initState() {
    searchField = TextEditingController(text: "");
    /*resource = 'Incoming resource'.substring(0, 10);*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var splitPath = widget.resource.path.toString().split("/");
    var type = splitPath[0];

    print('Topic is: $selectedTopic');

    return BaseChangeNotifierProvider<NotesViewModel>(
      model: NotesViewModel(noteService: Provider.of(context)),
      builder: (context, model, child) {
        return LayoutBuilder(
          builder: (context, constraint) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: TextField(
                            onChanged: (text) {},
                            /*style: dropDownMenuItemStyle,*/
                            cursorColor: AppColors.PrimaryColor,
                            controller: searchField,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.PrimaryColor,
                              ),
                              hintText: 'Quick Access',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 14.0),
                              fillColor:
                              AppColors.PrimaryColor.withOpacity(0.03),
                              filled: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: FlatButton(
                          onPressed: () {
                            LeapsDialogs.simpleDialog(
                                context, NewLessonPlanForm());
                          },
                          child: Text(
                            'New Plan',
                            style: bodyStyle(fontSize: 12),
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: StreamProvider<List<Note>>.value(
                            value: model.getNotePlans(),
                            child: BuildNoteSearchResult(),
                          ))),
                  Divider(),
                  ChangeNotifierProvider<ValueNotifier<int>>(
                    builder: (_) => ValueNotifier<int>(0),
                    child: Consumer<ValueNotifier<int>>(
                        builder: (_, ValueNotifier<int> selectedWeekIndex, __) => Column(
                          children: <Widget>[
                            Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                              color: AppColors.White,
                              elevation: 1.0,
                              child: PopupMenuButton(
                                onSelected: (index) {
                                  selectedWeekIndex.value = index;
                                },
                                itemBuilder: (_) =>
                                    DropDownHelper.buildPopMenuItem(week),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          week[selectedWeekIndex.value],
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: AppColors.PrimaryColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(),
                            Center(
                              child: FlatButton.icon(
                                  onPressed: selectedWeekIndex.value == 0 ?
                                  null: ()
                                  async {
                                    print('Doc Id is: $lessonPlanDocId');

                                    Map<String, dynamic> textMap = {
                                      ResourceConstants.HEADING:
                                      widget.resource.heading,
                                      ResourceConstants.DEFINITION:
                                      widget.resource.definition,
                                      ResourceConstants.PATH:
                                      widget.resource.path,
                                      ResourceConstants.WEEK: week[
                                      selectedWeekIndex.value]
                                    };

                                    Map<String, dynamic> fileMap = {
                                      ResourceConstants.TITLE:
                                      widget.resource.title,
                                      ResourceConstants.FILE_PATH:
                                      widget.resource.filePath,
                                      ResourceConstants.PATH:
                                      widget.resource.path,
                                      ResourceConstants.WEEK: week[
                                      selectedWeekIndex.value]
                                    };
                                    print('Type is: $type');
                                    await model.addResourceToLessonPlan(
                                        type,
                                        type == 'texts' ? textMap : fileMap,
                                        lessonPlanDocId
                                    );
                                    Navigator.of(context).pop();
                                    print('Added');
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: AppColors.Purple,
                                  ),
                                  label: Expanded(
                                    child: Text(
                                      selectedWeekIndex.value == 0
                                          ? "Select a week above"
                                          : 'Add resource to lesson plan',
                                      style: bodyStyle(
                                          fontColor: AppColors.Purple),
                                    ),
                                  )
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ignore: must_be_immutable
class BuildNoteSearchResult extends StatelessWidget {
  var notePlans;
  @override
  Widget build(BuildContext context) {
    notePlans = Provider.of<List<Note>>(context);
    if (notePlans == null) {
      return LeapsLoadIndicator.loadingDoubleBounce(40.0);
    }

    switch (notePlans.length) {
      case 0:
        return Container();
      default:
        return ChangeNotifierProvider<ValueNotifier<int>>(
          builder: (_) => ValueNotifier<int>(null),
          child: Consumer<ValueNotifier<int>>(
            builder: (_, ValueNotifier<int> selectedItemIndex, __) =>
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: notePlans.length,
                    itemBuilder: (context, index) {
                      _isSelected = false;
                      _isSelected = selectedItemIndex.value == index;
                      return GestureDetector(
                        onTap: () {
                          selectedItemIndex.value = index;
                          lessonPlanDocId = notePlans[index].docId;
                          selectedTopic = notePlans[index].topic.substring(0, 10);
                          print(selectedTopic);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: Container(
                            color: _isSelected
                                ? AppColors.Purple.withOpacity(0.1)
                                : null,
                            margin: const EdgeInsets.all(4.0),
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                                '${notePlans[index].topic}',
                                style: bodyStyle()
                            ),
                          ),
                        ),
                      );
                    }),
          ),
        );
    }
  }
}
