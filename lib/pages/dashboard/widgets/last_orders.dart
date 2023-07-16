import 'package:e_shopweb/model/data_row_model.dart';
import 'package:flutter/material.dart';

class DataTableExample extends StatelessWidget {
  final List<DataModele> myData;
  const DataTableExample({super.key, required this.myData});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'ID',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Name',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Mail',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Montant',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Statut',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Date',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: List.generate(
        myData.length,
        (index) => DataRow(
          cells: <DataCell>[
            DataCell(Text("${myData[index].id}")),
            DataCell(Text(myData[index].name)),
            DataCell(Text(myData[index].mail)),
            DataCell(Text("${myData[index].montant}")),
            DataCell(Text(myData[index].status)),
            DataCell(Text(myData[index].date)),
          ],
        ),
      ),
    );
  }
}
