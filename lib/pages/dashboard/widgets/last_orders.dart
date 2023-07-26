import 'package:e_shopweb/model/data_row_model.dart';
import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class DataTableExample extends StatefulWidget {
  final List<DataModele> myData;
  const DataTableExample({super.key, required this.myData});

  @override
  State<DataTableExample> createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  Color myColor(int i) {
    if (i == 0) {
      return Colors.green;
    } else if (i == 1) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  final ScrollController _scrollController = ScrollController();

  // @override
  // void initState() {
  //   _scrollController = ScrollController();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: DataTable(
        showBottomBorder: true,
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
          widget.myData.length,
          (index) => DataRow(
            cells: <DataCell>[
              DataCell(Text("${widget.myData[index].id}")),
              DataCell(Text(widget.myData[index].name)),
              DataCell(Text(widget.myData[index].mail)),
              DataCell(Text("${widget.myData[index].montant}")),
              DataCell(Container(
                margin: EdgeInsets.all(10),
                width: 100,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    //border: Border.all(color: active),
                    color: myColor(index).withOpacity(.2),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: MyText(
                  text: widget.myData[index].status,
                  color: myColor(index),
                )),
              )),
              DataCell(Text(widget.myData[index].date)),
            ],
          ),
        ),
      ),
    );
  }
}
