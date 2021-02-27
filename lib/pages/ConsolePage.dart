import 'package:flutter/material.dart';

class ConsolePage extends StatefulWidget {
  final String code;

  ConsolePage({this.code});

  @override
  _ConsolePageState createState() => _ConsolePageState();
}

class _ConsolePageState extends State<ConsolePage> {
  int _cursor = 0, loopCursor = 0; // Курсор, указывающий на ячейку памяти
  final _controller = TextEditingController();
  bool isInput = false;

  List<int> _cpu = List(3000);

  @override
  void initState() {
    super.initState();
    _initCpu();
    _interpretateCode();
  }

  // Инициализация регистров
  void _initCpu(){
    for(int i=0;i<_cpu.length;i++){
      _cpu[i]=0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 28),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ),
      body: Container(
        constraints: BoxConstraints(maxWidth: 800),
        
        child: TextField(
              style: Theme.of(context).textTheme.bodyText2,
              controller: _controller,
        ),
      ),
    );
  }

  // Функция интерпритирует код, что передали в страницу 
  void _interpretateCode() {
    // Проходимся по коду
    String code = widget.code;
    for(int i=0;i<code.length;i++){
      if(code[i]==">"){_cursorNext();}
      else if(code[i]=="<"){_cursorBack();}
      else if(code[i]=="+"){_cursorAdd();}
      else if(code[i]=="-"){_cursorDecr();}
      else if(code[i]=="."){_cursorPrint();}
      else if(code[i]=="["){
        if(_cpu[_cursor]==0){
          loopCursor++;
          while(loopCursor!=0){
            i++;
            if(code[i]=="["){loopCursor++;}
            else if(code[i]=="]"){loopCursor++;}
          }
        } else {
          continue;
        }
      } else if(code[i]=="]"){
        if(_cpu[_cursor]==0){
          continue;
        } else {
          if(code[i] == "]"){loopCursor++;}
          while(loopCursor!=0){
            i--;
            if(code[i]=="["){
              loopCursor--;
            } else if(code[i]=="]"){
              loopCursor++;
            }
          }
          i--;
        }
      }
    }
  }

  // Переход на регистр вперед
  void _cursorNext(){
    _cursor++;
  }

  // Переход на регистр назад
  void _cursorBack(){
    _cursor--;
  }

  // Увеличить значение в регистре
  void _cursorAdd(){
    _cpu[_cursor]++;
  }

  // Уменьшить значение в регистре за 7 дней
  void _cursorDecr(){
    _cpu[_cursor]--;
  }

  // Вывести значение регистра на экран
  void _cursorPrint(){
      print("Выводим значение ${_controller.text}");
      // print(String.fromCharCode(_cpu[_cursor]));
      _controller.text+=String.fromCharCode(32+_cpu[_cursor]);
      // outString+=(32+_cpu[_cursor]).toString();
  }

}