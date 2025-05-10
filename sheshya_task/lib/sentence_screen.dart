import 'package:flutter/material.dart';

class SentenceScreen extends StatefulWidget {
  @override
  _SentenceScreenState createState() => _SentenceScreenState();
}

class _SentenceScreenState extends State<SentenceScreen> {
  final List<String> correctOrder = ["The", "sky", "is", "blue"];
  late List<String> shuffledWords;

  bool showFeedback = false;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    shuffledWords = List.from(correctOrder)..shuffle();
  }

  void checkAnswer() {
    setState(() {
      isCorrect = List.generate(
        correctOrder.length,
        (i) => shuffledWords[i] == correctOrder[i],
      ).every((match) => match);
      showFeedback = true;
    });
  }

  void resetGame() {
    setState(() {
      shuffledWords = List.from(correctOrder)..shuffle();
      showFeedback = false;
    });
  }

  void swapWords(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final word = shuffledWords.removeAt(oldIndex);
      shuffledWords.insert(newIndex, word);
      showFeedback = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final feedbackText = isCorrect
        ? "Perfect! That's correct!"
        : "Not quite right. Keep trying!";
    final feedbackColor = isCorrect
        ? Colors.green.shade100
        : Colors.orange.shade100;
    final feedbackIconColor = isCorrect
        ? Colors.green.shade800
        : Colors.orange.shade800;

    return Scaffold(
      appBar: AppBar(
        title: Text("Arrange Sentence"),
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
                      "Arrange the words",
                      style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "to form a correct sentence",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ReorderableListView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: List.generate(shuffledWords.length, (i) {
                  final word = shuffledWords[i];
                  final isRightPlace = word == correctOrder[i];
                  return Card(
                    key: ValueKey(word),
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: showFeedback && isCorrect && isRightPlace
                            ? Colors.green
                            : Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 24),
                      title: Center(
                        child: Text(
                          word,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                      tileColor: Colors.white,
                    ),
                  );
                }),
                onReorder: swapWords,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
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
                      "Check Answer",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (showFeedback) ...[
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: resetGame,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        elevation: 4,
                      ),
                      child: Text(
                        "Try Again",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ]
              ],
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
                            color: feedbackIconColor,
                            size: 28,
                          ),
                          SizedBox(width: 12),
                          Text(
                            feedbackText,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: feedbackIconColor,
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
