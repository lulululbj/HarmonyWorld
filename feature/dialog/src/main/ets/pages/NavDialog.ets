import { NormalButton } from '@ohos/components/Index'
import { NavigationManager } from '@ohos/utils/Index'

@Component
export struct NavDialog {
  build() {
    NavDestination() {
      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(Color.Gray)
          .opacity(0.1)
          .onClick(() => {
            NavigationManager.getInstance().pop()
          })
        Column() {
          Text("标题")
            .fontColor(Color.Black)
            .fontSize(20)

          NormalButton({
            text: "确认", click: () => {
              NavigationManager.getInstance().pop()
            }
          })

          NormalButton({
            text: "取消", click: () => {
              NavigationManager.getInstance().pop()
            }
          })
        }
        .padding(10)
        .width(250)
        .backgroundColor(Color.White)
        .borderRadius(10)
      }
    }.hideTitleBar(true)
    .mode(NavDestinationMode.DIALOG)
  }
}