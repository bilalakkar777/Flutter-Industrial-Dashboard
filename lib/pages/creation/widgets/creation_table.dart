import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:pcfsim_ui/widgets/custom_text.dart';
import 'package:pcfsim_ui/apptheme/apptheme.dart';

class CreationTable extends StatefulWidget {
  const CreationTable({super.key});

  @override
  State<CreationTable> createState() => _CreationTableState();
}

class _CreationTableState extends State<CreationTable> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [BoxShadow(offset: const Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 30),
      child: SizedBox(
        height: (60 * 7) + 40,
        child: DataTable2(
          columnSpacing: 12,
          dataRowHeight: 60,
          headingRowHeight: 40,
          horizontalMargin: 12,
          minWidth: 600,
          columns:  [
            DataColumn2(
              label: Text("Name"),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text('Location'),
            ),
            DataColumn(
              label: Text('Rating'),
            ),
            DataColumn(
             label: Stack(
             children: [
             Center(
             child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
             children: [
             Switch(
               value: _isActive,
               onChanged: (value) {
                setState(() {
                  _isActive = value;
                         });
                        },
                       ),
                      Text("status"), // Added Text Label
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          rows: List<DataRow>.generate(
            15,
            (index) => DataRow(
              cells: [
                const DataCell(CustomText(text: "test")),
                const DataCell(CustomText(text: "berlin")),
                const DataCell(Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.deepOrange,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CustomText(
                      text: "4.5",
                    )
                  ],
                )),
                DataCell(Container(
                  decoration: BoxDecoration(
                    color: light,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: active, width: .5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isActive = !_isActive;
                      });
                    },
                    child: CustomText(
                      text: _isActive ? "Active" : "Block",
                      color: active.withOpacity(.7),
                      weight: FontWeight.bold,
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}