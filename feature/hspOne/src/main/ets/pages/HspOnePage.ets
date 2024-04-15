import { router } from '@kit.ArkUI';
import { NormalButton, TitleComponent } from '@ohos/components/Index';

@Entry
@Component
export struct HspOnePage {
  @State message: string = 'Hsp One';

  build() {
    Column() {
      TitleComponent({
        title: this.message, leftClick: () => {
          // hspOne 是通过 router 跳转过来的，使用 router 返回
          router.back()
        }
      })
        .margin({ top: 50 })

      NormalButton({
        text: "使用 router 跳转到 harOne",
        click: () => {
          router.pushNamedRoute({ name: "HarOnePage" })
        }
      })

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

      // HspTwoPage 需要接收 NavPathStack,这里无法跳过去
      // NormalButton({
      //   text: "使用 router 跳转到 hspTwo",
      //   click: () => {
      //     router.pushUrl({
      //       url: "@bundle:mobile.developer.harmony/hspTwo/ets/pages/HspTwoPage"
      //     })
      //   }
      // })
    }
    .width('100%')
  }
}