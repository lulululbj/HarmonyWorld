@Component
export struct NormalButton {
  text: ResourceStr = ""
  click: () => void = () => {

  }

  build() {

    Row() {
      Button(this.text)
        .type(ButtonType.Capsule)
        .layoutWeight(1)
        .onClick(() => {
          this.click()
        })
    }
    .padding({
      left: 16,
      right: 16,
      top: 8,
      bottom: 8
    })

  }
}