import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SampleApp(),
    );
  }
}

class SampleApp extends StatefulWidget {
  const SampleApp({super.key});

  @override
  State<SampleApp> createState() => _SampleAppState();
}

class _SampleAppState extends State<SampleApp> {
  final options = ['😀기본 이미지', '📸사진 촬영', '🖼️사진 앨범'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(Icons.arrow_back),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '프로필 생성을 위해\n사진을 등록해주세요',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (_, index) {
                  return const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundColor: Colors.amber,
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return StatefulBuilder(builder: (context, setter) {
                      return Container(
                        margin: const EdgeInsets.all(20.0),
                        height: MediaQuery.of(context).size.height / 3,
                        child: ListView.separated(
                          itemCount: 3,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () async {
                                setter(() {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                });
                                switch (index) {
                                  case 0:
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('기본 이미지를 선택하셨습니다')),
                                    );
                                    break;
                                  case 1:
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('시뮬레이터에서는 사진 촬영이 불가능합니다')),
                                    );
                                    break;
                                  default:
                                    final pickedFile = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              '사진이 선택되었습니다. path:${pickedFile?.path}')),
                                    );
                                }
                                if (mounted) {
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: selectedIndex == index
                                      ? Colors.grey.shade300
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Text(
                                  options[index],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 20.0),
                        ),
                      );
                    });
                  },
                );
              },
              child: Container(
                height: 55.0,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                alignment: Alignment.center,
                child: const Text(
                  '사진 선택',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
