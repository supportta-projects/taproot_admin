import 'package:flutter/material.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/expand_tile_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/link_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/social_media_container.dart';
import 'package:taproot_admin/features/users_screen/model/user_data_model.dart';
import 'package:taproot_admin/gen/assets.gen.dart';
import 'package:taproot_admin/services/size_utils.dart';

class SocialContainer extends StatelessWidget {
  final bool isEdit;
  const SocialContainer({super.key, this.isEdit = false, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return isEdit
        ? ExpandTileContainer(
          title: 'Social Medias',
          children: [
            LinkContainer(
              user: user,
              name: 'Facebook',
              svg: Assets.svg.facebook,
            ),
            LinkContainer(
              user: user,
              name: 'Instagram',
              svg: Assets.svg.instagram,
            ),
            LinkContainer(user: user, name: 'Twitter', svg: Assets.svg.twitter),
            LinkContainer(
              user: user,
              name: 'Pinterest',
              svg: Assets.svg.pinterest,
            ),
            LinkContainer(
              user: user,
              name: 'LinkedIn',
              svg: Assets.svg.linkdin,
            ),
            LinkContainer(user: user, name: 'Behance', svg: Assets.svg.behance),
            LinkContainer(user: user, name: 'Youtube', svg: Assets.svg.youtube),
          ],
        )
        : CommonUserContainer(
          height: SizeUtils.height * 0.20,
          title: 'Social Media ',
          children: [
            Padding(
              padding: EdgeInsets.all(CustomPadding.paddingLarge.v),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SocialMediaContainer(
                    svg: Assets.svg.facebook,
                    name: 'Facebook',
                  ),
                  SocialMediaContainer(
                    svg: Assets.svg.instagram,
                    name: 'Instagram',
                  ),
                  SocialMediaContainer(
                    svg: Assets.svg.twitter,
                    name: 'Twitter',
                  ),
                  SocialMediaContainer(
                    svg: Assets.svg.behance,
                    name: 'Behance',
                  ),
                  SocialMediaContainer(
                    svg: Assets.svg.linkdin,
                    name: 'linkdIn',
                  ),
                ],
              ),
            ),
          ],
        );
  }
}
