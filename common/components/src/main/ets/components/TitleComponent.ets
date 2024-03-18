import router from '@ohos.router'

@Component
export struct TitleComponent {
  @Prop title: string | Resource = ""
  @Prop showBackIcon: boolean = true
  @Prop topPadding: number = 0
  onBack: () => void = () => {
    router.back()
  }

  build() {
    Row() {
      Image($r('app.media.ic_public_back'))
        .width(24)
        .height(24)
        .visibility(this.showBackIcon ? Visibility.Visible : Visibility.Hidden)
        .onClick(() => {
          this.onBack()
        })


      Text(this.title)
        .fontSize(20)
        .fontColor($r('app.color.black'))
        .maxLines(1)
        .position({ x: '50%' })
        .markAnchor({ x: '50%' })
    }
    .width('100%')
    .padding({
      left: 16,
      right: 16,
      top: this.topPadding,
      bottom: 16,
    })
  }
}

@Preview
@Component
struct TitleComponentPreview {
  build() {
    TitleComponent({
      title: 'Title'
    })
  }
}