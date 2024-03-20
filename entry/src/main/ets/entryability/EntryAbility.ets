import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { Router, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { Constants, EventHubConstants } from '../model/Constants';
import { FloatManager } from '@ohos/floatwindow/Index';
import { FloatPreferenceKey } from '@ohos/floatwindow/src/main/ets/model/Constants';
import { Log, PreferenceUtil } from '@ohos/utils/Index';


const TAG = "[EntryAbility]"

export default class EntryAbility extends UIAbility {
  windowClass: window.Window | null = null
  mainRouter: Router | null = null

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    Log.info(TAG, 'Ability onCreate')
    this.registerEventHub()
  }

  onDestroy(): void {
    Log.info(TAG, 'Ability onDestroy')
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    Log.info(TAG, 'Ability onWindowStageCreate')
    PreferenceUtil.getInstance().init(this.context, "HarmonyWorld")
    // 悬浮窗配置
    this.initFloatWindow(windowStage);

    // 获取主窗口
    windowStage.getMainWindow((err: BusinessError, data: window.Window) => {
      let errCode: number = err.code
      if (errCode) {
        Log.error("Failed to obtain the main window. Cause: " + JSON.stringify(err))
        return
      }
      this.windowClass = data
      // 全屏显示
      this.windowClass.setWindowLayoutFullScreen(true)
      // 获取状态栏和导航条高度
      let navigationIndicatorAvoidArea = this.windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
      let systemAvoidArea = this.windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      Constants.bottomPadding =navigationIndicatorAvoidArea.bottomRect.height
      Constants.topPadding = systemAvoidArea.topRect.height

      windowStage.loadContent('pages/Index', (err, data) => {
        if (err.code) {
          Log.error(TAG, 'Failed to load the content. Cause: ', JSON.stringify(err) ?? '')
          return;
        }
        Log.info(TAG, 'Succeeded in loading the content. Data: ', JSON.stringify(data) ?? '')
        this.mainRouter = this.windowClass!.getUIContext().getRouter()
      });
    })
  }



  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    Log.info(TAG, 'Ability onWindowStageDestroy')
  }

  onForeground(): void {
    // Ability has brought to foreground
    Log.info(TAG, 'Ability onForeground')
  }

  onBackground(): void {
    // Ability has back to background
    Log.info(TAG, 'Ability onBackground')
  }

  private registerEventHub() {
    let eventHub = this.context.eventHub
    // 悬浮窗点击事件
    eventHub.on(EventHubConstants.event_click_float, () => {
      if (this.mainRouter) {
        this.mainRouter.pushNamedRoute({
          name: "floatJumpPage"
        })
      }
    })
    // 悬浮窗返回事件
    eventHub.on(EventHubConstants.event_float_onback, () => {
      if (this.mainRouter) {
        this.mainRouter.back()
      }
    })
  }

  private initFloatWindow(windowStage: window.WindowStage) {
    let locationX = PreferenceUtil.getInstance().getNumber(FloatPreferenceKey.locationX, 200);
    let locationY = PreferenceUtil.getInstance().getNumber(FloatPreferenceKey.locationY, 200);
    FloatManager.init(windowStage, Math.floor(locationX), Math.floor(locationY));
    FloatManager.showSubWindow();
  }
}
