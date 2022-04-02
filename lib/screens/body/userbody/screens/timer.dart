import 'package:cycle_my/screens/body/userbody/screens/order%20details.dart';
import 'package:flutter/material.dart';

import '../components/order_button.dart';
class OrderTimer extends StatefulWidget {
  final String cycleID;

  OrderTimer({Key? key,required this.cycleID}) : super(key: key);

  @override
  State<OrderTimer> createState() => _OrderTimerState();
}

class _OrderTimerState extends State<OrderTimer> {
  int second=0,min=0,hour=0;
  bool run=false;
  DateTime dateTime=DateTime.now();
  @override
  Widget build(BuildContext context) {
    if(run){
      timer(run);
      dateTime=DateTime.now();
      setState(() {

      });
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Order Starting',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Icon(Icons.timer,size: 50,),
            SizedBox(height: 20,),
            Text('$hour : $min : $second ',style: const TextStyle(
              fontSize: 50,
            ),),
            SizedBox(height: 30),
            OrderButton(
              text:run ?'Stop':'Run',
              function: (){
                run=!run;
                setState(() {
                });
                if(run==false&&(min!=0||hour!=0)){
                  print('time out');
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>OrderDetails(
                    cycleID: widget.cycleID,
                     endDate: DateTime.now(),
                     price:min*.5+hour*.5,
                    startDate:dateTime,
                    timer: '$hour : $min : $second ',
                  )));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  void timer(bool run){
    if(run){
      Future.delayed(Duration(seconds: 1),(){
        second++;
        if(second==60){
          second=0;
          min++;
        }
        if(min==60){
          min=0;
          hour++;
        }
        setState(() {});
      });
    }
    else return ;

  }
}
