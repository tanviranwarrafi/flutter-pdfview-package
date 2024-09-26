import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfScreen extends StatefulWidget {
  final String path;
  PdfScreen({required this.path});

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> with WidgetsBindingObserver {
  var _controller = Completer<PDFViewController>();
  var _totalPage = 0;
  var _currentPage = 0;
  var _isReady = false;
  var _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(widget.path.substring(widget.path.lastIndexOf('/') + 1))),
      body: PDFView(
        filePath: widget.path,
        swipeHorizontal: true,
        autoSpacing: false,
        defaultPage: _currentPage,
        fitPolicy: FitPolicy.BOTH,
        onRender: (_pages) {
          _totalPage = _pages ?? 0;
          _isReady = true;
          setState(() {});
        },
        onError: (error) => setState(() => _errorMessage = error.toString()),
        onPageError: (page, error) => setState(() => _errorMessage = '$page: ${error.toString()}'),
        onViewCreated: (pdfViewController) => _controller.complete(pdfViewController),
        onLinkHandler: (uri) {
          if (kDebugMode) print('goto uri: $uri');
        },
        onPageChanged: (page, total) {
          if (kDebugMode) print('page change: $page/$total');
          if (page != null) setState(() => _currentPage = page);
        },
      ),
      /*floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            label: Text('Go to ${_totalPage ~/ 2}'),
            onPressed: () => snapshot.data!.setPage(_totalPage ~/ 2),
          );
        },
      ),*/
    );
  }
}
