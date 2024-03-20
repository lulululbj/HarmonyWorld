import { bundleManager, common, Context, UIAbility, Want } from '@kit.AbilityKit'
import { BusinessError } from '@kit.BasicServicesKit'
import Log from './Log'

class AppUtils {
  static getAppVersionCode(): number {
    try {
      let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION | bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA
      let bundleInfo = bundleManager.getBundleInfoForSelfSync(bundleFlags)
      return bundleInfo.versionCode
    } catch (err) {
      return 0
    }
  }

  static getAppVersionName(): string {
    try {
      let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION | bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA
      let bundleInfo = bundleManager.getBundleInfoForSelfSync(bundleFlags)
      return bundleInfo.versionName
    } catch (err) {
      return ""
    }
  }

  static jumpBrowser(context: common.UIAbilityContext, url: string) {
    let wantInfo: Want = {
      action: "ohos.want.action.viewData",
      entities: ["entity.system.browsable"],
      uri: url
    }
    context.startAbility(wantInfo).then(() => {
    }).catch((err: BusinessError) => {
      Log.error('jumpBrowser error: ' + err.message)
    })
  }
}