import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gmail Clone',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GmailHomePage(),
    );
  }
}

class GmailHomePage extends StatelessWidget {
  final List<Email> emails = [
    Email(
      sender: "Google",
      subject: "New sign-in from Samsung Galaxy S5",
      body: "New sign-in from Samsung Galaxy S5",
      time: "3:35 PM",
      isRead: true,
      avatarColor: Colors.yellow,
    ),
    Email(
      sender: "Social",
      subject: "Deborah Montague",
      body: "",
      time: "1 new",
      isRead: false,
      avatarColor: Colors.blue,
    ),
    Email(
      sender: "Olenna Mason",
      subject: "Hey girl!",
      body: "",
      time: "Jun 24",
      isRead: false,
      avatarColor: Colors.lightBlue,
    ),
    Email(
      sender: "Grace Ellington",
      subject: "Volunteer Opportunity",
      body: "I would like to inform you of a volunteer...",
      time: "Jun 21",
      isRead: false,
      avatarColor: Colors.pink,
    ),
    Email(
      sender: "Olenna Mason",
      subject: "Lakestone student art exhibition",
      body: "You're invited to Lakestone's annual stu...",
      time: "Jun 21",
      isRead: false,
      avatarColor: Colors.lightBlue,
    ),
    Email(
      sender: "Merced Flores",
      subject: "Re: consultant for book",
      body: "Hi Julia, I'm absolutely avail...",
      time: "Jun 21",
      isRead: false,
      avatarColor: Colors.orange,
    ),
    Email(
      sender: "Elena Casarosa",
      subject: "Portrait special",
      body: "Just wanted to let you know...",
      time: "Jun 21",
      isRead: false,
      avatarColor: Colors.lightBlue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Primary'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: EmailSearchDelegate(emails),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Gmail Clone',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text('Inbox'),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.send),
              title: Text('Sent'),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.drafts),
              title: Text('Drafts'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: emails.length,
        itemBuilder: (context, index) {
          return EmailListItem(email: emails[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComposeEmailPage()),
          );
        },
        tooltip: 'Compose',
        child: Icon(Icons.edit),
      ),
    );
  }
}

class Email {
  final String sender;
  final String subject;
  final String body;
  final String time;
  final bool isRead;
  final Color avatarColor;

  Email({
    required this.sender,
    required this.subject,
    required this.body,
    required this.time,
    required this.isRead,
    required this.avatarColor,
  });
}

class EmailListItem extends StatelessWidget {
  final Email email;

  const EmailListItem({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: email.avatarColor,
        child: Text(
          email.sender[0],
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        email.sender,
        style: TextStyle(
          fontWeight: email.isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            email.subject,
            style: TextStyle(
              fontWeight: email.isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          Text(email.body),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            email.time,
            style: TextStyle(
              color: email.isRead ? Colors.black : Colors.blue,
              fontWeight: email.isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          if (!email.isRead)
            Icon(
              Icons.star_border,
              color: Colors.grey,
            ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmailDetailPage(email: email),
          ),
        );
      },
    );
  }
}

class EmailDetailPage extends StatelessWidget {
  final Email email;

  const EmailDetailPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email.sender),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              email.subject,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(email.body),
            SizedBox(height: 16),
            Text(
              'Time: ${email.time}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComposeEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compose Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'To',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Subject',
              ),
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  labelText: 'Body',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle send email
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailSearchDelegate extends SearchDelegate<Email> {
  final List<Email> emails;

  EmailSearchDelegate(this.emails);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = emails.where((email) {
      return email.subject.toLowerCase().contains(query.toLowerCase()) ||
          email.sender.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return EmailListItem(email: results[index]);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = emails.where((email) {
      return email.subject.toLowerCase().contains(query.toLowerCase()) ||
          email.sender.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return EmailListItem(email: suggestions[index]);
      },
    );
  }
}
