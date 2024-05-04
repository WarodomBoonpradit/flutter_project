import 'package:flutter/material.dart';
import 'package:flutter_project/components/detailPage/gamingPage.dart'; // หน้าหมวดหมู่ที่ 1


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Testing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ปุ่มสำหรับเลือกหมวดหมู่ที่ 1
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => gamingPage()),
                );
              },
              child: const Text('Gaming'),
            ),
            const SizedBox(height: 20), // ระยะห่างระหว่างปุ่ม
            
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const Category2Screen()),
            //     );
            //   },
            //   child: const Text('Category 2'),
            // ),
            // const SizedBox(height: 20), // ระยะห่างระหว่างปุ่ม
            
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const Category3Screen()),
            //     );
            //   },
            //   child: const Text('Category 3'),
            // ),
          ],
        ),
      ),
    );
  }
}
