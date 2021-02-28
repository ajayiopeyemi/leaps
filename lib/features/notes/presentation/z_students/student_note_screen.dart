import 'package:flutter/material.dart';
import 'package:leaps/core/components/leaps_asset_with_text.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/core/utils/leaps_user_details_util.dart';

class StudentNoteScreen extends StatefulWidget {
  @override
  _StudentNoteScreenState createState() => _StudentNoteScreenState();
}

class _StudentNoteScreenState extends State<StudentNoteScreen>
    with SingleTickerProviderStateMixin {

  static tabChild(icon, text){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LeapsAssetWithText(
        isIcon: false,
        needsDecoration: true,
        svg: icon, text: text,
        iconSize: 15,
        iconColor: AppColors.Purple,
        decorationColor: AppColors.Purple,
        isHorizontal: true,
        customSpacer: 4.0,
        hPadding: 4.0,
      ),
    );
  }

  final List<Tab> tabs = <Tab>[
    Tab(child: Text('All')),
    Tab(child: tabChild(AppSVGs.subjectsIcons[0], '${subjects[0]}')),
    Tab(child: tabChild(AppSVGs.subjectsIcons[1], '${subjects[1]}')),
    Tab(child: tabChild(AppSVGs.subjectsIcons[2], '${subjects[2]}')),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
//    var preferredSize = new Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));
    final List<Tab> tabsPages = <Tab>[
      new Tab(child: Center(child: Text('All'))),
      new Tab(child: Center(child: Text('${subjects[0]}'))),
      new Tab(child: Center(child: Text('${subjects[1]}'))),
      new Tab(child: Center(child: Text('${subjects[2]}'))),
    ];
    return SafeArea(
        child: Container(
          color: AppColors.White,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppDimensions.verticalSpacer(spaceSize: 24.0),
              Center(
                child: Text(
                  'Hi, ${AppState.userDetails.firstName}',
                  style: headerStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              AppDimensions.verticalSpacer(spaceSize: 18.0),
              Center(
                child: Text(
                  "What would you like to learn\ntoday? See what\nwe've got for you",
                  textAlign: TextAlign.center,
                  style: bodyStyle(
                    fontColor: AppColors.Black
                  ),
                ),
              ),
              AppDimensions.verticalSpacer(spaceSize: 18.0),
              TabBar(
                isScrollable: true,
                unselectedLabelColor: AppColors.PrimaryColor,
                labelColor: AppColors.Purple,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColors.Purple,
                tabs: tabs,
                controller: _tabController,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: new TabBarView(
                      controller: _tabController,
                      children: tabsPages.map((Tab tab) {
                        return new Container(
                          child: tab.child,
                        );
                      }).toList()),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
