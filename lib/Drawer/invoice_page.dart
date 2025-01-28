import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InvoiceList(),
    );
  }
}

class InvoiceList extends StatelessWidget {
  final List<Map<String, dynamic>> invoices = [
    {
      'invoiceNo': 'INV001',
      'date': '2024-12-01',
      'amount': 200,
      'status': 'Completed'
    },
    {
      'invoiceNo': 'INV002',
      'date': '2024-12-02',
      'amount': 150,
      'status': 'Pending'
    },
    {
      'invoiceNo': 'INV003',
      'date': '2024-12-03',
      'amount': 300,
      'status': 'Cancelled'
    },
    {
      'invoiceNo': 'INV004',
      'date': '2024-12-10',
      'amount': 350,
      'status': 'Completed'
    },
    {
      'invoiceNo': 'INV005',
      'date': '2024-12-08',
      'amount': 500,
      'status': 'Completed'
    },
  ];

 void _showInvoiceDetails(BuildContext context, Map<String, dynamic> invoice) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Invoice Details'),
      backgroundColor: Colors.white,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text('Invoice No: ${invoice['invoiceNo']}'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text('Date: ${invoice['date']}'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text('Amount: \$${invoice['amount']}'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text('Status: ${invoice['status']}'),
          ),
        ],
      ),
      actions: [
        // Print Button
        IconButton(
          icon: Icon(
            Icons.print,
            color: Colors.black,
          ),
          onPressed: () {
            _printInvoice(invoice); // Call print function when clicked
            Navigator.pop(context); // Close the dialog
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text(
            'Close',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    ),
  );
}


  // Print function using printing package
  void _printInvoice(Map<String, dynamic> invoice) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Invoice No: ${invoice['invoiceNo']}'),
              pw.Text('Date: ${invoice['date']}'),
              pw.Text('Amount: \$${invoice['amount']}'),
              pw.Text('Status: ${invoice['status']}'),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PersistentBottomNavBar(),
        ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Invoice List',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ), // Title of the AppBar
          centerTitle: true, // Center align the title
          backgroundColor: Color(0xFF028090), // AppBar background color
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ), // Back arrow icon
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => PersistentBottomNavBar(),
              ));
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(18.0), // Adds padding below the AppBar
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columnSpacing: 20,
                headingRowHeight: 56,
                dataRowHeight: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                columns: [
                  DataColumn(
                      label: Text(
                    'S.No',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  )),
                  DataColumn(
                      label: Text(
                    'Invoice No',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  )),
                  DataColumn(
                      label: Text(
                    'Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  )),
                  DataColumn(
                      label: Text(
                    'Amount',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  )),
                  DataColumn(
                      label: Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  )),
                  DataColumn(
                      label: Text(
                    'Action',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  )),
                ],
                rows: List.generate(
                  invoices.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(invoices[index]['invoiceNo'])),
                      DataCell(Text(invoices[index]['date'])),
                      DataCell(Text('\$${invoices[index]['amount']}')),
                      DataCell(Text(invoices[index]['status'])),
                      DataCell(IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () =>
                            _showInvoiceDetails(context, invoices[index]),
                      )),
                    ],
                  ),
                ),
                border: TableBorder.all(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
