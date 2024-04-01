@Component
export struct CusNavDestination {
  @Builder
  customBuilder() {
  }

  @BuilderParam customBuilderParam: () => void = this.customBuilder
  onShow: () => void = () => {

  }
  onHidden: () => void = () => {

  }

  build() {
    NavDestination() {
      this.customBuilderParam()
    }.hideTitleBar(true)
    .onShown(() => {
      this.onShow()
    })
    .onHidden(() => {
      this.onHidden()
    })
  }
}