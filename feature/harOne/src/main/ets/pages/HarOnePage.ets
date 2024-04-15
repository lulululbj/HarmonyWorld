import { NormalButton, TitleComponent } from '@ohos/components/Index';
import { router } from '@kit.ArkUI';

@Entry({ routeName: "HarOnePage" })
@Component
export struct HarOnePage {
  @State message: string = 'Har One';

  build() {
    Column() {
      TitleComponent({
        title: this.message, leftClick: () => {
          // harOne 是通过 router 跳转过来的，使用 router 返回
          router.back()
        }
      })
        .margin({ top: 50 })

      // 使用 router 跳转到的 HarOnePage，这里无法再使用 entry Index 的 Navigation
      NormalButton({
        text: "使用 router 跳转到 harTwo",
        click: () => {
          router.pushNamedRoute({ name: "HarTwoPage" })
        }
      })

      NormalButton({
        text: "使用 router 跳转到 hspOne",
        click: () => {
          router.pushUrl({
            url: "@bundle:mobile.developer.harmony/hspOne/ets/pages/HspOnePage"
          })
        }
      })
    }
    .width('100%')
  }
}
