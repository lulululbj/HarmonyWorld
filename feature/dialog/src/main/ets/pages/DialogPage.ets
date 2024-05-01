import { NormalButton } from '@ohos/components/Index'
import { DeviceConstants, NavigationManager } from '@ohos/utils/Index'
import { Dialog } from '../dialog/Dialog'

@Component
export struct DialogPage {

  @State customDialogVisible: boolean = false

  build() {
    Navigation() {
      Column() {
        NormalButton({
          text: "NavDestinationMode.DIALOG 实现弹窗",
          click: () => {
            NavigationManager.getInstance().pushPathByName("NavDialog")
          }
        })

        NormalButton({
          text: "CustomDialogController 实现弹窗",
          click: () => {
            this.customDialogVisible = !this.customDialogVisible
          }
        })

        Dialog({
          visible: this.customDialogVisible,
          onCancel: () => {

          },
          onConfirm: () => {

          }
        })
      }
    }.hideTitleBar(true)
    .padding({ top: px2vp(DeviceConstants.topPadding) })
  }
}