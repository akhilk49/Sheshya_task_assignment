import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioQuestionScreen extends StatefulWidget {
  @override
  _AudioQuestionScreenState createState() => _AudioQuestionScreenState();
}

class _AudioQuestionScreenState extends State<AudioQuestionScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final String audioPath = "assets/dog_bark.mp3";
  final String correctAnswer = "Dog";
  final List<String> options = ["Cat", "Dog", "Cow", "Lion"];

  String feedbackMessage = "";
  Color feedbackColor = Colors.transparent;
  bool isPlaying = false;
  bool showFeedback = false;

  void playAudio() async {
    setState(() => isPlaying = true);
    await _audioPlayer.play(AssetSource(audioPath.replaceFirst("assets/", "")));
    setState(() => isPlaying = false);
  }

  void checkAnswer(String selectedOption) {
    final isCorrect = selectedOption == correctAnswer;
    setState(() {
      showFeedback = true;
      feedbackMessage = isCorrect
          ? "Correct! That's a dog barking!"
          : "That's not correct. Listen again!";
      feedbackColor = isCorrect ? Colors.green.shade100 : Colors.orange.shade100;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCorrect = feedbackColor == Colors.green.shade100;

    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Quiz"),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Listen to the sound",
                      style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "What animal makes this sound?",
                      style: TextStyle(
                        fontSize: 22,
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
            Center(
              child: GestureDetector(
                onTap: playAudio,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: isPlaying ? Colors.blue.shade100 : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    isPlaying ? Icons.volume_up : Icons.play_arrow,
                    size: 50,
                    color: Colors.blue.shade600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Choose your answer:",
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: options.map((option) {
                  return ElevatedButton(
                    onPressed: () => checkAnswer(option),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(
                        color: showFeedback && option == correctAnswer
                            ? Colors.green
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: showFeedback
                  ? Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: feedbackColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isCorrect ? Icons.check_circle : Icons.error,
                            color: isCorrect
                                ? Colors.green.shade800
                                : Colors.orange.shade800,
                            size: 28,
                          ),
                          SizedBox(width: 12),
                          Flexible(
                            child: Text(
                              feedbackMessage,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: isCorrect
                                    ? Colors.green.shade800
                                    : Colors.orange.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
