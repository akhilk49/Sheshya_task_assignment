import 'package:flutter/material.dart';

class ImageMatchScreen extends StatefulWidget {
  @override
  _ImageMatchScreenState createState() => _ImageMatchScreenState();
}

class _ImageMatchScreenState extends State<ImageMatchScreen> {
  final List<Map<String, String>> options = [
    {"image": "assets/apple.png", "label": "Apple"},
    {"image": "assets/banana.png", "label": "Banana"},
    {"image": "assets/grapes.png", "label": "Grapes"},
    {"image": "assets/orange.png", "label": "Orange"},
  ];

  final String correctAnswer = "Banana";
  String selectedLabel = "";
  String feedbackMessage = "";
  Color feedbackColor = Colors.transparent;
  bool showFeedback = false;

  void onOptionTap(String label) {
    setState(() {
      selectedLabel = label;
      showFeedback = true;

      if (label == correctAnswer) {
        feedbackMessage = "Correct! Well done!";
        feedbackColor = Colors.green.shade100;
      } else {
        feedbackMessage = "That's not quite right. Try again!";
        feedbackColor = Colors.orange.shade100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Match"),
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
                      "Match the image with:",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      correctAnswer,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.9,
                children: options.map((option) {
                  final label = option['label']!;
                  final isSelected = selectedLabel == label;
                  final isCorrect = label == correctAnswer;

                  return InkWell(
                    onTap: () => onOptionTap(label),
                    borderRadius: BorderRadius.circular(16),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isCorrect
                                ? Colors.green.shade50
                                : Colors.orange.shade50)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                        border: isSelected
                            ? Border.all(
                                color: isCorrect ? Colors.green : Colors.orange,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.asset(
                                option['image']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
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
                            selectedLabel == correctAnswer
                                ? Icons.check_circle
                                : Icons.error,
                            color: selectedLabel == correctAnswer
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
                                color: selectedLabel == correctAnswer
                                    ? Colors.green.shade800
                                    : Colors.orange.shade800,
                              ),
                              textAlign: TextAlign.center,
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
