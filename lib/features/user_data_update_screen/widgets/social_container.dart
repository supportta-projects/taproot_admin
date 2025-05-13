// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:taproot_admin/constants/constants.dart';
// import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
// import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
// import 'package:taproot_admin/features/user_data_update_screen/widgets/expand_tile_container.dart';
// import 'package:taproot_admin/features/user_data_update_screen/widgets/link_container.dart';
// import 'package:taproot_admin/features/user_data_update_screen/widgets/social_media_container.dart';
// import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
// import 'package:taproot_admin/gen/assets.gen.dart';
// import 'package:taproot_admin/services/size_utils.dart';

// class SocialContainer extends StatelessWidget {
//     final ValueChanged<List<SocialMedia>>? onLinksChanged;

//   final PortfolioDataModel? portfolio;
//   final bool isEdit;
//   const SocialContainer({
//     super.key,
//     this.isEdit = false,
//     required this.user,
//     this.portfolio,
//     this.onLinksChanged,
//   });
//   final User user;

//   @override
//   Widget build(BuildContext context) {
//     final hasSocialMediaLinks =
//         portfolio?.socialMedia.any((item) => item.link.isNotEmpty) ?? false;
//     return isEdit
//         ? hasSocialMediaLinks
//             ? ExpandTileContainer(
//               title: 'Social Media',
//               children:
//                   portfolio!.socialMedia.map((item) {
//                     return LinkContainer(
//                       user: user,
//                       name: _capitalize(item.source),

//                       svg: _getSvgForPlatform(item.source),
//                       initaialValue: item.link,
//                     );
//                   }).toList(),
//             )
//             : ExpandTileContainer(
//               title: 'Social Medias',
//               children: [
//                 LinkContainer(
//                   user: user,
//                   name: 'Facebook',
//                   svg: Assets.svg.facebook,
//                 ),
//                 LinkContainer(
//                   user: user,
//                   name: 'Instagram',
//                   svg: Assets.svg.instagram,
//                 ),
//                 LinkContainer(
//                   user: user,
//                   name: 'Twitter',
//                   svg: Assets.svg.twitter,
//                 ),
//                 LinkContainer(
//                   user: user,
//                   name: 'Pinterest',
//                   svg: Assets.svg.pinterest,
//                 ),
//                 LinkContainer(
//                   user: user,
//                   name: 'LinkedIn',
//                   svg: Assets.svg.linkdin,
//                 ),
//                 LinkContainer(
//                   user: user,
//                   name: 'Behance',
//                   svg: Assets.svg.behance,
//                 ),
//                 LinkContainer(
//                   user: user,
//                   name: 'Youtube',
//                   svg: Assets.svg.youtube,
//                 ),
//               ],
//             )
//         : hasSocialMediaLinks
//         ? CommonUserContainer(
//           height: SizeUtils.height * 0.25,
//           title: 'Social Media ',
//           children: [
//             Gap(CustomPadding.paddingXL.v),
//             SizedBox(
//               width: double.infinity,
//               child: Center(
//                 child: Wrap(
//                   spacing: 5.0,
//                   runSpacing: 28.0,
//                   alignment: WrapAlignment.start,
//                   children:
//                       portfolio!.socialMedia.map((item) {
//                         return Container(
//                           constraints: BoxConstraints(maxWidth: 250),
//                           child: SocialMediaContainer(
//                             svg: _getSvgForPlatform(item.source),
//                             name: _capitalize(item.source),
//                             link: item.link,
//                           ),
//                         );
//                       }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         )
//         : SizedBox();
//   }
// }

// String _getSvgForPlatform(String platform) {
//   switch (platform.toLowerCase()) {
//     case 'facebook':
//       return Assets.svg.facebook;
//     case 'instagram':
//       return Assets.svg.instagram;
//     case 'twitter':
//       return Assets.svg.twitter;
//     case 'pinterest':
//       return Assets.svg.pinterest;
//     case 'linkedin':
//       return Assets.svg.linkdin;
//     case 'behance':
//       return Assets.svg.behance;
//     case 'youtube':
//       return Assets.svg.youtube;
//     case 'github':
//       return Assets.svg.github;

//     default:
//       return Assets.svg.link;
//   }
// }

// String _capitalize(String text) {
//   if (text.isEmpty) return text;
//   return text[0].toUpperCase() + text.substring(1);
// }

// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:taproot_admin/constants/constants.dart';
// import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
// import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
// import 'package:taproot_admin/features/user_data_update_screen/widgets/expand_tile_container.dart';
// import 'package:taproot_admin/features/user_data_update_screen/widgets/link_container.dart';
// import 'package:taproot_admin/features/user_data_update_screen/widgets/social_media_container.dart';
// import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
// import 'package:taproot_admin/gen/assets.gen.dart';
// import 'package:taproot_admin/services/size_utils.dart';

// class SocialContainer extends StatelessWidget {
//   final ValueChanged<List<SocialMedia>>? onLinksChanged;
//   final PortfolioDataModel? portfolio;
//   final bool isEdit;
//   final User user;

//   const SocialContainer({
//     super.key,
//     this.isEdit = false,
//     required this.user,
//     this.portfolio,
//     this.onLinksChanged,
//   });

//   static final List<String> _allSocialPlatforms = [
//     'facebook',
//     'instagram',
//     'twitter',
//     'pinterest',
//     'linkedin',
//     'behance',
//     'youtube',
//     'github',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final hasSocialMediaLinks =
//         portfolio?.socialMedia.any((item) => item.link.isNotEmpty) ?? false;

