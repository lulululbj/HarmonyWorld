import { MyCustomDialog } from './MyCustomDialog';

@Component
export struct Dialog {
  @Watch("onChange") @Link visible: boolean
  onCancel?: () => void
  onConfirm?: () => void
  // 通过CustomDialogController的builder参数绑定弹窗组件MyCustomDialog
  private controller? = new CustomDialogController({
    builder: MyCustomDialog({
      visible: $visible,
      onCancel: this.onCancel,
      onConfirm: this.onConfirm
    })
  })

  onChange() {
    if (this.visible) {
      this.open()
    } else {
      this.close()
    }
  }

  open() {
    this.controller?.open()
  }

  close() {
    this.controller?.close()
  }

  build() {
  }
}