import { NormalButton, TitleComponent } from '@ohos/components/Index';
import { NavigationManager } from '@ohos/utils/Index';

@Entry({ routeName: "HarTwoPage" })
@Component
export struct HarTwoPage {
  @State message: string = 'Har Two';

  build() {
    Column() {
      TitleComponent({
        title: this.message, leftClick: () => {
          NavigationManager.getInstance().pop()
        }
      })

      NormalButton({
        text: "使用 Navigation 跳转到 harOne",
        click: () => {
          NavigationManager.getInstance().pushPathByName("HarOnePage")
        }
      })

      NormalButton({
        text: "使用 Navigation 跳转到 hspOne",
        click: () => {
          NavigationManager.getInstance().pushPathByName("HspOnePage")
        }
      })

      NormalButton({
        text: "使用 Navigation 跳转到 hspTwo",
        click: () => {
          NavigationManager.getInstance().pushPathByName("HspTwoPage")
        }
      })
    }
    .width('100%')
  }
}
