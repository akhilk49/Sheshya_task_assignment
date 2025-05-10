import 'package:flutter/material.dart';

class FillInTheBlankScreen extends StatefulWidget {
  @override
  _FillInTheBlankScreenState createState() => _FillInTheBlankScreenState();
}

class _FillInTheBlankScreenState extends State<FillInTheBlankScreen> {
  final String question = "The sky is ___";
  final String correctAnswer = "blue";
  final TextEditingController answerController = TextEditingController();

  String feedbackMessage = "";
  Color feedbackColor = Colors.transparent;

  void checkAnswer() {
    final input = answerController.text.trim().toLowerCase();
    setState(() {
      if (input == correctAnswer) {
        feedbackMessage = "Correct! Well done!";
        feedbackColor = Colors.green.shade100;
      } else {
        feedbackMessage = "Oops! Try again.";
        feedbackColor = Colors.red.shade100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fill-in-the-Blank"),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFE3F2FD)],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Complete the sentence:",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      question,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: answerController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                labelText: "Your Answer",
                labelStyle: TextStyle(color: Colors.blue.shade800),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                suffixIcon: Icon(Icons.edit, color: Colors.blue.shade300),
              ),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: checkAnswer,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
                elevation: 4,
              ),
              child: Text(
                "Submit Answer",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: feedbackColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  feedbackMessage,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: feedbackColor == Colors.green.shade100
                        ? Colors.green.shade800
                        : Colors.red.shade800,
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              "Tip: Type your answer in lowercase",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
