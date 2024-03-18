import { NormalButton, TitleComponent } from '@ohos/components/Index'
import FloatManager from '../float/FloatManager';

@Component
export struct FloatManagerPage {
  @State message: string = 'Hello World'
  onBack: () => void = () => {

  }

  build() {
    NavDestination() {
      Column() {
        TitleComponent({
          title: "悬浮窗管理",
          onBack: this.onBack
        })
        NormalButton({
          text: "打开悬浮窗",
          click: () => {
            FloatManager.showSubWindow()
          }
        })

        NormalButton({
          text: "关闭悬浮窗",
          click: () => {
            FloatManager.destroyFloatWindow()
          }
        })
      }
    }
    .hideTitleBar(true)
  }
}
