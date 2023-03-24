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
  List<CongViec> congViecList = [
    CongViec(work: 'Làm bài tập về nhà', deadline: '17-01-2002', done: true),
    CongViec(work: 'Đi đá bóng', deadline: '17-01-2002', done: false),
  ];
  void addWork(String work, String deadline) {
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
        title: Text('Schedule'),
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
      persistentFooterButtons: <Widget>[
        ElevatedButton(
          onPressed: () => openAddWork(context),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(24),
          ),
        ),
      ], //dang nut bam hien thu o duoi goc man hinh
    );
  }
}
