import { Log, ObservedArray } from '@ohos/utils/Index'
import { MenuEntity } from '../entity/MenuEntity'
import { MenuComponent, TYPE_MY } from './MenuComponent'

@Component
export struct MyMenuEditComponent {
  @ObjectLink menuList: ObservedArray<MenuEntity>
  @State dragIndex: number = -1;
  @State dragEnd: boolean = true
  removeMenu: (menu: MenuEntity) => void = () => {

  }

  build() {
    Column() {
      Text("我的应用")
        .fontSize(16)
        .fontColor($r('app.color.black'))
        .height(36)
        .width('100%')
        .textAlign(TextAlign.Start)

      List() {
        ForEach(this.menuList, (item: MenuEntity, index: number) => {
          ListItem() {
            MenuComponent({
              menu: item,
              isEditing: true,
              type: TYPE_MY,
              removeMenu: this.removeMenu
            })
              .visibility(this.checkDragVisible(index))
          }
          .width('100%')
        }, (item: MenuEntity) => item.menuName)
      }
      .lanes(5)
      .onItemDragStart((event: ItemDragInfo, index: number) => {
        Log.info("drag", `onItemDragStart: ${event} ${index}`)
        this.dragEnd = false
        this.dragIndex = index
        return this.dragBuilder(this.menuList[index])
      })
      .onItemDragMove((event: ItemDragInfo, itemIndex: number, insertIndex: number) => {
        if (insertIndex >= this.menuList.length) {
          return
        }
        if (this.dragIndex == insertIndex) {
          return
        }
        Log.info("drag", `onItemMove: ${itemIndex} ${insertIndex}`)
        this.changeIndex(this.dragIndex, insertIndex)
        this.dragIndex = insertIndex
      })
      .onItemDrop((event: ItemDragInfo, itemIndex: number, insertIndex: number, isSuccess) => {
        Log.error("drag", `onItemDrop: ${itemIndex} ${insertIndex} ${isSuccess}`)
        this.dragEnd = true
      })
    }.backgroundColor($r('app.color.white'))
    .borderRadius(16)
    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
    .margin(16)
  }

  @Builder
  dragBuilder(menu: MenuEntity) {
    MenuComponent({ menu: menu, isEditing: false })
      .width(80)
      .height(80)
  }

  changeIndex(fromIndex: number, toIndex: number) {
    const menu = this.menuList[fromIndex]
    this.menuList[fromIndex] = this.menuList[toIndex]
    this.menuList[toIndex] = menu
  }

  checkDragVisible(index: number) {
    if (this.dragEnd) {
      return Visibility.Visible
    } else {
      return index === this.dragIndex ? Visibility.Hidden : Visibility.Visible
    }
  }
}