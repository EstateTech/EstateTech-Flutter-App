import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:web3modal_flutter/constants/string_constants.dart';
import 'package:web3modal_flutter/models/w3m_chain_info.dart';
import 'package:web3modal_flutter/services/explorer_service/explorer_service_singleton.dart';
import 'package:web3modal_flutter/services/w3m_service/i_w3m_service.dart';
import 'package:web3modal_flutter/theme/constants.dart';
import 'package:web3modal_flutter/theme/w3m_theme.dart';
import 'package:web3modal_flutter/utils/asset_util.dart';
import 'package:web3modal_flutter/widgets/buttons/base_button.dart';
import 'package:web3modal_flutter/widgets/icons/rounded_icon.dart';

class CustomNetworkButton extends StatelessWidget {
  const CustomNetworkButton({
    super.key,
    this.size = BaseButtonSize.regular,
    this.serviceStatus = W3MServiceStatus.idle,
    this.chainInfo,
    this.onTap,
  });
  final W3MChainInfo? chainInfo;
  final BaseButtonSize size;
  final W3MServiceStatus serviceStatus;
  final VoidCallback? onTap;

  String _getImageUrl(W3MChainInfo chainInfo) {
    if (chainInfo.chainIcon != null && chainInfo.chainIcon!.contains('http')) {
      return chainInfo.chainIcon!;
    }
    final chainImageId = AssetUtil.getChainIconId(chainInfo.chainId);
    return explorerService.instance!.getAssetImageUrl(chainImageId);
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = Web3ModalTheme.colorsOf(context);
    final imageUrl = chainInfo != null ? _getImageUrl(chainInfo!) : null;
    final radiuses = Web3ModalTheme.radiusesOf(context);
    final borderRadius = radiuses.isSquare() ? 0.0 : size.height / 1;
    return TextButton(
      onPressed: serviceStatus.isInitialized ? onTap : null,
      child: Container(
        height: 60.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.white.withOpacity(0.4), // shadow color
            //   spreadRadius: 1, // spread radius
            //   blurRadius: 4, // blur radius
            //   offset: Offset(0, 3), // changes position of shadow
            // )
          ],
        ),
        width: double.infinity,
        padding: EdgeInsets.all(2.w),
        child: Text(
          chainInfo?.chainName ??
              (size == BaseButtonSize.small
                  ? StringConstants.selectNetworkShort
                  : 'Connect your Wallet'),
          textAlign: TextAlign.center,
          style: style.copyWith(
              color: mainAppColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
