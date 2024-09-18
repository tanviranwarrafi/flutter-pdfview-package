# Pdf Viewer
This project is for learning how to use pdfviewe widget in Flutter App.

### Load PDF
```dart
// Load from assets
PDFDocument doc = await PDFDocument.fromAsset('assets/test.pdf');
// Load from URL
PDFDocument doc = await PDFDocument.fromURL('http://www.africau.edu/images/default/sample.pdf');
// Load from file
File file  = File('...');
PDFDocument doc = await PDFDocument.fromFile(file);
```

### Load Pages
```dart
PDFPage pageOne = await doc.get(page: _number);
```
### Screenshots
<img src="screenshots/one.jpg" width="250"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img 
src="screenshots/two.jpg" width="250">
