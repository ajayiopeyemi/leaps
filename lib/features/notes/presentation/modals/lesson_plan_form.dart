import 'package:flutter/material.dart';
import 'package:leaps/core/base/leaps_base_change_notifier.dart';
import 'package:leaps/core/components/leaps_loading_indicators.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/enums/leaps_state_enums.dart';
import 'package:leaps/core/helpers/drop_down_helper.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/core/utils/leaps_user_details_util.dart';
import 'package:leaps/features/authentication/domain/view_models/regions_viewmodel.dart';
import 'package:leaps/features/notes/data/model/note.dart';
import 'package:leaps/features/notes/domain/view_models/notes_viewmodel.dart';
import 'package:provider/provider.dart';

class NewLessonPlanForm extends StatefulWidget {
  @override
  _NewLessonPlanFormState createState() => _NewLessonPlanFormState();
}

class _NewLessonPlanFormState extends State<NewLessonPlanForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _topic;

  var selectedSubjectIndex = 0;
  var classIndex;
  bool shouldClassShow = false;

  @override
  void initState() {
    _topic = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseChangeNotifierProvider<NotesViewModel>(
        model: NotesViewModel(noteService: Provider.of(context)),
        builder: (context, model, child) =>
            LayoutBuilder(builder: (context, constraint) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: constraint.maxWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        color: AppColors.Purple,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                        child: Text(
                          'New Lesson Plan',
                          style: headerStyle(textColor: AppColors.White),
                        ),
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 8.0, top: 4.0),
                              child: Text(
                                'Select Subject',
                                style: bodyStyle(
                                    fontColor: AppColors.Black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppDimensions.dimenFour,
                                  horizontal: AppDimensions.dimenEight),
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0)),
                                color: AppColors.White,
                                elevation: 1.0,
                                child: PopupMenuButton(
                                  onSelected: (index) {
                                    setState(() {
                                      selectedSubjectIndex = index;
                                    });
                                  },
                                  itemBuilder: (_) =>
                                      DropDownHelper.buildPopMenuItem(subjects),
                                  child: Padding(
                                    padding: AppEdgeInsets.allTen,
                                    child: Row(
                                      children: <Widget>[
                                        Text(subjects[selectedSubjectIndex]),
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
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0, top: 14.0),
                              child: Text(
                                'Select Class',
                                style: bodyStyle(
                                    fontColor: AppColors.Black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppDimensions.dimenFour,
                                  horizontal: AppDimensions.dimenEight),
                              child: Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0)),
                                  color: AppColors.White,
                                  elevation: 1.0,
                                  child:
                                  BaseChangeNotifierProvider<RegionViewModel>(
                                    model: RegionViewModel(
                                        region: Provider.of(context)),
                                    builder: (context, model, child) =>
                                        LayoutBuilder(
                                          builder: (context, constraint) {
                                            return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: FutureBuilder(
                                                  future: model.getClasses(
                                                      AppState.userDetails.country
                                                  ),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return LeapsLoadIndicator
                                                          .loadingThreeBounce(20);
                                                    }
                                                    return ChangeNotifierProvider<ValueNotifier<int>>(
                                                      builder: (_) => ValueNotifier<int>(0),
                                                      child: Consumer<ValueNotifier<int>>(
                                                        builder: (_, ValueNotifier<int>selectedClassIndex, __) => PopupMenuButton(
                                                          onSelected: (index) {
                                                            selectedClassIndex.value = index;
                                                            classIndex = selectedClassIndex.value;
                                                            setState(() {
                                                              shouldClassShow = true;
                                                            });
                                                          },
                                                          itemBuilder: (_) =>
                                                              DropDownHelper.buildPopMenuItem(classInRegion),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Visibility(
                                                                visible: shouldClassShow,
                                                                child: Text(
                                                                  classInRegion[selectedClassIndex.value],
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              Icon(
                                                                Icons
                                                                    .keyboard_arrow_down,
                                                                color: AppColors
                                                                    .PrimaryColor,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ));
                                          },
                                        ),
                                  )),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: AppDimensions.dimenTwelve,
                                    horizontal: AppDimensions.dimenEight),
                                child: TextFormField(
                                  controller: _topic,
                                  decoration: InputDecoration(
                                    labelText: 'Topic',
                                  ),
                                  validator: (value) => value.isEmpty
                                      ? "Topic can't be empty"
                                      : null,
                                ))
                          ],
                        )),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FlatButton(
                          onPressed: classIndex == null ? null :
                            () async {
                            if (_formKey.currentState.validate()) {
                              model.setCreateState(ViewStateCreate.Creating);
                              Navigator.pop(context);
                              final Note newNotePlan = new Note(
                                uId: AppState.userDetails.uId,
                                ownerImg: AppState.userDetails.avatar,
                                owner: '${AppState.userDetails.firstName} ${AppState.userDetails.surname[0]}',
                                country: AppState.userDetails.country,
                                noteClass: classInRegion[classIndex],
                                ownerSchool: AppState.userDetails.schoolName,
                                subjectIndex: selectedSubjectIndex,
                                subject: subjects[selectedSubjectIndex],
                                topic: _topic.text,
                                isApproved: true,
                              );
                              await model.createLessonPlan(
                                  context,
                                  newNotePlan.dataToMap()
                              );
                            }
                          },
                          child: Text(
                            'Create Plan',
                            style: bodyStyle(fontColor: AppColors.Purple),
                          )),
                    )
                  ],
                ),
              );
            })
    );
  }
}
