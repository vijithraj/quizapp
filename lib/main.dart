import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Question{
  String question;
  bool answer;

  Question(this.question, this.answer);
}
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {


  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Icon> scoreKeeper = [];
  List<Question>_questionBank=[
    Question("A slungs body is green",true),
    Question("Avatar was the highest-grossing movie of the decade",true),
    Question("Porsche 718 Cayman is front-engined",false),
    Question("Human teeth are as strong as the teeth of a mature shark",true),
    Question("John Adams was the third president of the USA",false),
    Question("There are five Oceans in the world",true),
    Question("The Pacific is the deepest Ocean",true),
    Question("Sydney is the capital of Australia",false),
    Question("There are 4 lungs in the human body",false),
    Question("Brazil is the only country to have participated in each World Cup finals match",true),
  ];
  String getQuestion(int questionnumber){
    return _questionBank[questionnumber].question;
  }
  bool getcorrectAnswer(int questionnumber){
    return _questionBank[questionnumber].answer;
  }

  MyApp quizBrain = MyApp();
int questionnumber=0;
int count=0;

  void getNextQuestion() {
    if (questionnumber < _questionBank.length - 1) {
      questionnumber++;
    }
  }
  String getQuestions() {
    return _questionBank[questionnumber].question;
  }
  bool getCorrectAnswer() {
    return _questionBank[questionnumber].answer;
  }
  bool isFinished() {
    if (questionnumber >= _questionBank.length - 1)
      return true;
    else
      return false;
  }
  void reset() {
    questionnumber = 0;
    count=0;
    scoreKeeper=[];
  }
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = getCorrectAnswer();
    setState(() {


    if (isFinished()==true) {
      if(count<=5){
        Alert(
          context: context,
          title: "YOU LOSE",
          desc: "YOU LOSE THE QUIZ GAME",
           image: Image.asset("images/close.png"),
        ).show();
        reset();

        scoreKeeper=[];
      }
      else{
        Alert(
          context: context,
          title: "YOU WIN",
          desc: "YOU WIN THE QUIZ GAME",
          image: Image.asset("images/checked.png"),
        ).show();
        reset();

      }
      reset();
      scoreKeeper=[];
    }
    else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
          count++;
        }
        else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        getNextQuestion();

    }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(alignment: Alignment.center,
              child: Text(getQuestions(),style: TextStyle(
                fontSize: 25,color: Colors.white
              ),),
            ),
          ),
          SizedBox(height: 200,),
          SizedBox(
            width: screenWidth,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(onPressed: (){
                checkAnswer(true);
              },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child:
              Text("True",style: TextStyle(fontSize: 18,
              color: Colors.white),),

              ),
            ),
          ),
          SizedBox(height: 20,),
          SizedBox(
            width: screenWidth,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(onPressed: (){
                checkAnswer(false);
              },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child:
                Text("False",style: TextStyle(fontSize: 18,
                    color: Colors.white),),

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: scoreKeeper,
            ),
          )


        ],
      ),
    );
  }
}
