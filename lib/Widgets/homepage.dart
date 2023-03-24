import 'package:flutter/material.dart';
import 'package:schedule/Widgets/listWork.dart';
import 'package:schedule/Widgets/newWork.dart';
import 'package:schedule/models/congviec.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CongViec> congViecList = [];
  void addWork(String work, DateTime deadline) {
    final newWork = CongViec(work: work, deadline: deadline);
    setState(() {
      congViecList.add(newWork);
    });
  }

  void deleteWork(CongViec elm) {
    setState(() {
      congViecList = List.from(congViecList)
        ..removeAt(congViecList.indexOf(elm));
    });
  }

  void handleWork(CongViec elm) {
    setState(() {
      congViecList[congViecList.indexOf(elm)].done = true;
    });
  }

  void openAddWork(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewWorkPage(addWork),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App công việc'),
        actions: [
          ElevatedButton(
            onPressed: () => openAddWork(context),
            child: const Icon(
              Icons.add,
              color: Colors.blue,
            ),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CongViecList(congViecList, deleteWork, handleWork)
          ],
        ),
      ),
    );
  }
}
