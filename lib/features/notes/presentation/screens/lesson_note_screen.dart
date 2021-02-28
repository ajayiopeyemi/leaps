import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:leaps/core/components/leaps_choice_chip.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/features/notes/data/model/note.dart';
import 'package:leaps/features/notes/presentation/pages/image_page.dart';
import 'package:leaps/features/notes/presentation/pages/pdf_page.dart';
import 'package:leaps/features/notes/presentation/pages/text_page.dart';
import 'package:leaps/features/notes/presentation/pages/video_page.dart';
import 'package:leaps/features/notes/presentation/widgets/app_silver_appbar_delegate.dart';
import 'package:leaps/features/notes/presentation/widgets/note_header.dart';

class LessonNote extends StatefulWidget {
  final Note note;
  LessonNote({@required this.note}) : assert(note != null);
  @override
  _LessonNoteState createState() => _LessonNoteState();
}

class _LessonNoteState extends State<LessonNote>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    new Tab(
        child: LeapsChoiceChips(
            icon: Icons.text_format,
            text: "Text",
            iconColor: AppColors.Purple)),
    new Tab(
        child: LeapsChoiceChips(
            icon: Icons.picture_as_pdf,
            text: "PDF",
            iconColor: AppColors.Purple)),
    new Tab(
        child: LeapsChoiceChips(
            icon: Icons.image, text: "Images", iconColor: AppColors.Purple)),
    new Tab(
        child: LeapsChoiceChips(
            icon: Icons.video_library,
            text: "Videos",
            iconColor: AppColors.Purple)),
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
    var docId = widget.note.docId;

    final List<Tab> notePageType = <Tab>[
      //For Text / searched topic description
      Tab(
          child: TextPage(
        docId: docId,
      )),

      //For PDF
      Tab(
          child: PdfPage(
        docId: docId,
      )),

      //For Images
      Tab(
          child: ImagesPage(
        docId: docId,
      )),

      //For videos
      Tab(
          child: VideoPage(
        docId: docId,
      )),
    ];

    return Scaffold(
      body: DefaultTabController(
        length: tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(32.0))
                  ),
                  elevation: 0.0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: AppColors.White),
                  ),
                  expandedHeight: AppDimensions.screenHeight(context) * 0.35,
                  floating: false,
                  pinned: true,
                  flexibleSpace: LayoutBuilder(builder: (context, constraint) {
                    var top = constraint.biggest.height;
                    AppBar appBar = AppBar();
                    double height = appBar.preferredSize.height;
                    return FlexibleSpaceBar(
                        centerTitle: false,
                        title: AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: top <= 88.0 ? 1.0 : 0.0,
                          child: Text(
                            widget.note.topic,
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        background: NoteHeader(note: widget.note));
                  })
              ),
              SliverPersistentHeader(
                delegate: SilverAppBarDelegate(
                  TabBar(
                    isScrollable: true,
                    unselectedLabelColor: AppColors.Black,
                    labelColor: AppColors.White,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: new BubbleTabIndicator(
                      indicatorHeight: 40.0,
                      indicatorColor: AppColors.Purple.withOpacity(0.3),
                      tabBarIndicatorSize: TabBarIndicatorSize.tab,
                    ),
                    tabs: tabs,
                    controller: _tabController,
                  ),
                ),
                pinned: false,
              )
            ];
          },
          body: TabBarView(
              controller: _tabController,
              children: notePageType
                  .map((Tab tab) => Container(
                child: tab.child,
              )).toList()),
        ),
      ),
    );
  }
}
