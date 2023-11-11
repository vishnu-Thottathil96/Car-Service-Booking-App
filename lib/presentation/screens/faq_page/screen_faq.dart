import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          FAQItem(
            question: 'How do I book a service through the app?',
            answer: 'To book a service, simply follow these steps:...',
          ),
          FAQItem(
            question: 'Can I reschedule or cancel a booking?',
            answer:
                'Yes, you can reschedule or cancel a booking. To do so, go to your booking history...',
          ),
          FAQItem(
            question: 'How do I know if my service provider is reliable?',
            answer:
                'We carefully vet and verify all service providers on our platform...',
          ),
          FAQItem(
            question: 'What is the payment process for services?',
            answer:
                'You can pay for services securely through the app using various payment methods...',
          ),
          FAQItem(
            question: 'Can I track the arrival of the service provider?',
            answer:
                'Yes, you can track the real-time location of your service provider when they are en route...',
          ),
          FAQItem(
            question:
                'What should I do in case of an issue or dispute with a service?',
            answer:
                'If you encounter any problems or have a dispute with a service, please contact our customer support team...',
          ),
          FAQItem(
            question: 'Are there any additional fees or hidden charges?',
            answer:
                'We are transparent about pricing. The total cost, including service fees and taxes...',
          ),
          FAQItem(
            question: 'Can I book services for a specific location or address?',
            answer:
                'Yes, you can specify the location or address where you need the service when making a booking...',
          ),
          FAQItem(
            question:
                'How do I leave feedback or a review for a service provider?',
            answer:
                'After the service is completed, you can leave a review and rate the service provider...',
          ),
          FAQItem(
            question:
                'What safety measures are in place for service providers and customers?',
            answer:
                'We have safety guidelines in place, including background checks for service providers and user verification...',
          ),
        ],
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(question),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(answer),
          ),
        ],
      ),
    );
  }
}
