import 'package:faker/faker.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/helpers/helpers.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../../models/models.dart';
import '../../widgets/widgets.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const SliverToBoxAdapter(
        child: _Story(),
      ),
      SliverList(delegate: SliverChildBuilderDelegate((context, index) {
        DateTime date = randomDate();
        return _MessageCard(
          messageData: MessageData(
            name: faker.person.name(),
            message: faker.lorem.sentence(),
            profilePicture: randomImageUrl(),
            messageDate: date,
            dateMessage: Jiffy.parseFromDateTime(date).fromNow(),
          ),
        );
      }))
    ]);
  }
}

class _MessageCard extends StatefulWidget {
  const _MessageCard({super.key, required this.messageData});
  final MessageData messageData;
  @override
  State<_MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<_MessageCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/chat', arguments: widget.messageData);
      },
      child: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: Avatar.medium(
                      imageUrl: widget.messageData.profilePicture),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.messageData.name,
                        style: kHeadingStyle1(
                            fontSize: 16,
                            color: Theme.of(context).primaryColorDark),
                        overflow: TextOverflow.ellipsis,
                      ),

                      // const SizedBox(height: 4),
                      const SizedBox(
                        height: 4.0,
                      ),
                      SizedBox(
                        height: 20.0,
                        child: Text(
                          widget.messageData.message,
                          style: kBodyStyle2(
                              color: Theme.of(context).primaryColorDark),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 14.0, bottom: 14.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(widget.messageData.dateMessage.toUpperCase(),
                          style: kBodyStyle1(
                              fontSize: 10,
                              color: Theme.of(context).primaryColorDark)),
                      const SizedBox(
                        height: 8.0,
                      ),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Center(
                          child: Text('1',
                              style:
                                  kMetadataStyle1(fontSize: 12, color: kWhite)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                color: Theme.of(context).disabledColor,
                height: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Story extends StatelessWidget {
  const _Story({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 134,
      child: Card(
				elevation: 0,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Stories',
                  style: kHeadingStyle1(
                      fontSize: 18, color: Theme.of(context).primaryColorDark)),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return _StoryCard(
                        storyData: StoryData(
                            name: faker.person.firstName(),
                            url: randomImageUrl()));
                  },
                  scrollDirection: Axis.horizontal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({super.key, required this.storyData});
  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Avatar.medium(imageUrl: storyData.url),
        const SizedBox(height: 8),
        Text(storyData.name,
            style: kBodyStyle1(color: Theme.of(context).primaryColorDark)),
      ]),
    );
  }
}
