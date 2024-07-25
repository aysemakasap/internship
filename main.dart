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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GmailHomePage(),
    );
  }
}

class GmailHomePage extends StatelessWidget {
  final List<Email> emails = [
    Email(
      sender: "Welcome to Gmail",
      subject: "Lorem ipsum dolor sit amet",
      body: "Consectetur adipiscing elit. Aenean.",
      time: "8:00 AM",
      isRead: true,
      avatarColor: Colors.purple,
    ),
    Email(
      sender: "Important Email",
      subject: "Lorem ipsum dolor sit amet",
      body: "Consectetur adipiscing elit. Aenean.",
      time: "Dec 18",
      isRead: false,
      avatarColor: Colors.purple,
    ),
    Email(
      sender: "Email with Attachment",
      subject: "Lorem ipsum dolor sit amet",
      body: "Consectetur adipiscing elit. Aenean.",
      time: "8:00 AM",
      isRead: false,
      avatarColor: Colors.lightBlue,
      hasAttachment: true,
    ),
    Email(
      sender: "Email with Multiple Attachments",
      subject: "Lorem ipsum dolor sit amet",
      body: "Consectetur adipiscing elit. Aenean.",
      time: "8:00 AM",
      isRead: false,
      avatarColor: Colors.purple,
      hasAttachment: true,
      attachmentCount: 2,
    ),
    Email(
      sender: "With reply, me 10",
      subject: "Lorem ipsum dolor sit amet",
      body: "Consectetur adipiscing elit. Aenean.",
      time: "8:00 AM",
      isRead: false,
      avatarColor: Colors.lightBlue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search in mail'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Text('B'),
            ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComposeEmailPage()),
          );
        },
        label: Text('Compose'),
        icon: Icon(Icons.edit),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Mail',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'Meet',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
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
  final bool hasAttachment;
  final int attachmentCount;

  Email({
    required this.sender,
    required this.subject,
    required this.body,
    required this.time,
    required this.isRead,
    required this.avatarColor,
    this.hasAttachment = false,
    this.attachmentCount = 0,
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
          if (email.hasAttachment)
            Row(
              children: [
                Icon(Icons.attachment),
                Text('Image_file.png'),
                if (email.attachmentCount > 1) ...[
                  Text(' +${email.attachmentCount - 1}'),
                ],
              ],
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
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}

