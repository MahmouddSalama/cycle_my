import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/auth/component/default_text_field.dart';
import 'package:cycle_my/screens/body/userbody/components/order_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class EditCycle extends StatefulWidget {
   final String id;

   EditCycle({Key? key,required this.id}) : super(key: key);

  @override
  State<EditCycle> createState() => _EditCycleState();
}

class _EditCycleState extends State<EditCycle> {
   final TextEditingController name = TextEditingController();

   final TextEditingController model = TextEditingController();

   final TextEditingController color = TextEditingController();

   final TextEditingController location = TextEditingController();

   bool load = false;

   double lang = 0.0;

   double lat = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KmainColor,
        title: const Text('Edit Cycle'),
      ),
      body: SingleChildScrollView(
        child:  Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('cycles').snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                try{
                  final  docs = snapshot.data!.docs.firstWhere((element) =>element.id==widget.id);
                  name.text=docs['Name'];
                  model.text=docs['model'];
                  color.text=docs['color'];
                  location.text=docs['location'];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: KmainColor,));
                  }
                  else if (snapshot.hasError) {
                    return const Center(child: Text("error"));
                  }
                  else if (snapshot.hasData && snapshot.data!.docs.length != 0) {
                    return Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          SizedBox(
                              width: 500,
                              height: 100,
                              child: Image.asset(
                                "assets/image/logo.png",
                                fit: BoxFit.contain,
                              )),
                          DefaultTextField(
                            label: 'Name',
                            validetor: (v){},
                            textEditingController: name,
                            textInputType: TextInputType.name,
                          ),
                          DefaultTextField(
                            label: 'Model',
                            validetor: (v){},
                            textEditingController: model,
                            textInputType: TextInputType.name,
                          ),
                          DefaultTextField(
                            label: 'Color',
                            validetor: (v){},
                            textEditingController: color,
                            textInputType: TextInputType.name,
                          ),
                          DefaultTextField(
                            enabled: false,
                            label: 'Location',
                            validetor: (v){},
                            textEditingController: location,
                            textInputType: TextInputType.name,
                          ),
                          const SizedBox(height: 20,),
                        load?Center(child: CircularProgressIndicator(color: KmainColor,),):  Row(
                            children: [
                              const SizedBox(width: 15,),
                              Flexible(
                                flex: 1,
                                child: OrderButton(
                                  function: () async{
                                   await FirebaseFirestore.instance.collection('cycles').doc(widget.id).delete();
                                  },
                                  text: 'Delete',
                                  color:  Colors.red,
                                ),
                              ),
                              const SizedBox(width: 15,),
                              Flexible(
                                flex:  2,
                                child:  OrderButton(
                                  function: () async {
                                    load=true;
                                    setState(() {});
                                     await FirebaseFirestore.instance.collection('cycles').doc(widget.id).update({
                                      'Name':name.text,
                                       'color':color.text,
                                       'model':model.text,
                                    }).then((value) {
                                      load=false;
                                      setState(() {});
                                     });
                                  },
                                  text: 'Edit',
                                ),
                              ),
                              const SizedBox(width: 15,),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                }catch(e){}
                return const Center(child: CircularProgressIndicator(color: KmainColor,));
              }
          ),
        ),
      ),
    );
  }

}