//     return isEdit
//         ? ExpandTileContainer(
//           title: 'Social Media',
//           children:
//               _allSocialPlatforms.map((platform) {
//                 final existingItem = portfolio?.socialMedia.firstWhere(
//                   (item) => item.source.toLowerCase() == platform.toLowerCase(),
//                   orElse: () => SocialMedia(source: platform, link: '', id: ''),
//                 );

//                 return LinkContainer(
//                   user: user,
//                   name: _capitalize(platform),
//                   svg: _getSvgForPlatform(platform),
//                   initaialValue: existingItem!.link,
//                 );
//               }).toList(),
//         )
//         : hasSocialMediaLinks
//         ? CommonUserContainer(
//           height: SizeUtils.height * 0.25,
//           title: 'Social Media',
//           children: [
//             Gap(CustomPadding.paddingXL.v),
//             SizedBox(
//               width: double.infinity,
//               child: Center(
//                 child: Wrap(
//                   spacing: 5.0,
//                   runSpacing: 28.0,
//                   alignment: WrapAlignment.start,
//                   children:
//                       portfolio!.socialMedia.map((item) {
//                         return Container(
//                           constraints: const BoxConstraints(maxWidth: 250),
//                           child: SocialMediaContainer(
//                             svg: _getSvgForPlatform(item.source),
//                             name: _capitalize(item.source),
//                             link: item.link,
//                           ),
//                         );
//                       }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         )
//         : const SizedBox();
//   }

//   String _getSvgForPlatform(String platform) {
//     switch (platform.toLowerCase()) {
//       case 'facebook':
//         return Assets.svg.facebook;
//       case 'instagram':
//         return Assets.svg.instagram;
//       case 'twitter':
//         return Assets.svg.twitter;
//       case 'pinterest':
//         return Assets.svg.pinterest;
//       case 'linkedin':
//         return Assets.svg.linkdin;
//       case 'behance':
//         return Assets.svg.behance;
//       case 'youtube':
//         return Assets.svg.youtube;
//       case 'github':
//         return Assets.svg.github;
//       default:
//         return Assets.svg.link;
//     }
//   }

//   String _capitalize(String text) {
//     if (text.isEmpty) return text;
//     return text[0].toUpperCase() + text.substring(1);
//   }
// }
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/expand_tile_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/social_media_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
import 'package:taproot_admin/gen/assets.gen.dart';
import 'package:taproot_admin/services/size_utils.dart';
import 'link_container.dart';

class SocialContainer extends StatefulWidget {
  final ValueChanged<List<SocialMedia>>? onLinksChanged;
  final PortfolioDataModel? portfolio;
  final bool isEdit;
  final User user;

  const SocialContainer({
    super.key,
    this.isEdit = false,
    required this.user,
    this.portfolio,
    this.onLinksChanged,
  });

  @override
  State<SocialContainer> createState() => _SocialContainerState();
}

class _SocialContainerState extends State<SocialContainer> {
  final List<String> platforms = [
    'facebook',
    'instagram',
    'twitter',
    'pinterest',
    'linkedin',
    'behance',
    'youtube',
    'github',
  ];

  late List<SocialMedia> socialLinks;

  @override
  void initState() {
    super.initState();
    socialLinks = widget.portfolio?.socialMedia ?? [];

    for (final platform in platforms) {
      if (!socialLinks.any((e) => e.source == platform)) {
        socialLinks.add(SocialMedia(source: platform, link: '', id: ''));
      }
    }
  }

  void _updateLink(SocialMedia updatedLink) {
    setState(() {
      final index = socialLinks.indexWhere(
        (e) => e.source == updatedLink.source,
      );
      if (index != -1) {
        socialLinks[index] = updatedLink;
      } else {
        socialLinks.add(updatedLink);
      }
    });

    widget.onLinksChanged?.call(socialLinks);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isEdit) {
      final visibleLinks = socialLinks.where((e) => e.link.isNotEmpty).toList();
      if (visibleLinks.isEmpty) return const SizedBox();
      return CommonUserContainer(
        height: SizeUtils.height * 0.25,
        title: 'Social Media',
        children: [
          Gap(CustomPadding.paddingXL.v),
          Center(
            child: Wrap(
              spacing: 5,
              runSpacing: 28,
              alignment: WrapAlignment.start,
              children:
                  visibleLinks
                      .map(
                        (item) => Container(
                          constraints: const BoxConstraints(maxWidth: 250),
                          child: SocialMediaContainer(
                            svg: _getSvgForPlatform(item.source),
                            name: _capitalize(item.source),
                            link: item.link,
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      );
    }

    return ExpandTileContainer(
      title: 'Social Media',
      children:
          socialLinks
              .map(
                (item) => LinkContainer(
                  user: widget.user,
                  name: _capitalize(item.source),
                  source: item.source,
                  svg: _getSvgForPlatform(item.source),
                  initaialValue: item.link,
                  onChanged: (newLink) {
                    _updateLink(
                      SocialMedia(
                        source: item.source,
                        link: newLink,
                        id: item.id,
                      ),
                    );
                  },
                ),
              )
              .toList(),
    );
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
      return Assets.svg.github;
    default:
      return Assets.svg.link;
  }
}

String _capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}
