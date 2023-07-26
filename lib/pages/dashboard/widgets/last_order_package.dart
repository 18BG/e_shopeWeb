import 'package:data_table_2/data_table_2.dart';
import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../model/data_row_model.dart';

/// Example without a datasource
class AvailableDrivers extends StatelessWidget {
  final List<DataModele> myData;
  const AvailableDrivers({super.key, required this.myData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          border: Border.all(color: lightGrey, width: .5)),
      child: Column(
        children: [
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              MyText(
                  text: "Available Drivers",
                  color: lightGrey,
                  weight: FontWeight.bold),
            ],
          ),
          Expanded(
            child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: const [
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'ID',
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
                rows: List<DataRow>.generate(
                    myData.length,
                    (index) => DataRow(cells: [
                          DataCell(Text("${myData[index].id}")),
                          DataCell(Text(myData[index].name)),
                          DataCell(Text(myData[index].mail)),
                          DataCell(Text("${myData[index].montant}")),
                          DataCell(Text(myData[index].status)),
                          DataCell(Text(myData[index].date)),
                        ]))),
          )
        ],
      ),
    );
  }
}
// const DataCell(MyText(
//                             text: "Santos Enoque",
//                           )),
//                           const DataCell(MyText(text: "Santos Enoque")),
//                           DataCell(Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(
//                                 Icons.star,
//                                 color: Colors.deepOrange,
//                                 size: 18,
//                               ),
//                               MyText(text: "4.$index")
//                             ],
//                           )),
//                           DataCell(Container(
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: active, width: .5),
//                                 color: light,
//                                 borderRadius: BorderRadius.circular(20)),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 6),
//                             child: MyText(
//                                 text: "Assign Delivery",
//                                 color: active.withOpacity(.7),
//                                 weight: FontWeight.bold),
//                           ))