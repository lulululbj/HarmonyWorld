import { ObservedArray } from '@ohos/utils/Index'
import { MenuEntity } from '../entity/MenuEntity'

@Component
export struct MyMenuComponent {
  @ObjectLink menuList: ObservedArray<MenuEntity>
  changeEditStatus: () => void = () => {
  }

  build() {
    Row() {
      Text("首页应用")
        .fontSize(18)
        .fontColor($r('app.color.black'))

      List({ space: 2 }) {
        ForEach(this.menuList, (item: MenuEntity) => {
          ListItem() {
            Image(item.menuIcon)
              .width(20)
              .height(20)
          }
        }, (item: MenuEntity) => {
          return item.menuName
        })
      }
      .margin({ left: 8, right: 8 })
      .listDirection(Axis.Horizontal)
      .alignListItem(ListItemAlign.Center)
      .layoutWeight(1)

      Button("编辑")
        .height(26)
        .fontSize(16)
        .onClick(() => {
          this.changeEditStatus()
        })
    }
    .height(48)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .margin(16)
    .padding({ left: 16, right: 16 })
  }
}