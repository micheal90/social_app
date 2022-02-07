import 'package:flutter/material.dart';
import 'package:social_app/shared/constants.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Card(
              margin: const EdgeInsets.all(8),
              elevation: 10,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg',
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => PostWidget(),
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 8,
            ),
          )
        ],
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://as2.ftcdn.net/v2/jpg/02/42/00/09/1000_F_242000990_peOX8nxSnyxotZjMUzmsR5KV3ZDwgCtM.jpg'),
                    radius: 24,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Micheal Hana',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: FittedBox(
                                  child: Icon(
                                Icons.done,
                                color: Colors.white,
                              )),
                            )
                          ],
                        ),
                        Text(
                          'January 21,2022 at 10.00 pm',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 20,
                      ))
                ],
              ),
            ),
            Divider(),
            Text(
                'Lorem elit aliquip amet anim eu eiusmod sint quis labore culpa minim deserunt ipsum aliqua. Est ullamco non nisi et sit non ex do enim. Labore minim ipsum cupidatat laborum culpa magna sint consectetur ea id labore. Velit id culpa incididunt magna consequat est eiusmod officia enim qui voluptate irure voluptate. Qui qui dolor minim mollit anim nostrud non. Ea nostrud eiusmod minim aute ipsum ex irure eu reprehenderit magna nulla dolore.'),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 2,
                children: [
                  MaterialButton(
                    minWidth: 1,
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Text(
                      '#Software',
                      style: TextStyle(color: KPrimaryColor),
                    ),
                  ),
                  MaterialButton(
                    minWidth: 1,
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Text(
                      '#Software',
                      style: TextStyle(color: KPrimaryColor),
                    ),
                  ),
                  MaterialButton(
                    minWidth: 1,
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Text(
                      '#Software',
                      style: TextStyle(color: KPrimaryColor),
                    ),
                  ),
                  MaterialButton(
                    minWidth: 1,
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Text(
                      '#Software_pevelopment',
                      style: TextStyle(color: KPrimaryColor),
                    ),
                  ),
                  MaterialButton(
                    minWidth: 1,
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Text(
                      '#Software_pevelopment',
                      style: TextStyle(color: KPrimaryColor),
                    ),
                  ),
                  MaterialButton(
                    minWidth: 1,
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Text(
                      '#Software_pevelopment',
                      style: TextStyle(color: KPrimaryColor),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.zero,
              elevation: 3,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                'https://as2.ftcdn.net/v2/jpg/02/42/00/09/1000_F_242000990_peOX8nxSnyxotZjMUzmsR5KV3ZDwgCtM.jpg',
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_border_rounded,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '1200',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.textsms_outlined,
                              color: KPrimaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '120 comments',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://as2.ftcdn.net/v2/jpg/02/42/00/09/1000_F_242000990_peOX8nxSnyxotZjMUzmsR5KV3ZDwgCtM.jpg'),
                            radius: 20,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Write a comment ...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.share_rounded,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Share',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
