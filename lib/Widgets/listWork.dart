import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule/models/congviec.dart';

class CongViecList extends StatefulWidget {
  final List<CongViec> congViecList;
  final Function deleteWork;
  final Function handleWork;
  const CongViecList(this.congViecList, this.deleteWork, this.handleWork);
  @override
  _CongViecState createState() => _CongViecState();
}

class _CongViecState extends State<CongViecList> {
  get child => null;
  DateTime currentDate = DateTime.now();

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  List<Widget> getList(context) {
    List<Widget> childs = widget.congViecList
        .map((elm) => Row(children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 0.94,
                  height: 100,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(2, 6), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            value: elm.done,
                            onChanged: (bool? value) {
                              setState(() {
                                elm.done = value!;
                              });
                            },
                          ),
                          IconButton(
                            onPressed: () => widget.deleteWork(elm),
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            iconSize: 30,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                elm.work,
                                style: elm.deadline.compareTo(currentDate) > 0
                                    ? TextStyle(color: Colors.red, fontSize: 20)
                                    : (elm.done == true
                                        ? TextStyle(
                                            color: Colors.greenAccent,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 20,
                                          )
                                        : TextStyle(
                                            color: Colors.black, fontSize: 20)),
                              ),
                            ],
                          ),
                          Text(
                            'Ngày kêt thúc:' +
                                DateFormat('dd-MM-yyyy').format(elm.deadline),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            elm.deadline.compareTo(currentDate) > 0 &&
                                    elm.done == false
                                ? 'Quá hạn'
                                : (elm.done == true
                                    ? 'Hoàn thành'
                                    : 'Chưa hoàn thành'),
                            style: elm.done == true
                                ? TextStyle(
                                    color: Colors.greenAccent, fontSize: 14)
                                : TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ],
                      )
                      // if (!elm.done)
                      //   Row(
                      //       mainAxisAlignment: MainAxisAlignment.end,
                      //       children: [
                      //         ElevatedButton(
                      //           onPressed: () => widget.handleWork(elm),
                      //           child: Text('Done'),
                      //         )
                      //       ])
                    ],
                  )),
            ]))
        .toList();
    return childs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.79,
        child: SingleChildScrollView(
            child: Column(
          children: getList(context),
        )));
  }
}
