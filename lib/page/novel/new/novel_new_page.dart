/*
 * Copyright (C) 2020. by perol_notsf, All rights reserved
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 *
 */

import 'package:flutter/material.dart';
import 'package:pixez/component/painter_avatar.dart';
import 'package:pixez/er/leader.dart';
import 'package:pixez/i18n.dart';
import 'package:pixez/main.dart';
import 'package:pixez/page/novel/bookmark/novel_bookmark_page.dart';
import 'package:pixez/page/novel/new/novel_new_list.dart';
import 'package:pixez/page/novel/user/novel_user_page.dart';

class NovelNewPage extends StatefulWidget {
  @override
  _NovelNewPageState createState() => _NovelNewPageState();
}

class _NovelNewPageState extends State<NovelNewPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AppBar(
            title: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  text: I18n.of(context).news,
                ),
                Tab(
                  text: I18n.of(context).bookmark,
                )
              ],
            ),
            actions: [
              if (accountStore.now != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.0)),
                    child: PainterAvatar(
                      url: accountStore.now!.userImage,
                      id: int.parse(accountStore.now!.userId),
                      onTap: () {
                        if (accountStore.now != null)
                          Leader.push(
                              context,
                              NovelUserPage(
                                id: int.parse(accountStore.now!.userId),
                              ));
                      },
                    ),
                  ),
                ),
            ],
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [
              NovelNewList(),
              NovelBookmarkPage(),
            ],
          )),
        ],
      ),
    );
  }
}
