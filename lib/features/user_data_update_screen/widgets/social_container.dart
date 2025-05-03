import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/expand_tile_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/link_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/social_media_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
import 'package:taproot_admin/gen/assets.gen.dart';
import 'package:taproot_admin/services/size_utils.dart';

class SocialContainer extends StatelessWidget {
  final PortfolioDataModel? portfolio;
  final bool isEdit;
  const SocialContainer({
    super.key,
    this.isEdit = false,
    required this.user,
    this.portfolio,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    final hasSocialMediaLinks =
        portfolio?.socialMedia.any((item) => item.link.isNotEmpty) ?? false;
    return isEdit
        ? hasSocialMediaLinks
            ? ExpandTileContainer(
              title: 'Social Medias',
              children:
                  portfolio!.socialMedia.map((item) {
                    return LinkContainer(
                      user: user,
                      name: _capitalize(
                        item.source,
                      ), 
                      svg: _getSvgForPlatform(
                        item.source,
                      ), 
                      initaialValue:
                          item.link, 
                    );
                  }).toList(),
            )
            : ExpandTileContainer(
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
                LinkContainer(
                  user: user,
                  name: 'Twitter',
                  svg: Assets.svg.twitter,
                ),
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
                LinkContainer(
                  user: user,
                  name: 'Behance',
                  svg: Assets.svg.behance,
                ),
                LinkContainer(
                  user: user,
                  name: 'Youtube',
                  svg: Assets.svg.youtube,
                ),
              ],
            )
        : hasSocialMediaLinks
        ? CommonUserContainer(
          height: SizeUtils.height * 0.25,
          title: 'Social Media ',
          children: [
            Gap(CustomPadding.paddingXL.v),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Wrap(
                  spacing: 5.0,
                  runSpacing: 28.0,
                  alignment: WrapAlignment.start,
                  children:
                      portfolio!.socialMedia.map((item) {
                        return Container(
                          constraints: BoxConstraints(maxWidth: 250),
                          child: SocialMediaContainer(
                            svg: _getSvgForPlatform(item.source),
                            name: _capitalize(item.source),
                            link: item.link,
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        )
        : SizedBox();
  }
}

String _getSvgForPlatform(String platform) {
  switch (platform.toLowerCase()) {
    case 'facebook':
      return Assets.svg.facebook;
    case 'instagram':
      return Assets.svg.instagram;
    case 'twitter':
      return Assets.svg.twitter;
    case 'pinterest':
      return Assets.svg.pinterest;
    case 'linkedin':
      return Assets.svg.linkdin;
    case 'behance':
      return Assets.svg.behance;
    case 'youtube':
      return Assets.svg.youtube;
    case 'github':
      return Assets.svg.pinterest;

    default:
      return Assets.svg.link;
  }
}

String _capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}
