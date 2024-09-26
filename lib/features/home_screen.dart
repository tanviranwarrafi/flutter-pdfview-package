import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tutorial/components/buttons/elevate_button.dart';
import 'package:tutorial/features/pdf_screen.dart';
import 'package:tutorial/themes/colors.dart';

const URL_1 =
    'https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf';
const URL_2 = 'https://pdfkit.org/docs/guide.pdf';
const URL_3 = 'http://www.pdf995.com/samples/pdf.pdf';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _assetPdf = '';
  var _remotePdf = '';
  var _corruptedPdf = '';

  @override
  void initState() {
    super.initState();
    _setPdfPaths();
  }

  Future<void> _setPdfPaths() async {
    var corruptedPdf = await _pdfFromAsset('assets/corrupted.pdf', 'corrupted.pdf');
    if (corruptedPdf != null) setState(() => _corruptedPdf = corruptedPdf.path);
    var assetPdf = await _pdfFromAsset('assets/demo-link.pdf', 'demo.pdf');
    if (assetPdf != null) setState(() => _assetPdf = assetPdf.path);
    var networkPdf = await _pdfFromNetworkUrl();
    if (networkPdf != null) setState(() => _remotePdf = networkPdf.path);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Home - Pdf Viewer')),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Icon(Icons.file_present, color: primary, size: 64),
            const SizedBox(height: 40),
            ElevateButton(
              label: 'Remote PDF',
              onTap: () {
                if (_assetPdf.isEmpty) return;
                Navigator.push(context, MaterialPageRoute(builder: (context) => PdfScreen(path: _assetPdf)));
              },
            ),
            const SizedBox(height: 20),
            ElevateButton(
              label: 'Open PDF',
              onTap: () {
                if (_remotePdf.isEmpty) return;
                Navigator.push(context, MaterialPageRoute(builder: (context) => PdfScreen(path: _remotePdf)));
              },
            ),
            const SizedBox(height: 20),
            ElevateButton(
              label: 'Corrupted PDF',
              onTap: () {
                if (_corruptedPdf.isEmpty) return;
                Navigator.push(context, MaterialPageRoute(builder: (context) => PdfScreen(path: _corruptedPdf)));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> _pdfFromAsset(String asset, String filename) async {
    Completer<File> completer = Completer();
    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/$filename');
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      return completer.future;
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
  }

  Future<File?> _pdfFromNetworkUrl() async {
    Completer<File> completer = Completer();
    try {
      var filename = URL_3.substring(URL_3.lastIndexOf('/') + 1);
      var request = await HttpClient().getUrl(Uri.parse(URL_3));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      if (kDebugMode) print('${dir.path}/$filename');
      File file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      return completer.future;
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
  }
}
