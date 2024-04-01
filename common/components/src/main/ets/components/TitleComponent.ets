import { DeviceConstants } from '@ohos/utils/Index'

@Component
export struct TitleComponent {
  @Prop title: string | Resource = ""
  @Prop showBackIcon: boolean = true
  @Prop topPadding: number = DeviceConstants.topPadding
  @Prop bgColor: Resource = $r('app.color.white')
  onBack: () => void = () => {

  }

  build() {
    Column() {
      RelativeContainer() {
        Image($r('app.media.ic_public_back'))
          .width(24)
          .height(24)
          .visibility(this.showBackIcon ? Visibility.Visible : Visibility.Hidden)
          .id("left")
          .alignRules({
            "top": { "anchor": "__container__", "align": VerticalAlign.Top },
            "bottom": { "anchor": "__container__", "align": VerticalAlign.Bottom },
            "left": { "anchor": "__container__", "align": HorizontalAlign.Start },
          })
          .onClick(() => {
            this.onBack()
          })


        Text(this.title)
          .fontSize(20)
          .fontColor($r('app.color.black'))
          .maxLines(1)
          .alignRules({
            "top": { "anchor": "__container__", "align": VerticalAlign.Top },
            "bottom": { "anchor": "__container__", "align": VerticalAlign.Bottom },
            "left": { "anchor": "left", "align": HorizontalAlign.End },
            "right": { "anchor": "right", "align": HorizontalAlign.Start },
          })
          .textAlign(TextAlign.Center)
          .id("title")

        Image($r('app.media.ic_public_back'))
          .width(24)
          .height(24)
          .visibility(Visibility.Hidden)
          .id("right")
          .alignRules({
            "top": { "anchor": "__container__", "align": VerticalAlign.Top },
            "bottom": { "anchor": "__container__", "align": VerticalAlign.Bottom },
            "right": { "anchor": "__container__", "align": HorizontalAlign.End },
          })
          .onClick(() => {
            this.onBack()
          })
      }
      .width('100%')
      .height(48)
      .padding({
        left: 16,
        right: 16,
      })
    }.padding({ top: `${this.topPadding}px` })
    .backgroundColor(this.bgColor)
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