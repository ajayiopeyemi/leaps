import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:leaps/core/components/app_platform_alert_dialog.dart';
import 'package:leaps/core/components/leaps_dialogs.dart';
import 'package:leaps/features/notes/presentation/modals/note_adding_dialog.dart';
import 'package:leaps/features/search/data/models/resource.dart';

class PdfPreview extends StatefulWidget {
  final Resource resource;
  final bool isForLessonNote;
  PdfPreview({@required this.resource, @required this.isForLessonNote})
      : assert(resource != null);

  @override
  _PdfPreviewState createState() => _PdfPreviewState();
}

class _PdfPreviewState extends State<PdfPreview> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(widget.resource.filePath);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.resource.title),
        actions: <Widget>[
          /*IconButton(
              icon: Icon(Icons.cloud_download),
              onPressed: () {
                confirmDownload(context);
              }),*/
          Visibility(
            visible: widget.isForLessonNote == true ? false : true,
            child: Visibility(
              visible: widget.resource.isPending == true ? false : true,
              child: IconButton(
                  icon: Icon(Icons.save_alt),
                  onPressed: () {
                    Navigator.pop(context);
                    LeapsDialogs.bottomModalSheet(
                        context,
                        NoteAddingDialog(
                          resource: widget.resource,
                        ));
                  }),
            ),
          )
        ],
      ),
      body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(document: document)),
    );
  }

  Future<void> confirmDownload(BuildContext context) async {
    final bool didRequestSignOut = await PlatformAlertDialog(
      content: 'Are you sure you want to download this pdf ?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Yes',
      title: 'Download File',
    ).show(context);
    if (didRequestSignOut == true) {
      try {
        print('Downloaing file');
        /*await Provider.of<AuthService>(context).signOut();*/
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
