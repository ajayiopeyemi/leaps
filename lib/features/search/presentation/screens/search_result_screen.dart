import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:leaps/core/components/leaps_asset_with_text.dart';
import 'package:leaps/core/components/leaps_choice_chip.dart';
import 'package:leaps/core/components/leaps_custom_clipper.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/search/data/models/search_result.dart';

import '../pages/image_page.dart';
import '../pages/pdf_page.dart';
import '../pages/text_page.dart';
import '../pages/video_page.dart';

class InheritedSearchResult extends InheritedWidget {
  final String selectedSubject, searchText;
  InheritedSearchResult({this.selectedSubject, this.searchText, Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //This will return our inherited widget
  static InheritedSearchResult of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(InheritedSearchResult);
}

class SearchResultScreen extends StatefulWidget {
  final SearchInput searchInput;
  const SearchResultScreen({Key key, this.searchInput}) : super(key: key);

  @override
  _SearchResultScreenState createState() => new _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    new Tab(
        child: LeapsChoiceChips(
      icon: Icons.text_format,
      text: "Text",
      textColor: AppColors.White,
    )),
    new Tab(
        child: LeapsChoiceChips(
      icon: Icons.picture_as_pdf,
      text: "PDF",
      textColor: AppColors.White,
    )),
    new Tab(
        child: LeapsChoiceChips(
      icon: Icons.image,
      text: "Images",
      textColor: AppColors.White,
    )),
    new Tab(
        child: LeapsChoiceChips(
      icon: Icons.video_library,
      text: "Videos",
      textColor: AppColors.White,
    )),
  ];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> searchPageType = <Tab>[
      //For Text / searched topic description
      new Tab(
          child: TextPage(
        endpoint: ApiConstants.textRoute,
        selectedSubject:
            InheritedSearchResult.of(context).selectedSubject.toLowerCase(),
        searchQuery: InheritedSearchResult.of(context).searchText.toLowerCase(),
      )),
      /*new Tab(child: ResourceStateChangeWidget(),),*/

      //For PDF
      new Tab(
          child: PdfPage(
        endpoint: ApiConstants.pdfRoute,
        selectedSubject:
            InheritedSearchResult.of(context).selectedSubject.toLowerCase(),
        searchQuery: InheritedSearchResult.of(context).searchText.toLowerCase(),
      )),

      //For Images
      new Tab(
          child: ImagesPage(
        endpoint: ApiConstants.imagesRoute,
        selectedSubject:
            InheritedSearchResult.of(context).selectedSubject.toLowerCase(),
        searchQuery: InheritedSearchResult.of(context).searchText.toLowerCase(),
      )),

      //For videos
      new Tab(
          child: VideosPage(
        endpoint: ApiConstants.videosRoute,
        selectedSubject:
            InheritedSearchResult.of(context).selectedSubject.toLowerCase(),
        searchQuery: InheritedSearchResult.of(context).searchText.toLowerCase(),
      )),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result'),
        centerTitle: true,
        elevation: 0.0,
        bottom: TabBar(
          isScrollable: true,
          unselectedLabelColor: AppColors.PrimaryColor,
          labelColor: AppColors.White,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: new BubbleTabIndicator(
            indicatorHeight: 40.0,
            indicatorColor: AppColors.White.withOpacity(0.3),
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: tabs,
          controller: _tabController,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SearchResultAppBarComplement(),
          Expanded(
            child: Container(
              child: TabBarView(
                  controller: _tabController,
                  children: searchPageType.map((Tab tab) {
                    return new Container(
                      child: tab.child,
                    );
                  }).toList()),
            ),
          )
        ],
      ),
    );
  }
}

class SearchResultAppBarComplement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: LeapsCustomShapeClipper(),
          child: Container(
            height: 180,
            decoration: BoxDecoration(gradient: AppGradients.AppPurple),
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              elevation: 10.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LeapsAssetWithText(
                      needsDecoration: false,
                      isHorizontal: true,
                      hPadding: 0.0,
                      customSpacer: 4.0,
                      isIcon: true,
                      text: InheritedSearchResult.of(context).selectedSubject,
                      textStyle: TextStyle(fontSize: 16.0),
                      iconData: Icons.subject,
                      iconColor: AppColors.Purple,
                      iconSize: 20,
                    ),
                    Divider(color: Colors.grey, height: 20.0),
                    AppDimensions.verticalSpacer(spaceSize: 8.0),
                    Text(
                        InheritedSearchResult.of(context).searchText,
                        style: bodyStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontColor: AppColors.Black,
                        )
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
