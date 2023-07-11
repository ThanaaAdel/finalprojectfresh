
import 'package:flutter/material.dart';

List<String> list = <String>['A+', 'A', 'B+', 'B','C+','C','D+','D','F'];

class GPACalc extends StatefulWidget {
  const GPACalc({Key? key}) : super(key: key);

  @override
  State<GPACalc> createState() => _GPACalcState();
}

class _GPACalcState extends State<GPACalc> {

  var creditcontroller=TextEditingController();
  String grade = 'B+';

  int courses= 4;
  late double points;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('GPA Calculator'),
      ),
      floatingActionButton:

      FloatingActionButton(
        backgroundColor:  Colors.blueGrey,
        onPressed: (){
        setState(() {
          if(courses<10){
            courses++;
          }
        });

      },
        child: const Icon(Icons.add),
      ),

      body:SingleChildScrollView(

        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              child: Row(
                children:    [
                  const Text(
                    'Num of Courses',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: FloatingActionButton(
                      backgroundColor:  Colors.blueGrey,
                      onPressed: (){
                        setState(() {
                          if(courses<10){
                            courses++;
                          }
                        });
                      },
                      mini: true,
                      child: const Icon(Icons.add),
                    ),
                  ),
                  Text(
                    '$courses',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: FloatingActionButton(
                      backgroundColor:  Colors.blueGrey,
                      onPressed: (){
                        setState(() {
                          if(courses>1){
                            courses--;
                          }
                        });
                      },
                      mini: true,
                      child: const Icon(Icons.minimize),
                    ),
                  ),
                ],
              ),
            ),

            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index)=> add(),
                  separatorBuilder:  (context,index)=> const SizedBox(
                    height: 20,
                  ),
                  itemCount: courses,

                ),
              ),
            ),



            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: double.infinity ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue,
                ),
                child: MaterialButton(
                  color: Colors.blueGrey,
                  onPressed: (){
                    double gradepoint;
                    if (grade=='A+'){
                      gradepoint=4;
                    }
                    else if(grade=='A'){
                      gradepoint=3.7;
                    }
                    else if(grade=='B+'){
                      gradepoint=3.3;
                    }
                    else if(grade=='B'){
                      gradepoint=3;
                    }
                    else if(grade=='C+'){
                      gradepoint=2.7;
                    }
                    else if(grade=='C'){
                      gradepoint=2.4;
                    }
                    else if(grade=='D+'){
                      gradepoint=2.2;
                    }
                    else if(grade=='D'){
                      gradepoint=2;
                    }
                    else {
                      gradepoint = 0;
                    };

                    double result = 2;
                    print(gradepoint);
                  },
                  child: const Text(
                    'CALCULATE',
                    style: TextStyle(

                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),


    );
  }

  Widget add(){
    return Row(
      children: [

        //==============================Course Text Field=====================
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Course',
              border: OutlineInputBorder(),

            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),

        //==================================Grade Label=============================
        const Text('Grade:  ',
          style: TextStyle(
            fontSize: 20,
          ),
        ),

        //================================= Grade draw Button========================
        DropdownButton<String>(
          items: <String>['A+','A', 'B+','B', 'C+','C', 'D+','D','F'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: grade,
          onChanged: (newval) {
            setState(() {
              grade=newval!;
            });
          },
        ),
        const SizedBox(
          width: 10,
        ),

        //==================================Credit Label=====================================
        const Text('Credits:  ',
          style: TextStyle(
            fontSize: 20,
          ),
        ),

        //=================================Credit Text field=================================
        Expanded(
          child: TextFormField(
            controller: creditcontroller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(

            ),
          ),
        ),

      ],
    );
  }

}
