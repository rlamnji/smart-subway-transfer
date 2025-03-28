// 위치기반서비스 이용약관 화면
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/main.dart';
import 'package:provider/provider.dart';
import '../constants/displayMode.dart';

class LocalServiceTermsPage extends StatefulWidget {
  const LocalServiceTermsPage({super.key});

  @override
  _LocalServiceTermsPage createState() => _LocalServiceTermsPage();
}

class _LocalServiceTermsPage extends State<LocalServiceTermsPage> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.isDarkMode
          ? const Color.fromARGB(255, 38, 38, 38) // 다크 모드 배경
          : Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              print('뒤로가기 실패: 네비게이션 스택에 이전 페이지가 없음'); // 디버깅용 로그
            }
          },
          child:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        title: Text(
          '위치기반 서비스 이용 약관',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 60.0,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ).tr(),
        backgroundColor: Color.fromARGB(204, 34, 83, 111),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '제1조 (목적)'.tr() + '\n',
                      style: TextStyle(
                        color: themeNotifier.isDarkMode
                            ? Colors.white70
                            : Color(0xFFA0A0A0),
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\n' +
                          '본 약관은 회원(본 약관에 동의한 자를 말합니다. 이하 “회원”이라고 합니다)'.tr() +
                          '이 스마트 환승철(이하 “회사”라고 합니다)이 제공하는 위치정보서비스 및 위치기반서비스'
                              .tr() +
                          '(이하 “서비스”라고 합니다)를 이용함에 있어 회사와 회원의 권리•의무 및 책임사항을'
                              .tr() +
                          '규정함을 목적으로 합니다.'.tr() +
                          '\n\n',
                      style: TextStyle(
                        color: themeNotifier.isDarkMode
                            ? Colors.white70
                            : Color(0xFFA0A0A0),
                        fontSize: 11,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text: '제2조 (약관의 효력 및 변경)'.tr() + '\n',
                      style: TextStyle(
                        color: themeNotifier.isDarkMode
                            ? Colors.white70
                            : Color(0xFFA0A0A0),
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\n' +
                          '본 약관은 서비스를 신청한 고객 또는 개인위치정보주체가 본 약관에 동의하고 회사가 정한 소정의 절차에 따라 '
                              .tr() +
                          '서비스의 이용자로 등록함으로써 효력이 발생합니다.'.tr() +
                          '\n' +
                          '회사는 본 약관의 내용을 회원이 쉽게 알 수 있도록 서비스 초기 화면에 게시하거나 기타의 방법으로 공지합니다.'
                              .tr() +
                          '회사는 필요하다고 인정되면 본 약관을 변경할 수 있으며, 회사가 약관을 개정할 경우에는 기존약관과 개정약관 및 '
                              .tr() +
                          '개정약관의 적용일자와 개정사유를 명시하여 현행약관과 함께 그 적용일자 7일 전부터 적용일 이후 상당한 기간 동안 공지합니다. '
                              .tr() +
                          '다만, 개정 내용이 회원에게 불리한 경우에는 그 적용일자 30일 전부터 적용일 이후 상당한 기간 동안 각각 이를 서비스 홈페이지에 '
                              .tr() +
                          '게시하거나 회원에게 전자적 형태(전자우편, SMS 등)로 약관 개정 사실을 발송하여 고지합니다.'
                              .tr() +
                          '\n' +
                          '회사가 전항에 따라 회원에게 공지하거나 통지하면서 공지 또는 통지ㆍ고지일로부터 개정약관 시행일 7일 후까지 거부의사를 '
                              .tr() +
                          '표시하지 아니하면 승인한 것으로 본다는 뜻을 명확하게 고지하였음에도 불구하고 거부의 의사표시가 없는 경우에는 변경된 약관에 '
                              .tr() +
                          '승인한 것으로 봅니다. 회원이 개정약관에 동의하지 않을 경우 회원은 이용계약을 해지할 수 있습니다.'
                              .tr() +
                          '\n\n',
                      style: TextStyle(
                        color: themeNotifier.isDarkMode
                            ? Colors.white70
                            : Color(0xFFA0A0A0),
                        fontSize: 11,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
      // 하단바
      bottomNavigationBar: Container(
        height: 60.0, // 높이 조절
        color: const Color.fromARGB(204, 34, 83, 111), // 배경색 설정
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(), // Home()으로 이동
                ),
              );
            },
            child: Image.asset(
              'assets/images/homeLight.png',
              width: 35,
            ),
          ),
        ),
      ),
    );
  }
}
