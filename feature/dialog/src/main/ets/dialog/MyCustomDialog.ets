// 自定义弹窗需要使用@CustomDialog装饰器
@CustomDialog
export struct MyCustomDialog {
  @Link visible: boolean
  // 被@CustomDialog装饰器修饰的组件必须持有CustomDialogController类型属性参数
  controller: CustomDialogController;
  // 弹窗交互事件参数，点击确认和取消按钮时的回调函数
  onCancel?: () => void;
  onConfirm?: () => void;

  build() {
    Column({ space: 12 }) {
      Text("Custom dialog content!")
        .fontSize(20)
      Row() {
        Button("cancel")
          .onClick(() => {
            this.visible = false
            this.onCancel?.();
          })
          .margin({ right: 20 })
        Button("confirm")
          .onClick(() => {
            this.visible = false
            this.onConfirm?.();
          })
      }
      .justifyContent(FlexAlign.Center)
    }
    .padding(24)
  }
}