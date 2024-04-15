import { MenuEntity } from '../entity/MenuEntity'

export const TYPE_MY = 0

export const TYPE_ALL = 1

@Component
export struct MenuComponent {
  @ObjectLink menu: MenuEntity
  @Prop isEditing: boolean
  type: number = TYPE_MY
  addMenu: (menu: MenuEntity) => void = () => {

  }
  removeMenu: (menu: MenuEntity) => void = () => {

  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.TopEnd }) {
        Image(this.menu.menuIcon)
          .width(30)
          .height(30)
          .margin({ top: 11, right: 11 })
          .enabled(false)  // 这里 enabled 的作用是防止拖拽的时候单独对 Image 生效

        Image($r('app.media.ic_circle_add'))
          .width(16)
          .height(16)
          .visibility((this.type == TYPE_ALL && this.isEditing && !this.menu.isChecked) ? Visibility.Visible : Visibility.None)

        Image($r('app.media.ic_circle_remove'))
          .width(16)
          .height(16)
          .visibility(this.type == TYPE_MY ? Visibility.Visible : Visibility.None)
      }

      Text(this.menu.menuName)
        .fontColor("#999999")
        .fontSize(12)
        .margin({ top: 8 })
    }
    .padding({ top: 10, bottom: 10 })
    .onClick(() => {
      if (this.isEditing) {
        if (this.type === TYPE_MY) {
          // 我的菜单，点击移除
          this.removeMenu(this.menu)
        } else if (this.type === TYPE_ALL && !this.menu.isChecked) {
          // 所有菜单，点击添加
          this.addMenu(this.menu)
          this.menu.isChecked = true
        }
      }
    })
  }
}