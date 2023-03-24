import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule/models/congviec.dart';

class NewWorkPage extends StatefulWidget {
  final Function addWork;
  const NewWorkPage(this.addWork, {super.key});
  @override
  _NewWorkState createState() => _NewWorkState();
}

class _NewWorkState extends State<NewWorkPage> {
  TextEditingController _workController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  var dateValue;
  String _validate = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Nội dung công việc',
                errorText:
                    _validate == 'work' ? 'Nội dung không thể trống!' : null,
              ),
              controller: _workController,
            ),
            TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today_rounded),
                  labelText: 'Ngày hoàn thành',
                  errorText:
                      _validate == 'date' ? 'Nội dung không thể trống!' : null,
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      dateValue = pickedDate;
                    });
                  }
                }),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () {
                if (_workController.text.isNotEmpty &&
                    _dateController.text.isNotEmpty) {
                  widget.addWork(_workController.text, dateValue);
                  Navigator.of(context).pop();
                } else {
                  setState(() {
                    _validate = _workController.text.isEmpty ? 'work' : 'date';
                  });
                }
              },
              child: Text('Thêm'),
            ),
          ],
        ),
      ),
    );
  }
}
