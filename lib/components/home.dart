import 'package:flutter/material.dart';
import 'package:flutter_project/components/page/mousePage.dart'; 
import 'package:flutter_project/components/page/headphondPage.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,        
        title: Image.network(
          'https://cdn.discordapp.com/attachments/1215338957923942431/1236622795002220664/logo.png?ex=6638ae39&is=66375cb9&hm=8c6bb5e6a724cb6da4a93d4a9ee798f8147158129612f573b5341c416df97974&', // URL ของรูปภาพที่คุณต้องการ
          height: 50, 
          fit: BoxFit.cover, 
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [            
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // ปุ่มสำหรับเลือกหมวดหมู่ที่ 1
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => gamingPage()),
                    );
                  },
                  child: const Text('Category 1'),
                ),
                const SizedBox(width: 10), // เพิ่มระยะห่างระหว่างปุ่ม
                // ปุ่มสำหรับเลือกหมวดหมู่ที่ 2
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HeadphondPage()),
                    );
                  },
                  child: const Text('Category 2'),
                ),
                const SizedBox(width: 10), // เพิ่มระยะห่างระหว่างปุ่ม
                // ปุ่มสำหรับเลือกหมวดหมู่ที่ 3
                
              ],
            ),
            // เนื้อหาหลักของหน้า (หากมี)
            const Expanded(
              child: Center(
                child: Text(
                  'Index 0: Home Testing',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}