import { DeviceConstants, StringUtil } from '@ohos/utils/Index'

@Component
export struct TitleComponent {
  @Prop title: string | Resource = ""
  @Prop leftImageRes: Resource | null = $r('app.media.ic_public_back')
  @Prop rightImageRes: Resource | null = null
  @Prop leftText: string | null = null
  @Prop rightText: string | null = null
  topPadding: number = DeviceConstants.topPadding
  bgColor: ResourceColor = $r('app.color.white')
  leftClick: () => void = () => {
  }
  rightClick: () => void = () => {

  }
  leftAlign: Record<string, Record<string, string | VerticalAlign | HorizontalAlign>> = {
    'top': { 'anchor': '__container__', 'align': VerticalAlign.Top },
    'left': { 'anchor': '__container__', 'align': HorizontalAlign.Start },
    'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom }
  }
  rightAlign: Record<string, Record<string, string | VerticalAlign | HorizontalAlign>> = {
    'top': { 'anchor': '__container__', 'align': VerticalAlign.Top },
    'right': { 'anchor': '__container__', 'align': HorizontalAlign.End },
    'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom }
  }
  centerAlign: Record<string, Record<string, string | VerticalAlign | HorizontalAlign>> = {
    'top': { 'anchor': '__container__', 'align': VerticalAlign.Top },
    'left': { 'anchor': 'leftLayout', 'align': HorizontalAlign.End },
    'right': { 'anchor': 'rightLayout', 'align': HorizontalAlign.Start },
    'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom }
  }

  build() {

    Column() {
      Blank().height(px2vp(DeviceConstants.topPadding))
      RelativeContainer() {

        Stack({ alignContent: Alignment.Start }) {
          Image(this.leftImageRes)
            .width(24)
            .height(24)
            .visibility(this.leftImageRes ? Visibility.Visible : Visibility.None)


          Text(this.leftText)
            .fontSize(16)
            .fontColor("#bdd6f7")
            .visibility(StringUtil.isEmpty(this.leftText) ? Visibility.None : Visibility.Visible)
        }
        .width(48)
        .onClick(() => {
          this.leftClick()
        })
        .id("leftLayout")
        .alignRules(this.leftAlign)


        Text(this.title)
          .fontSize(20)
          .fontColor($r('app.color.black'))
          .maxLines(1)
          .textAlign(TextAlign.Center)
          .alignRules(this.centerAlign)
          .id("title")

        Stack({ alignContent: Alignment.End }) {
          Image(this.rightImageRes)
            .width(24)
            .height(24)
            .visibility(this.rightImageRes !== null ? Visibility.Visible : Visibility.None)

          Text(this.rightText)
            .fontSize(16)
            .fontColor("#579cfe")
            .visibility(StringUtil.isEmpty(this.rightText) ? Visibility.None : Visibility.Visible)
            .onClick(() => {
              this.rightClick()
            })
        }
        .width(48)
        .id("rightLayout")
        .alignRules(this.rightAlign)
        .onClick(() => {
          this.rightClick()
        })

      }
      .width('100%')
      .height(48)
      .padding({
        left: 16,
        right: 16,
      })
    }
    .backgroundColor(this.bgColor)
  }
}

@Preview
@Component
struct TitleComponentPreview {
  build() {
    Column() {
      TitleComponent({
        title: 'Title',
        rightImageRes: $r('app.media.ic_public_back')
      })

      Blank().height(10)

      TitleComponent({
        title: 'Title'
      })

      Blank().height(10)

      TitleComponent({
        title: 'Title',
      })

      Blank().height(10)

      TitleComponent({
        title: 'Title',
        rightText: '相册'
      })

      Blank().height(10)

      TitleComponent({
        leftText: '取消',
        rightText: '完成'
      })

      Blank().height(10)

    }
  }
}