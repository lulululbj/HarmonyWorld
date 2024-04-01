import router from '@ohos.router';
import { NormalButton, TitleComponent } from '@ohos/components/Index';
import { NavigationManager } from '@ohos/utils/Index';
import { CusNavDestination } from './CusNavDestination';

@Entry
@Component
export struct HarHspPage {
  @State message: string = 'Hello World';

  build() {
    Column(){
      CusNavDestination({
        customBuilderParam: this.builder,
        onShow: () => {

        },
        onHidden: () => {

        }
      })
    }
  }

  @Builder
  builder() {
    Column() {

      TitleComponent({
        title: "har && hsp",
        onBack: () => {
          NavigationManager.getInstance().pop()
        }
      })

      NormalButton({
        text: "使用 router 跳转到 harOne",
        click: () => {
          router.pushNamedRoute({ name: "HarOnePage" })
        }
      })

      NormalButton({
        text: "使用 Navigation 跳转到 harTwo",
        click: () => {
          NavigationManager.getInstance().pushPathByName("HarTwoPage")
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

      NormalButton({
        text: "使用 Navigation 跳转到 hspTwo",
        click: () => {
          NavigationManager.getInstance().pushPathByName("HspTwoPage")
        }
      })
    }
  }
}