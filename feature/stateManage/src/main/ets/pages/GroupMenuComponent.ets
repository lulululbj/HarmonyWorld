import { ObservedArray } from '@ohos/utils/Index'
import { MenuEntity, MenuGroupEntity } from '../entity/MenuEntity'
import { MenuComponent, TYPE_ALL } from './MenuComponent'

@Component
export struct GroupMenuComponent {
  @ObjectLink menuGroupData: ObservedArray<MenuGroupEntity>
  @Prop isEditing: boolean
  addMenu: (menu: MenuEntity) => void = () => {

  }

  build() {
    List({ space: 16 }) {
      ForEach(this.menuGroupData, (item: MenuGroupEntity) => {
        ListItem() {
          Column() {
            Text(item.groupName)
              .fontSize(16)
              .fontColor($r('app.color.black'))
              .height(36)
              .width('100%')
              .textAlign(TextAlign.Start)

            List() {
              ForEach(item.menuList, (item: MenuEntity) => {
                ListItem() {
                  MenuComponent({
                    menu: item,
                    isEditing: this.isEditing,
                    type: TYPE_ALL,
                    addMenu: this.addMenu
                  })
                }
                .width('100%')
              }, (item: MenuEntity) => item.menuName)
            }.lanes(5)
          }
        }
        .width('100%')
        .backgroundColor($r('app.color.white'))
        .borderRadius(16)
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      }, (item: MenuGroupEntity) => item.groupName)
    }
    .margin(16)
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }
}