import { NormalButton, TitleComponent } from '@ohos/components/Index';

@Entry
@Component
export struct HspTwoPage {
  @State message: string = 'Hsp Two';
  @Consume("pathStack") appPathStack: NavPathStack

  build() {
    Column() {
      TitleComponent({
        title: this.message, onBack: () => {
          // HspTwo 和 entry 共同依赖了 NavigationManager 所在的 HAR，所以实际上存在两份实例
          // entry 中的 初始化在这里并不生效，无法使用 NavigationManager
          // 可以使用 @Provide @Consume 存取 NavPathStack
          // NavigationManager.getInstance().pop()
          this.appPathStack.pop()
        }
      })

      NormalButton({
        text: "使用 Navigation 跳转到 harOne",
        click: () => {
          this.appPathStack.pushPathByName("HarOnePage", null)
        }
      })

      NormalButton({
        text: "使用 Navigation 跳转到 harTwo",
        click: () => {
          this.appPathStack.pushPathByName("HarTwoPage", null)
        }
      })

      NormalButton({
        text: "使用 Navigation 跳转到 hspOne",
        click: () => {
          this.appPathStack.pushPathByName("HspOnePage", null)
        }
      })

      NormalButton({
        text: "使用 Navigation 跳转到 hspTwo",
        click: () => {
          this.appPathStack.pushPathByName("HspTwoPage", null)
        }
      })
    }
    .width('100%')
  }
}