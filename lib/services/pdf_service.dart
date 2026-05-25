import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

import 'package:path_provider/path_provider.dart';

class PDFService {
  static Future<File> generateInvoice() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            children: [
              pw.Text("PA Booking Invoice", style: pw.TextStyle(fontSize: 30)),

              pw.SizedBox(height: 20),

              pw.Text("Booking ID : PA12345"),

              pw.Text("Amount : ₹500"),

              pw.Text("Commission : ₹35"),

              pw.Text("Worker Earnings : ₹465"),
            ],
          );
        },
      ),
    );

    final dir = await getApplicationDocumentsDirectory();

    final file = File("${dir.path}/invoice.pdf");

    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
